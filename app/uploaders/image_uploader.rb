class ImageUploader < Shrine
	plugin :cached_attachment_data
	plugin :default_url
	plugin :validation_helpers
	plugin :determine_mime_type

	Attacher.validate do
    	validate_extension %w[jpg jpeg png webp]
  	end

	Attacher.default_url do |**options|
 	  	"/placeholders/missing.jpg"
    end
end

