require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
    subject(:goal){ build(:goal) }
    let(:user){ create(:user) }
    before(:each) { allow(controller).to receive(:current_user){ user } }

    describe "GET #new" do
        context "when logged in" do
            it "renders the new template" do
                get :new
                expect(response).to render_template(:new)
            end
        end

        context "when not logged in" do
            before { allow(controller).to receive(:current_user){ nil } }
            it "redirects to the login page" do
                get :new
                expect(response).to redirect_to(new_session_url)
            end
        end
    end

    describe "POST #create" do
        context "with valid params" do
            it "redirects to the goal show page" do
                post :create, params: { goal: {
                                                title: "Test Goal",
                                                description: "test goal",
                                                is_complete: false,
                                                is_private: false,
                                                creator_id: user.id
                } }

                test_goal = Goal.find_by(title: "Test Goal")
                expect(response).to redirect_to(goal_url(test_goal))
            end
        end

        context "with invalid params" do
            it "renders the new page" do
                post :create, params: { goal: {
                                                description: "test goal"
                } }

                expect(response).to render_template(:new)
                expect(flash[:errors]).to be_present
            end
        end
    end
end
