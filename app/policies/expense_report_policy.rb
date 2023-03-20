class ExpenseReportPolicy < ApplicationPolicy
    attr_reader :user, :expense_report

    def initialize(user, expense_report)
        @user = user
        @expense_report = expense_report
    end

    def index?
        @user.admin?
    end

    def show?
        # puts "=============================#{@user.email}"
        @user.admin? || @user.email == @expense_report.employee.email
    end
  def create?
    @user.admin
  end

  def new?
    create?
  end

  def update?
    @user.admin? || @expense_report.status == 'Submitted for Approval'
  end

  def edit?
    update?
  end

  def destroy?
    @user.admin? || @user.email == @expense_report.employee.email
  end



end
