FactoryGirl.define do
  factory :tag_group do
    image
    factory :tag_group_tags do
      transient do
        tag_count 4
      end
      after(:create) do |group, ev|
        create_list(:tag, ev.tag_count, group: group)
      end
    end
  end

end
