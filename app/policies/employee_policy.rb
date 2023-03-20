class EmployeePolicy < ApplicationPolicy
    attr_reader :user, :employee

    def initialize(user, employee)
        @user = user
        @employee = employee #|| Employee
    end

    def index?
        @user.admin?
    end

    def show?
        # puts "=============================#{@user.email}"
        @user.admin? || @user.email == @employee.email
    end
  def create?
    @user.admin
  end

  def new?
    create?
  end

  def update?
    @user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    @user.admin
  end



end
