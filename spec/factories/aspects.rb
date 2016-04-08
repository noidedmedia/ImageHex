FactoryGirl.define do
  factory :aspect do
    offer { create(:offer, listing: create(:listing_with_options)) }
    option { offer.listing.options.first } 
    description "MyText"
  end
end
