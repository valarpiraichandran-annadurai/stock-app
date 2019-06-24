FactoryGirl.define do
  sequence :name do |n|
    "Test User#{n}"
  end

  sequence :email do |n|
    "testuser#{n}@mailinator.com"
  end

  factory :user do
    name
    email
    password "test123"
    password_confirmation "test123"

    factory :admin do
      admin true
    end
  end
end