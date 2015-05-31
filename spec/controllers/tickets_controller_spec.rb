require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    login_with @user
    @project = FactoryGirl.create(:project, users: [@user])
    @ticket = FactoryGirl.create(:ticket, project: @project)
      
  end
    
  describe "DELETE #destroy" do
      

  
    it "Deletes ticket" do
      expect{
        delete :destroy, id: @ticket, project_id: @project
      }.to change(Ticket, :count).by(-1)
    end
    
    it "Redirects to tickets index of the project" do
      delete :destroy, id: @ticket, project_id: @project
      expect(response).to redirect_to(project_tickets_path)
    end
  end
  
  
  describe "DELETE #destroy" do
  
  
  

end
