module Paperclip
  def self.run cmd, arguments = "", interpolation_values = {}, local_options = {}
    cmd == 'convert' ? nil : super
  end
end

class Paperclip::Attachment
  def post_process
  end
end
