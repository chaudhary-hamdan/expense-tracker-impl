class CommentsController < ApplicationController

    before_action :set_comment, only: %i[show edit update destroy]

    def index
        begin
            authorize Comment
            @comments = Comment.all
        rescue 
            render :file => 'public/404.html'
        end
    end
    
    def new
        begin
            @comment = Comment.new
            authorize @comment
        rescue 
            render :file => 'public/404.html'
        end
    end

    def create()
        begin
            @comment = Comment.new(comment_params)
            authorize @comment

            if @comment.save
                ExpenseExpenseReportStatusChangeMailer.comment_added_notification.deliver_now!
                redirect_to comments_path, notice: 'Comment has been created successfully!'
            else
                render :new
            end
        rescue 
            render :file => 'public/404.html'
        end
    end

    def show
        begin
            authorize @comment
        rescue 
            render :file => 'public/404.html'
        end
    end

    def edit
        begin
            authorize @comment
        rescue 
            render :file => 'public/404.html'
        end
    end

    def update
        begin
            authorize @comment
            if @comment.update(comment_params)
                redirect_to comment_path(@comment), notice: 'Comment has been updated successfully!'
            else
                render :edit
            end
        rescue 
            render :file => 'public/404.html'
        end
    end

    def destroy
        begin
            authorize @comment
            @er = @comment.expense_report
            @comment.destroy
            redirect_to expense_report_path(@er), notice: 'Comment has been deleted successfully!'
        rescue 
            render :file => 'public/404.html'
        end
    end


    private

    def comment_params
        params.require(:comment).permit(:name, :description)
    end

    def set_comment
        @comment = Comment.find(params[:id])
    end


end
