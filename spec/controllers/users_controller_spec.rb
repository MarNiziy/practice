require 'rails_helper'
RSpec.describe UsersController, type: :controller do 
	let(:user) {create :user}
	let(:params) { {id: user} }

	before {sign_in user}

	describe '#index' do
		subject {get :index, params: params}

		context 'when user signed in' do
			before {sign_in user}

			it {is_expected.to render_template(:index)}

			it 'assigns @users' do
				subject
				expect(assigns(:users)).to eq([user])
			end
		end
	end

	describe '#show' do
		subject {get :show, params: params}

		it 'assigns @users' do
			subject
			expect(assigns(:user)).to eq(user)
		end

		it {is_expected.to render_template(:show)}
	end

	describe '#edit' do
		subject {process :edit, method: :get, params: params}

		it {is_expected.to render_template(:edit)}

		it 'assigns server policy' do
			subject
			expect(assigns :user).to eq user
		end
	end

	describe '#update' do
		let(:params) { {id: user, user: {username: 'New username'} } }

		subject {put :update, params: params}

		it {is_expected.to redirect_to(user_path(assigns(:user))) }

		it 'update user' do
			expect{subject}.to change {user.reload.username}.to('New username')
		end

		context 'when params invalid' do
			let(:params) { {id: user, user: {username: ''} } }

			it 'does not update user' do
				expect{subject}.not_to change {user.reload.username}
			end
		end
	end
end