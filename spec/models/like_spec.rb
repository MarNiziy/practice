require 'rails_helper'
RSpec.describe Like, type: :model do 

	subject {build (:like)}

	it{is_expected.to belong_to(:user)}
	it{is_expected.to belong_to(:post)}

	it{is_expected.to validate_uniqueness_of(:user_id).scoped_to(:post_id)}
end