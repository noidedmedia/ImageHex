FactoryGirl.define do
  factory :image do
    user
    f { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "files", "test.jpg"), "image/jpg")}
    license :public_domain
    medium :photograph
    nsfw_nudity false
    nsfw_gore false
    nsfw_sexuality false
    nsfw_language false
    source {Faker::Internet.url}
    allow_new_creators true
  end

end
