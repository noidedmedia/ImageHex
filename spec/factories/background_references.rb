FactoryGirl.define do
  factory :background_reference do
    commission_background
    file { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "files", "test.jpg"), "image/jpg") }
  end
end
