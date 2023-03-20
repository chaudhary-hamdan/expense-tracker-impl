class ExpenseReportsController < ApplicationController
    before_action :set_expense_report, only: %i[show edit update destroy]

    def index
        begin
            authorize ExpenseReport
            @q = ExpenseReport.ransack(params[:q])
            @expense_reports = @q.result(distinct: true)
        rescue 
            render :file => 'public/404.html'
        end
    end
    
    def new
        begin
            @expense_report = ExpenseReport.new
            authorize @expense_report
        rescue 
            render :file => 'public/404.html'
        end
    end

    def create
        begin
            @expense_report = ExpenseReport.new(expense_report_params)
            authorize @expense_report

            if @expense_report.save
                redirect_to expense_reports_path, notice: 'ExpenseReport has been created successfully!'
            else
                render :new
            end
        rescue 
            render :file => 'public/404.html'
        end
    end

    def show
        begin
            authorize @expense_report
            if params[:des] != nil
                nm = @expense_report.employee.name
                if current_user.admin
                    nm = "Admin"
                end
                if @expense_report.comments.build(name: nm, description: params[:des]).save
                    ExpenseExpenseReportStatusChangeMailer.comment_added_notification.deliver_now!
                    redirect_to expense_report_path(@expense_report), notice: 'Comment Added'
                else
                    render :new
                end
            elsif params[:cd] != nil && params[:amt] != nil && params[:desc] != nil && params[:invid] != nil
                res = invoice_validator_system_response(params[:invid])
                if @expense_report.expenses.build(creation_date:params[:cd], amount: params[:amt], description: params[:desc], invoice_id: params[:invid], status: res).save
                    if res == 'Submitted for Approval'
                        @expense_report.total_amount += params[:amt].to_i
                        @expense_report.save
                    end
                    redirect_to expense_report_path(@expense_report), notice: 'Expense Added'
                else
                    render :new
                end
            end
        rescue 
            render :file => 'public/404.html'
        end
    end

    def edit
        begin
            authorize @expense_report
        rescue 
            render :file => 'public/404.html'
        end
    end

    def update
        begin
            authorize @expense_report
            if @expense_report.update(expense_report_params)
                if expense_report_params[:status] == 'Approved'
                    ExpenseExpenseReportStatusChangeMailer.approved_notification.deliver_now!
                elsif expense_report_params[:status] == 'Partially Approved'
                    ExpenseExpenseReportStatusChangeMailer.partially_approved_notification.deliver_now!
                elsif expense_report_params[:status] == 'Rejected'
                    ExpenseExpenseReportStatusChangeMailer.rejected_notification.deliver_now!
                end
                redirect_to expense_report_path(@expense_report), notice: 'ExpenseReport has been updated successfully!'
            else
                render :edit
            end
        rescue 
            render :file => 'public/404.html'
        end
    end

    def destroy
        begin
            authorize @expense_report
            @emp = @expense_report.employee
            @expense_report.destroy
            redirect_to employee_path(@emp), notice: 'ExpenseReport has been deleted successfully!'
        rescue 
            render :file => 'public/404.html'
        end
    end


    private

    def expense_report_params
        params.require(:expense_report).permit(:creation_date, :total_amount, :description, :status)
    end

    def set_expense_report
        @expense_report = ExpenseReport.find(params[:id])
    end

end
