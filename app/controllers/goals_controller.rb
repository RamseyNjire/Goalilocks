class GoalsController < ApplicationController
    before_action :require_current_user!

    def new
    end
end
