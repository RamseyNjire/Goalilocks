require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
    subject(:user_comment){ build(:comment, :for_user) }
    subject(:goal_comment){ build(:comment, :for_goal) }
    let(:comment_writer){ create(:comment_writer) }
    let(:commented_user){ create(:commented_user) }
    let(:goal){ create(:commented_goal) }
    let(:each) { allow(controller).to receive(:current_user){ user } }

    describe "POST #create" do
        context "commenting on a user" do
            context "with valid params" do
                it "redirects to the user show page" do
                    post :create, params: {
                                            user_id: commented_user.id,
                                            comment: {
                                                body: "This is a test comment",
                                                user_id: comment_writer.id,
                                                commentable_type: "User",
                                                commentable_id: commented_user.id
                                            }
                    }

                    expect(commented_user.comments.count).to eq(1)
                    expect(response).to redirect_to(user_url(commented_user))
                end
            end
        end
    end

end
