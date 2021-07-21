require 'rails_helper'
RSpec.describe Comment, type: :model do 

	subject {build (:comment)}

	it{is_expected.to belong_to(:post)}
	it{is_expected.to belong_to(:user)}
end