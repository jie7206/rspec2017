FactoryBot.define do
  factory :user, aliases: [:owner] do
    first_name "Michael"
    last_name "Lin"
    sequence(:email) { |n| "jie#{n}@qq.com" }
    password "123456"

    trait :shijie do
      first_name "ShiJie"
      last_name "Lin"
      email "lin@qq.com"
    end
    trait :with_project do
      after(:create) {|user| create(:project, name:"Test Project", owner: user)}
    end
  end
end
