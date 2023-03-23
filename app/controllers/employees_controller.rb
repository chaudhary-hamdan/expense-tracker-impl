require 'logger'

logger = Logger.new(STDOUT)
logger.level = Logger::WARN

class EmployeesController < ApplicationController

    
    before_action :set_employee, only: %i[show edit update destroy]


    def index
        begin
            authorize Employee
            logger.info("#{current_user} logged in. Fetching emplloyees")
            @employees = Employee.all
            logger.info("Employees fetch for user #{current_user}")
        rescue Pundit::NotAuthorizedError => e
            logger.error("User is not active or logged in #{e.inspect}")
            render :file => 'public/404.html'
        end
    end
    
    def new
        begin
            @employee = Employee.new
            authorize @employee
        rescue 
            render :file => 'public/404.html'
        end
    end

    def create
        begin
            @employee = Employee.new(employee_params)
            authorize @employee

            if @employee.save
                render ('json_renders/show')
            else
                render :new
            end
        rescue 
            render :file => 'public/404.html'
        end
    end

    def show
        begin
            authorize @employee

            if params[:cd] != nil && params[:amt] != nil && params[:desc] != nil && params[:invid] != nil
                if @employee.expenses.build(creation_date:params[:cd], amount: params[:amt], description: params[:desc], invoice_id: params[:invid], status: invoice_validator_system_response(params[:invid])).save
                    render ('json_renders/show') #json renders using jbuilder for uisng jsons render
                else
                    render :new
                end
            elsif params[:excd] != nil && params[:exdesc] != nil
                if @employee.expense_reports.build(creation_date:params[:excd], total_amount: 0, description: params[:exdesc], status: 'Submitted for Approval').save
                    render ('json_renders/show')
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
            authorize @employee
        rescue 
            render :file => 'public/404.html'
        end
    end

    def update
        begin
            authorize @employee
            if @employee.update!(employee_params)
                redirect_to employee_path(@employee), notice: 'Employee has been updated successfully!'
            else
                render :edit
            end
        rescue 
            render :file => 'public/404.html'
        end
    end

    def destroy
        begin
            authorize @employee
            @employee.expense_reports.each do |expense_report|
                expense_report.destroy
            end
            @employee.destroy
            redirect_to employees_path, notice: 'Employee has been deleted successfully!'
        rescue 
            render :file => 'public/404.html'
        end
    end


    private

    def employee_params
        params.require(:employee).permit(:name, :email, :employment_status, :department)
    end

    def set_employee
        @employee = Employee.find(params[:id])
    end

    
end
