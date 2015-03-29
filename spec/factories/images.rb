FactoryGirl.define do
  factory :image do
    user
    f { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "files", "test.jpg"), "image/jpg")}
    license :public_domain
    medium :photograph
  end

end
