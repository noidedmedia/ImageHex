FactoryGirl.define do
  factory :listing do
    user
    base_price 1000
    description { Faker::Lorem.paragraph }
    name { Faker::Commerce.product_name }
    quote_only false

    transient do
      options_count 2
      categories_count 2
    end

    after(:build) do |l, e|
      l.options = build_list(:listing_option, e.options_count,
                             listing: nil)
      l.categories = build_list(:listing_category,
                                e.categories_count,
                                listing: nil)
    end

    factory :quote_listing do
      base_price nil
      quote_only true
    end
  end
end
