require 'rails_helper'
RSpec.describe LikesController, type: :controller do 
	let(:user) {create :user}
	let(:params) { {user_id: user} }

	before {sign_in user}

	describe '#create' do
		let!(:post) {create :post, user: user}
		let(:params) do
			{
				user_id: user.id,
				post_id: post.id,
			}
		end

		subject {process :create, method: :post, params: params}
	
		it 'create like' do
			expect{subject}.to change {Like.count}.by(1)
			is_expected.to redirect_to(user_post_path(assigns(:user), assigns(:post)))
		end
	end

	describe '#destroy' do
		let!(:post) {create :post, user: user}
		let!(:like) {create :like, post: post, user: user}
		let(:params) { {post_id: post.id, user_id: user.id, id: like} }

		subject {delete :destroy, params: params}

		it 'destroy like' do
			expect{subject}.to change {Like.count}.by(-1)
			is_expected.to redirect_to(user_post_path(assigns(:user), assigns(:post)))
		end
	end
end