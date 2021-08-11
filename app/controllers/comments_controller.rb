class CommentsController < ApplicationController
    before_action :require_current_user!
    
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
    end


    private

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
