FactoryBot.define do 
	factory :user do
		name {Faker::Name.name}
		email {Faker::Internet.email}
		username {Faker::FunnyName.name}
		password {'password'}
		password_confirmation {'password'}
		image {Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/impix.png'))}

		trait(:with_invalid_image) do
			image {Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/txtpix.txt'))}
		end
	end
end