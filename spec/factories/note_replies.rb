FactoryGirl.define do
  factory :note_reply, class: 'Note::Reply' do
    user 
    note 
    body { Faker::Lorem.paragraph }
  end
end
