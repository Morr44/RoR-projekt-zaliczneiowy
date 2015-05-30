require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
    
  before :each do
    @user = FactoryGirl.create(:user)
    controller.stub!(:current_user).and_return(@user)
  end
  
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
