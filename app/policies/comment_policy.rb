class CommentPolicy < ApplicationPolicy
    attr_reader :user, :comment

    def initialize(user, comment)
        @user = user
        @comment = comment
    end

    def index?
        @user.admin?
    end

    def show?
        # puts "=============================#{@user.email}"
        @user.admin? || @user.email == @comment.expense_report.employee.email
    end
  def create?
    @user.admin
  end

  def new?
    create?
  end

  def update?
    @user.admin? || @user.email == @comment.expense_report.employee.email
  end

  def edit?
    update?
  end

  def destroy?
    @user.admin? || @user.email == @comment.expense_report.employee.email
  end



end
