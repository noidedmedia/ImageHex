FactoryGirl.define do
  factory :listing do
    user
    base_price 1000
    description { Faker::Lorem.paragraph }
    name { Faker::Commerce.product_name }
    quote_only false


    transient do
      options_count 2
      reference_options_count 2
    end

    after(:build) do |l, e|
      o1 = build_list(:option, e.options_count,
                      listing: nil)
      o2 = build_list(:option, e.reference_options_count, 
                      reference_category: true, listing: nil)
      l.options = [o1, o2].flatten
    end
    
    factory :quote_listing do
      base_price nil
      quote_only true
    end
  end
end
