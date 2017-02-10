require 'rails_helper'

RSpec.describe Order::Group::Image, type: :model do
  describe "validation" do
    it { should have_attached_file(:img) }
    it { should validate_attachment_presence(:img) }
    it { should validate_attachment_content_type(:img).
                  allowing("image/png", "image/gif").
                  rejecting("text/plain", "text/xml")}
  end
end
