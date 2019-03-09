require 'rails_helper'

RSpec.describe User, "账户模型测试", type: :model do
  describe "基本功能测试" do
    Given(:user) { FactoryBot.build(:user) }
    context "能建立预构件" do
      Then { user.should be_valid }
    end
    context "必须提供姓名,邮箱和密码" do
      When(:user) { FactoryBot.build(:user, :shijie) }
      Then { user.should be_valid }
    end
    context "不允许名字为空" do
      When(:user) { FactoryBot.build(:user, first_name: nil) }
      When { user.valid? }
      Then { user.errors[:first_name].should include "can't be blank" }
    end
    context "不允许姓氏为空" do
      When(:user) { FactoryBot.build(:user, last_name: nil) }
      When { user.valid? }
      Then { user.errors[:last_name].should include "can't be blank" }
    end
    context "不允许邮箱为空" do
      When(:user) { FactoryBot.build(:user, email: nil) }
      When { user.valid? }
      Then { user.errors[:email].should include "can't be blank" }
    end
    context "不允许邮箱重覆" do
      When(:user1) { FactoryBot.create(:user, email: "tested@qq.com") }
      When(:user2) { FactoryBot.build(:user, email: "tested@qq.com") }
      When { user2.valid? }
      Then { user2.errors[:email].should include "has already been taken"}
    end
    context "能返回全名" do
      When(:user) { FactoryBot.build(:user, first_name: "Michael", last_name: "Lin") }
      Then { user.name.should eq "Michael Lin" }
    end
  end
end
