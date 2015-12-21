FactoryGirl.define do
  factory :subject_reference do
    commission_subject 
    file { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "files", "test.jpg"), "image/jpg")}
  end

end
