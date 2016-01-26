FactoryGirl.define do
  factory :background_reference do
    commission_background
    file do
      path = Rails.root.join("spec", "fixtures", "files", "test.jpg")
      Rack::Test::UploadedFile.new(path, "image/jpeg")
    end
  end
end
