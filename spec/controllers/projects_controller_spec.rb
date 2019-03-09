require 'rails_helper'

RSpec.describe ProjectsController, "项目功能测试",type: :controller do
  describe "显示项目首页" do
    context "作为拥有者" do
      Given(:user) { FactoryBot.create(:user) }
      context "成功显示首页" do
        When { 
          sign_in user
          get :index
        }
        Then { response.should be_success }
      end
      context "首页显示200回传码" do
        When { 
          sign_in user
          get :index
        }
        Then { response.should have_http_status "200" }
      end
    end
    context "作为访客" do
      context "首页显示302回传码" do
        When { get :index }
        Then { response.should have_http_status "302" }
      end
      context "能自动跳转到登入页" do
        When { get :index }
        Then { response.should redirect_to "/users/sign_in" }
      end
    end
  end
  describe "显示某个项目" do
    Given(:user) { FactoryBot.create(:user) }
    context "作为拥有者" do
      Given(:project) { FactoryBot.create(:project, owner: user) }
      context "能正常显示某个项目" do
        When {
          sign_in user
          get :show, params: {id: project.id}
        }
        Then { response.should be_success }
      end
    end
    context "作为访客" do
      Given(:other_user) { FactoryBot.create(:user) }
      Given(:project) { FactoryBot.create(:project, owner: other_user) }
      context "自动跳转到根页面" do
        When {
          sign_in user
          get :show, params: {id: project.id}
        }
        Then { response.should redirect_to root_path }
      end
    end    
  end
  describe "创建新的项目" do
    Given(:project_params) { FactoryBot.attributes_for(:project) }
    context "作为拥有者" do
      Given(:user) { FactoryBot.create(:user) }
      context "能成功建立项目" do
        When(:projects_count_change) {
          sign_in user
          projects_count_1 = user.projects.count
          post :create, params: {project: project_params}
          user.projects.count - projects_count_1
        }
        Then { projects_count_change.should eq 1 }
      end
    end
    context "作为访客" do
      context "回传302" do
        When { post :create, params: {project: project_params} }
        Then { response.should have_http_status "302" }
      end
      context "自动跳转到登入页" do
        When { post :create, params: {project: project_params} }
        Then { response.should redirect_to "/users/sign_in" }
      end
    end
  end
  describe "更新某个项目" do
    Given(:user) { FactoryBot.create(:user) }
    Given(:project) { FactoryBot.create(:project, owner: user) }
    Given(:project_with_new_attribute) { FactoryBot.attributes_for(:project, name: "New Project Name") }
    context "作为拥有者" do
      context "能成功更新项目名称" do
        When {
          sign_in user
          patch :update, params: {id: project.id, project: project_with_new_attribute}
        }
        Then { project.reload.name.should eq "New Project Name" }
      end
    end
    context "作为访客" do
      context "回传302" do
        When { patch :update, params: {id: project.id, project: project_with_new_attribute} }
        Then { response.should have_http_status "302" }
      end
      context "自动跳转到登入页" do
        When { patch :update, params: {id: project.id, project: project_with_new_attribute} }
        Then { response.should redirect_to "/users/sign_in" }
      end
    end
  end
end
