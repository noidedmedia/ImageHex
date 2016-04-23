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
      build_list(:option, e.options_count, listing: l)
      build_list(:option, e.reference_options_count, 
                 listing: l, reference_category: true)
    end
    
    factory :quote_listing do
      base_price nil
      quote_only true
    end
  end
end
