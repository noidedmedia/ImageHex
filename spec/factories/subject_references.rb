FactoryGirl.define do
  factory :subject_reference do
    commission_subject
    file do
      path = Rails.root.join("spec", "fixtures", "files", "test.jpg")
      Rack::Test::UploadedFile.new(path, "image/jpeg")
    end
  end
end
