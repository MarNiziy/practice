require 'rails_helper'
RSpec.describe CommentsController, type: :controller do 
	let(:user) {create :user}
	let(:params) { {user_id: user} }

	before {sign_in user}

	describe '#create' do
		let!(:post) {create :post, user: user}
		let(:params) do
			{
				user_id: user.id,
				post_id: post.id,
				comment: attributes_for(:comment)
			}
		end

		subject {process :create, method: :post, params: params}
	
		it 'create comment' do
			expect{subject}.to change {Comment.count}.by(1)
			is_expected.to redirect_to(user_post_path(assigns(:user), assigns(:post)))
		end

		context 'when params invalid' do
			let(:params) do
				{
					user_id: user.id,
					post_id: post.id,
					comment: {content: nil}
				}
			end

			it {expect{subject}.not_to change {Comment.count}}
		end
	end

	describe '#destroy' do
		let!(:post) {create :post, user: user}
		let!(:comment) {create :comment, post: post, user: user}
		let(:params) { {post_id: post.id, user_id: user.id, id: comment} }

		subject {delete :destroy, params: params}

		it 'destroy comment' do
			expect{subject}.to change {Comment.count}.by(-1)
			is_expected.to redirect_to(user_post_path(assigns(:user), assigns(:post)))
		end
	end
end