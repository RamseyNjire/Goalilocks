class GoalsController < ApplicationController
    before_action :require_current_user!

    def new
        @goal = Goal.new
    end

    def create
        @goal = Goal.new(goal_params)

        if @goal.save
            redirect_to goal_url(@goal)
        else
            flash[:errors] = @goal.errors.full_messages
            render :new
        end
    end

    def show
        @goal = Goal.find_by(id: params[:id])
        render :show
    end

    def edit
        @goal = Goal.find_by(id: params[:id])
        render :edit
    end


    private

    def goal_params
        params.require(:goal).permit(:title, :description, :is_complete, :is_private, :creator_id)
    end
end
