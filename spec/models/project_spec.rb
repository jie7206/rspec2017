require 'rails_helper'

RSpec.describe Project, type: :model do

  before :each do
    @user = User.create(
        first_name: "Michael",
        last_name: "Lin",
        email: "jie7206@qq.com",
        password: "123456"
      )
    @project = @user.projects.create(
        name: "Test Project"
      )
  end

  it "is invalid without a project name 必须要有名字" do
    new_project = @user.projects.build(
        name: nil
      )
    expect(new_project).not_to be_valid
  end
  it "does not allow duplicate project names per user 同一人不允许名称重覆" do
    new_project = @user.projects.build(
        name: "Test Project"
      )
    new_project.valid?
    expect(new_project.errors[:name]).to include "has already been taken"
  end
  it "allows two users to share a project name 允许多人使用同一名称" do
    new_user = User.create(
        first_name: "ShiJie",
        last_name: "Lin",
        email: "lin@qq.com",
        password: "123456"
      )
    new_project = new_user.projects.build(
        name: "Test Project"
      )
    expect(new_project).to be_valid
  end
end
