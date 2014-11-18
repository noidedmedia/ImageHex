FactoryGirl.define do
  factory :image do
    user
    f { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "files", "test.png"), "image/png")}
    license :public_domain
    medium :digital_paint
  end

end
