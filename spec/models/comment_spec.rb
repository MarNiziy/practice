require 'rails_helper'
RSpec.describe Comment, type: :model do 

	subject {build (:comment)}

	it{is_expected.to belong_to(:post)}
	it{is_expected.to belong_to(:user)}

	it{is_expected.to validate_presence_of(:content)}
	it{is_expected.to validate_length_of(:content).is_at_most(200)}
end