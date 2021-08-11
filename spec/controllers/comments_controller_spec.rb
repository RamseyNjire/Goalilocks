require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
    subject(:user_comment){ build(:comment, :for_user) }
    subject(:goal_comment){ build(:comment, :for_goal) }
    let(:comment_writer){ create(:comment_writer) }
    let(:commented_user){ create(:commented_user) }
    let(:goal){ create(:commented_goal) }
    before(:each) { allow(controller).to receive(:current_user){ comment_writer } }

    describe "POST #create" do
        context "commenting on a user" do
            context "when logged in" do
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
                context "with invalid params" do
                    it "redirects to the user show page with an error message" do
                        post :create, params: {
                                                user_id: commented_user.id,
                                                comment: {
                                                    user_id: comment_writer.id,
                                                    commentable_type: "User",
                                                    commentable_id: commented_user.id
                                                }
                        }                    

                        expect(commented_user.comments.count).to eq(0)
                        expect(response).to redirect_to(user_url(commented_user))
                        expect(flash[:errors]).to be_present
                    end
                end                
            end
            context "when not logged in" do
                before { allow(controller).to receive(:current_user){ nil } }
                it "redirects to the login page" do
                    post :create, params: {
                                            user_id: commented_user.id,
                                            comment: {
                                                body: "This is a test comment",
                                                user_id: comment_writer.id,
                                                commentable_type: "User",
                                                commentable_id: commented_user.id
                                            }
                    }
                    expect(response).to redirect_to(new_session_url)
                end
            end
        end
        context "commenting on a goal" do
            context "when logged in" do
                context "with valid params" do
                    it "redirects to the goal show page" do
                        post :create, params: {
                                                goal_id: goal.id,
                                                comment: {
                                                    body: "This is a test comment",
                                                    user_id: comment_writer.id,
                                                    commentable_type: "Goal",
                                                    commentable_id: goal.id
                                                }
                        }

                        expect(goal.comments.count).to eq(1)
                        expect(response).to redirect_to(goal_url(goal))
                    end
                end
                
                context "with invalid params" do
                    it "redirects to the goal show page with an error message" do
                        post :create, params: {
                                                goal_id: goal.id,
                                                comment: {
                                                    user_id: comment_writer.id,
                                                    commentable_type: "Goal",
                                                    commentable_id: goal.id
                                                }
                        }                    

                        expect(goal.comments.count).to eq(0)
                        expect(response).to redirect_to(goal_url(goal))
                        expect(flash[:errors]).to be_present
                    end
                end
            end
            context "when not logged in" do
                before { allow(controller).to receive(:current_user){ nil } }
                it "redirects to the login page" do
                    post :create, params: {
                                            goal_id: goal.id,
                                            comment: {
                                                body: "This is a test comment",
                                                user_id: comment_writer.id,
                                                commentable_type: "Goal",
                                                commentable_id: goal.id
                                            }
                    }
                    expect(response).to redirect_to(new_session_url)
                end
            end
        end
    end

    describe "GET #edit" do
        context "when logged in" do
            before do
                user_comment.save!
                goal_comment.save!
            end
            it "renders the edit template" do
                get :edit, params: { id: user_comment.id }
                expect(response).to render_template(:edit)
                get :edit, params: { id: goal_comment.id }
                expect(response).to render_template(:edit)
            end
        end

        context "when not logged in" do
            before do
                user_comment.save!
                goal_comment.save!
                allow(controller).to receive(:current_user){ nil }
            end
            it "redirects to the login page" do
                get :edit, params: { id: user_comment.id }
                expect(response).to redirect_to(new_session_url)
                get :edit, params: { id: goal_comment.id }
               expect(response).to redirect_to(new_session_url)
            end
        end
        
    end

    describe "PATCH #update" do
        before do
            user_comment.save!
            goal_comment.save!
        end
        context "when logged in" do
            context "updating a user comment" do
                it "redirects to the user show page" do
                    patch :update, params: {
                                            id: user_comment.id,
                                            comment: {
                                                body: "This is an updated comment"
                                            }
                    }
                    expect(response).to redirect_to(user_url(user_comment.commentable))
                end
            end

            context "updating a goal comment" do
                it "redirects to the goal show page" do
                    patch :update, params: {
                                            id: goal_comment.id,
                                            comment: {
                                                body: "This is an updated comment"
                                            }
                    }
                    expect(response).to redirect_to(goal_url(goal_comment.commentable))
                end
            end
        end

        context "when not logged in" do
            before { allow(controller).to receive(:current_user){ nil } }

            it "redirects to the login page" do
                    patch :update, params: {
                                            id: user_comment.id,
                                            comment: {
                                                body: "This is an updated comment"
                                            }
                    }
                    expect(response).to redirect_to(new_session_url)

                    patch :update, params: {
                                            id: goal_comment.id,
                                            comment: {
                                                body: "This is an updated comment"
                                            }
                    }
                    expect(response).to redirect_to(new_session_url)
            end
        end
    end

    describe "delete #destroy" do
        before do
            user_comment.save!
            goal_comment.save!
        end

        context "when logged in" do
            it "redirects to the user show page" do
                delete :destroy, params: { id: user_comment.id }

                expect(Comment.find_by(id: user_comment.id)).to be nil
                expect(response).to redirect_to(user_url(user_comment.commentable))
            end

            it "redirects to the goal show page" do
                delete :destroy, params: { id: goal_comment.id }

                expect(Comment.find_by(id: goal_comment.id)).to be nil
                expect(response).to redirect_to(goal_url(goal_comment.commentable))    
            end
        end

        context "when not logged in" do
            before { allow(controller).to receive(:current_user){ nil } }
            it "redirects to the login page" do
                delete :destroy, params: { id: user_comment.id }
                expect(response).to redirect_to(new_session_url)

                delete :destroy, params: { id: goal_comment.id }
                expect(response).to redirect_to(new_session_url)
            end
        end
    end

end
