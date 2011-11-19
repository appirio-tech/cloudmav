FactoryGirl.define do
  factory :job do
    title "Developer"
    description "I did awesome stuff"
    association :company, :factory => :company
    start_date 6.months.ago
    end_date 1.month.ago
  end
end
