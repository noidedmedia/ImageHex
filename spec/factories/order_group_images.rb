FactoryGirl.define do
  factory :order_group_image, class: 'Order::Group::Image' do
    reference_group { create(:order_group) } 
    description { Faker::Lorem.paragraph }
    img do
      path = Rails.root.join("spec", "fixtures", "files", "test.jpg")
      Rack::Test::UploadedFile.new(path, "image/jpeg")
    end
  end
end
