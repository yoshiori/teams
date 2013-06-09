# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    uid "uid"
    nickname "nickname"
    name "name"
    image "http://example.com/example.png"
  end
end
