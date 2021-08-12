class CommentsController < ApplicationController
    before_action :require_current_user!
    before_action :set_comment, only: %i[edit update destroy]
    before_action :require_comment_owner!, only: %i[edit update destroy]
    
    def create
        @commentable = find_commentable
        @comment = @commentable.comments.build(comment_params)

        if @comment.save
            redirect_to_commentable(@commentable)
        else
            flash[:errors] = @comment.errors.full_messages
            redirect_to_commentable(@commentable)
        end
    end

    def edit
        render :edit
    end

    def update
        if @comment.update_attributes(comment_params)
            redirect_to_commentable(@commentable)
        else
            flash[:errors] = @comment.errors.full_messages
            redirect_to_commentable(@commentable)
        end
    end

    def destroy
        @comment.destroy!

        redirect_to_commentable(@commentable)
    end


    private

    def set_comment
        @comment = Comment.find_by(id: params[:id])
        @commentable = @comment.commentable
    end

    def require_comment_owner!
        set_comment
        redirect_to new_session_url unless @comment.writer == current_user
    end
    

    def find_commentable
        params.each do |name, value|
            if name =~ /(.+)_id$/
                return $1.classify.constantize.find(value)
            end
        end
        nil
    end

    def comment_params
        params.require(:comment).permit(:body, :user_id, :commentable_type, :commentable_id)
    end

    def redirect_to_commentable(commentable)
        if commentable.class == User
            redirect_to user_url(commentable)
        else
            redirect_to goal_url(commentable)
        end
    end
end
