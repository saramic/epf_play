FactoryGirl.define do
  factory :party do
    sequence(:name) { |n| "Party #{n}" }
  end

  factory :candidate do
    given_name 'John'
    surname 'Citizen'
    association :party, :factory => :party
    #state State.find_or_create_by_short_name('VIC')
    sequence(:aec_candidate_id) { |n| n }
  end
end