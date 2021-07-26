require 'rails_helper'
RSpec.describe Post, type: :model do 
	it{is_expected.to belong_to(:user)}
	it{is_expected.to have_many(:comments)}
	it{is_expected.to have_many(:likes)}

	it{is_expected.to validate_presence_of(:title)}
	it{is_expected.to validate_length_of(:title).is_at_most(100)}
	it{is_expected.to validate_presence_of(:body)}

	context 'validates image format' do
		it 'allows to set png file as an image' do
			user = create(:user)
			subject.attributes = attributes_for(:post)
			subject.user = user
			is_expected.to be_valid
		end

		it 'allows to set png file as an image' do
			user = create(:user)
			subject.attributes = attributes_for(:post, :with_invalid_image)
			subject.user = user
			is_expected.to be_invalid
		end
	end
end