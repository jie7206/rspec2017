require 'rails_helper'

RSpec.describe Note, type: :model do

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

  describe "initialize" do

    it "is valid with a user, project, and message 必须要有用户,项目和内容" do
      note = Note.new(
          message: "This is a sample note.",
          user: @user,
          project: @project
        )
      expect(note).to be_valid
    end

    it "is invalid without a message 不允许内容为空" do
      note = Note.new(
          message: nil,
          user: @user,
          project: @project
        )
      expect(note).not_to be_valid
    end

  end

  describe "search message for a term" do

    before :each do
      @note1 = @project.notes.create(
          message: "This is a first note.",
          user: @user
        )
      @note2 = @project.notes.create(
          message: "This is a second note.",
          user: @user
        )
      @note3 = @project.notes.create(
          message: "This is a third note from first.",
          user: @user
        )      
    end

    context "when a match is found" do
      it "returns notes that match the search term 返回符合搜寻条件的note" do
        expect(Note.search("first")).to include @note1, @note3
      end    
    end

    context "when no match is found" do
      it "returns an empty collection 返回空集合" do
        expect(Note.search("message")).to be_empty
      end    
    end

  end

end
