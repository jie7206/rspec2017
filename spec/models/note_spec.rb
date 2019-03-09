require 'rails_helper'

RSpec.describe Note, "项目记录模型测试", type: :model do
  Given(:user) { FactoryBot.create(:user) }
  Given(:project) { FactoryBot.create(:project) }
  describe "模型基本测试" do
    context "预构件测试" do
      When(:note) { FactoryBot.create(:note) }
      Then { note.should be_valid }
    end
    context "记录必须要有用户,项目和内容" do
      When(:note) { Note.new(
          message: "This is a sample note.",
          user: user,
          project: project
        ) }
      Then { note.should be_valid }
    end
    context "记录不允许内容为空" do
      When(:note) { Note.new(
          message: nil,
          user: user,
          project: project
        ) }
      Then { note.should_not be_valid }
    end
  end
  describe "搜寻记录中的关键字" do
    Given(:note1) do
      project.notes.create(
          message: "This is a first note.",
          user: user
      )
    end
    Given(:note2) do
      project.notes.create(
          message: "This is a second note.",
          user: user
      )
    end
    Given(:note3) do
      project.notes.create(
          message: "This is a third note from first.",
          user: user
      )
    end
    context "当找到匹配的关键字则返回符合搜寻条件的记录" do
      Then { Note.search("first").should include note1, note3 }
    end
    context "当找不到匹配的关键字则返回空集合" do
      Then { Note.search("message").should be_empty }
    end
  end
end