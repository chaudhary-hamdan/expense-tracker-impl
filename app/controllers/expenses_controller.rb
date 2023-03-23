class ExpensesController < ApplicationController

    before_action :set_expense, only: %i[show edit update destroy]

    def index
        begin
            authorize Expense
            @q = Expense.where(expense_report_id:nil).ransack(params[:q])
            @expenses = @q.result(distinct: true)
        rescue 
            render :file => 'public/404.html'
        end
    end
    
    def new
        begin
            @expense = Expense.new
            authorize @expense
        rescue 
            render :file => 'public/404.html'
        end
    end

    def create
        begin
            @expense = Expense.new(expense_params)
            authorize @expense_report

            @expense.status = invoice_validator_system_response(@expense.invoice_id)

            if @expense.save
                redirect_to expenses_path, notice: 'Expense has been created successfully!'
            else
                render :new
            end
        rescue 
            render :file => 'public/404.html'
        end
    end

    def show
        begin
            authorize @expense
        rescue 
            render :file => 'public/404.html'
        end
    end

    def edit
        begin
            authorize @expense
        rescue 
            render :file => 'public/404.html'
        end
    end

    def update
        begin
            authorize @expense
            amt = @expense.amount
            if @expense.update!(expense_params)
                if @expense.expense_report != nil
                    @expense.expense_report.total_amount -= amt - @expense.total_amount
                end
                @expense.status = invoice_validator_system_response(@expense.invoice_id)
                
                if @expense.update!(expense_params)
                    if expense_params[:status] == 'Approved'
                        ExpenseExpenseReportStatusChangeMailer.approved_notification.deliver_now!
                    elsif expense_params[:status] == 'Rejected'
                        if @expense.expense_report != nil
                            @expense.expense_report.total_amount -= @expense.amount
                            @expense.expense_report.save
                        end

                        ExpenseExpenseReportStatusChangeMailer.rejected_notification.deliver_now!
                    end
                    redirect_to expense_path(@expense), notice: 'Expense has been updated successfully!'
                else
                    render :edit
                end
            else
                render :edit
            end
        rescue 
            render :file => 'public/404.html'
        end
    end

    def destroy
        begin
            authorize @expense
            amt = @expense.amount
            sts = @expense.status
            @er = @expense.expense_report
            @emp = @expense.employee
            @expense.destroy
            if @er != nil
                if sts != 'Rejected'
                    @er.total_amount -= amt
                    @er.save
                end
                redirect_to expense_report_path(@er), notice: 'Expense has been deleted successfully!'
            else
                redirect_to employee_path(@emp), notice: 'Expense has been deleted successfully!'
            end
        rescue 
            render :file => 'public/404.html'
        end
    end


    private

    def expense_params
        params.require(:expense).permit(:invoice_id, :creation_date, :amount, :description, :status, :invoice_image)
    end

    def set_expense
        @expense = Expense.find(params[:id])
    end



end
