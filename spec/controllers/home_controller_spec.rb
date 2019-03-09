require 'rails_helper'

RSpec.describe HomeController, "首页功能测试",type: :controller do
  describe "关于首页的测试" do
    context "能显示首页" do
      When { get :index }
      Then { response.should be_success }
    end
    context "能显示200回传码" do
      When { get :index }
      Then { response.should have_http_status "200" }
    end
  end
end
