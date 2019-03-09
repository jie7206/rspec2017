require 'rails_helper'

RSpec.describe Project, "测试项目", type: :model do

  describe "late status 测试过期" do
    it "is late when the due date is past 截止日为昨日则已过期" do
      project = FactoryBot.create(:project, :due_yesterday)
      expect(project).to be_late
    end
    it "is on time when the due date is today 截止日为今日则未过期" do
      project = FactoryBot.create(:project, :due_today)
      expect(project).not_to be_late
    end
    it "is on time when the due date is in the future 截止日为明日则未过期" do
      project = FactoryBot.create(:project, :due_tomorrow)
      expect(project).not_to be_late
    end
  end

  describe "with notes 测试记录" do
    it "can have many notes 能附加许多记录" do
      project = FactoryBot.create(:project, :with_notes)
      expect(project.notes.length).to eq 5
    end
  end

  describe "basic create rule 测试创建" do
    before :each do
      @user = FactoryBot.create(:user, :with_project)
      @project = FactoryBot.create(:project, :with_static_name)
    end
    it "is invalid without a project name 必须要有名字" do
      new_project = @user.projects.build(
          name: nil
        )
      expect(new_project).not_to be_valid
    end
    it "does not allow duplicate project names per user 同一人不允许名称重覆" do
      new_project = @user.projects.build name: "Test Project"
      new_project.valid?
      expect(new_project.errors[:name]).to include "has already been taken"
    end
    it "allows two users to share a project name 允许多人使用同一名称" do
      new_user = FactoryBot.create(:user, :shijie)
      new_project = new_user.projects.build name: "Test Project"
      expect(new_project).to be_valid
    end
  end

end