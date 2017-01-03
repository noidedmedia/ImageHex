FactoryGirl.define do
  factory :order_reference_group_image, class: 'Order::ReferenceGroup::Image' do
    reference { create(:order_reference_group) }
    description { Faker::Lorem.paragraph }
    img do
      path = Rails.root.join("spec", "fixtures", "files", "test.jpg")
      Rack::Test::UploadedFile.new(path, "image/jpeg")
    end
  end
end
