FactoryBot.define do
  factory :user do
    first_name "Michael"
    last_name "Lin"
    sequence :email { |n| "jie#{n}@qq.com" }
    password "123456"
  end
end
