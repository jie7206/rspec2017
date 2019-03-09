require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "show index" do
    it "responds successfully 能显示首页" do
      get :index
      expect(response).to be_success
    end
    it "returns a 200 response 能显示200回传码" do
      get :index
      expect(response).to have_http_status "200"
    end
  end

end
