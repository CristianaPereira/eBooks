module Attachable
  def attach_file!(file_param, association, file_key)
    if file_param.is_a?(String) && file_param.start_with?("data:")
      attach_base64_file!(file_param, association, file_key)
    else
      attach_form_file!(file_param, association, file_key)
    end
  end

  def attach_base64_file!(base64_file, association, file_key)
    mime_type = base64_file.split(",").first.split(";").first.split(":").last
    base64_data = base64_file.split(",").last
    decoded_base64 = Base64.decode64(base64_data)
    extension = Rack::Mime::MIME_TYPES.invert[mime_type]
    filename = [ SecureRandom.uuid, extension ].join
    self.send(association).attach(
      key: "#{file_key}#{filename}",
      io: StringIO.new(decoded_base64),
      filename: filename,
      content_type: mime_type
    )
  end

  def attach_form_file!(file, association, file_key)
    original_filename = file.original_filename
    file_extension = File.extname(original_filename)
    filename = [ SecureRandom.uuid, file_extension ].join
    self.send(association).attach(
      key: "#{file_key}#{filename}",
      io: file,
      filename: filename,
    )
  end
end
