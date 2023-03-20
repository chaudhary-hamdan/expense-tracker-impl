class ExpensePolicy < ApplicationPolicy
    attr_reader :user, :expense

    def initialize(user, expense)
        @user = user
        @expense = expense
    end

    def index?
        @user.admin?
    end

    def show?
        # puts "=============================#{@user.email}"
        @user.admin? || ((@expense.employee != nil) && (@user.email == @expense.employee.email)) || ((@expense.expense_report != nil) && (@user.email == @expense.expense_report.employee.email))
    end
  def create?
    @user.admin
  end

  def new?
    create?
  end

  def update?
    @user.admin? || @expense.status == 'Submitted for Approval'
  end

  def edit?
    update?
  end

  def destroy?
    @user.admin? || ((@expense.employee != nil) && (@user.email == @expense.employee.email)) || ((@expense.expense_report != nil) && (@user.email == @expense.expense_report.employee.email))
  end



end
