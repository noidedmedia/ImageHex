FactoryGirl.define do
  factory :note_reply, class: 'Note::Reply' do
    user nil
    note nil
    body "MyText"
  end
end
