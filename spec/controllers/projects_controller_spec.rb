require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  describe "index" do
    context "as a authenticated user" do
      before do
        @user = FactoryBot.create(:user)
      end
      it "responds successfully 显示首页" do
        sign_in @user
        get :index
        expect(response).to be_success
      end
      it "returns a 200 response 显示200回传码" do
        sign_in @user
        get :index
        expect(response).to have_http_status "200"
      end
    end
    context "as a guest" do
      it "returns a 302 response 显示302回传码" do
        get :index
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page 跳转到登入页" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "show" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        @project = FactoryBot.create(:project, owner: @user)
      end
      it "responds successfully 正常显示" do
        sign_in @user
        get :show, params: {id: @project.id}
        expect(response).to be_success
      end
    end
    context "as an unauthenticated user" do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @project = FactoryBot.create(:project, owner: other_user)
      end
      it "redirects to the dashboard 跳转到根页面" do
        sign_in @user
        get :show, params: {id: @project.id}
        expect(response).to redirect_to root_path
      end
    end    
  end

  describe "create" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
      end
      it "adds a project 新增项目" do
        project_params = FactoryBot.attributes_for(:project)
        sign_in @user
        expect {
          post :create, params: {project: project_params}
        }.to change(@user.projects, :count).by 1
      end
    end
    context "as a guest" do
      it "returns a 302 response 回传302" do
        project_params = FactoryBot.attributes_for(:project)
        post :create, params: {project: project_params}
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page 跳转到登入页" do
        project_params = FactoryBot.attributes_for(:project)
        post :create, params: {project: project_params}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "update" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        @project = FactoryBot.create(:project, owner: @user)
      end
      it "updates a project name 更新项目名称" do
        project_params = FactoryBot.attributes_for(:project, name: "New Project Name")
        sign_in @user
        patch :update, params: {id: @project.id, project: project_params}
        expect(@project.reload.name).to eq "New Project Name"
      end
    end
  end

end
