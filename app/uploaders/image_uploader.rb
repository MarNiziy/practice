class ImageUploader < Shrine
	plugin :cached_attachment_data
	plugin :default_url

	Attacher.default_url do |**options|
 	  "/placeholders/missing.jpg"
    end
  # plugins and uploading logic
end

