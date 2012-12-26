FactoryGirl.define do
  factory :user do
    name     "vicky"
    email    "vicky@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
