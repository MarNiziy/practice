require 'rails_helper'
RSpec.describe PostsController, type: :controller do 
	let(:user) {create :user}
	let(:params) { {user_id: user} }

	before {sign_in user}

	describe '#index' do
		subject {get :index, params: params}

		let!(:post) {create :post, user: user}

		it 'assigns @posts' do
			subject
			expect(assigns(:posts)).to eq([post])
		end

		it {is_expected.to render_template('index')}
	end

	describe '#show' do
		let(:params) { {user_id: user.id, id: post} }
		subject {get :show, params: params}

		let!(:post) {create :post, user: user}

		it 'assigns @posts' do
			subject
			expect(assigns(:post)).to eq(post)
		end

		it {is_expected.to render_template(:show)}

		context 'when user tries to see someone elses post' do
			let!(:post) {create :post}
			it {expect {subject}.to raise_error(ActiveRecord::RecordNotFound)}
		end
	end

	describe '#new' do
		subject {get :new, params: params}

		context 'when user signed in' do
			before {sign_in user}

			it {is_expected.to render_template(:new)}

			it 'assigns new post' do
				subject
				expect(assigns(:post)).to be_a_new Post
			end
		end
	end

	describe '#create' do
		let(:params) do
			{
				user_id: user.id,
				post: attributes_for(:post)
			}
		end

		subject {post :create, params: params}

		it 'create post' do
			expect{subject}.to change {Post.count}.by(1)
			is_expected.to redirect_to(user_post_path(assigns(:current_user), assigns(:post)))
		end

		context 'when params invalid' do
			let(:params) do
				{
					user_id: user.id,
					post: {title: nil}
				}
			end

			it {is_expected.to render_template(:new)}
			it {expect{subject}.not_to change {Post.count}}
		end
	end

	describe '#edit' do
		let!(:post) {create :post, user: user}
		let(:params) { {user_id: user, id: post} }

		subject {process :edit, method: :get, params: params}

		it {is_expected.to render_template(:edit)}

		it 'assigns server policy' do
			subject
			expect(assigns :post).to eq post
		end
	end

	describe '#update' do
		let!(:post) {create :post, user: user}
		let(:params) { {user_id: user, id: post, post: {title: 'Some title'} } }

		subject {put :update, params: params}

		it {is_expected.to redirect_to(user_post_path(assigns(:current_user), assigns(:post))) }

		it 'update post' do
			expect{subject}.to change {post.reload.title}.to('Some title')
		end

		context 'when params invalid' do
			let(:params) do
				{
					user_id: user,
					id: post,
					post: {title: ''}
				}
			end

			it 'does not update post' do
				expect{subject}.not_to change {post.reload.title}
			end
		end
	end

	describe '#destroy' do
		let!(:post) {create :post, user: user}
		let(:params) { {user_id: user, id: post} }

		subject {delete :destroy, params: params}


		it 'destroy post' do
			expect{subject}.to change {Post.count}.by(-1)
			is_expected.to redirect_to(action: :index)
		end
	end
end

