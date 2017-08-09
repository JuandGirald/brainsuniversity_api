FactoryGirl.define do
  factory :coupon do
    code "MyString"
    description "MyText"
    limit 1
    amount 1
    valid_from "2017-07-28"
    valid_until "2017-07-28"
  end
end
