require 'rails_helper'
RSpec.describe Follow, type: :model do 

	subject {build (:follow)}

	it{is_expected.to belong_to(:follower).class_name('User').with_foreign_key('follower_id')}
	it{is_expected.to belong_to(:following).class_name('User').with_foreign_key('following_id')}
end