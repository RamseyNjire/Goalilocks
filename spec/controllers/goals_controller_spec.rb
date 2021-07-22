require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
    subject(:goal){ build(:goal) }
    let(:user){ build(:user) }
    describe "GET #new" do
        context "when logged in" do
            before do
                user.save!
                allow(controller).to receive(:current_user){ user }
            end

            it "renders the new template" do
                get :new
                expect(response).to render_template(:new)
            end
        end

        context "when not logged in" do
            it "redirects to the login page" do
                get :new
                expect(response).to redirect_to(new_session_url)
            end
        end
    end
end
