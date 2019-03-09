require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory 能建立预构件" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  it "is valid with a first name, last name, email, and password 必须提供姓名,邮箱和密码" do
    user = User.new(
        first_name: "Michael",
        last_name: "Lin",
        email: "jie7206@qq.com",
        password: "123456"
      )
    expect(user).to be_valid
  end
  it "is invalid without a first name 不允许名字为空" do
    user = FactoryBot.build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include "can't be blank"
  end
  it "is invalid without a last name 不允许姓氏为空" do
    user = FactoryBot.build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include "can't be blank"    
  end
  it "is invalid without an email address 不允许邮箱为空" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include "can't be blank"
  end
  it "is invalid with a duplicate email address 不允许邮箱重覆" do
    FactoryBot.create(:user, email: "jie7206@qq.com")
    user = FactoryBot.build(:user, email: "jie7206@qq.com")
    user.valid?
    expect(user.errors[:email]).to include "has already been taken"
  end
  it "returns a user's full name as a string 能返回全名" do
    user = FactoryBot.build(:user, first_name: "Michael", last_name: "Lin")
    expect(user.name).to eq "Michael Lin"
  end
end
