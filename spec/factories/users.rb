FactoryGirl.define do
  factory :teacher do
  	email { FFaker::Internet.email }
    password "12345678"
  end

  factory :student do
  	email "to@example.org"
    password "12345678"
  end
end
