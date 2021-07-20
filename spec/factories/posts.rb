FactoryBot.define do 
	factory :post do
		association :user
		
		title {Faker::Book.title}
		body {Faker::Lorem.sentence}
		image {Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/impix.png'))}

		trait(:with_invalid_image) do
			image {Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/txtpix.txt'))}
		end
	end
end