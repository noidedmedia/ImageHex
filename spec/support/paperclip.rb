module Paperclip
  mattr_accessor :is_in_feature_spec
  def self.run cmd, arguments = "", interpolation_values = {}, local_options = {}
    if self.is_in_feature_spec
      super
    else
      cmd == 'convert' ? nil : super
    end
  end
end

module PrependPaperclip
  def post_process
    if Paperclip.is_in_feature_spec
      super
    else
      nil
    end
  end
end

class Paperclip::Attachment
  prepend PrependPaperclip
end
