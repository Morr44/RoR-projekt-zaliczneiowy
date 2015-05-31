require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    login_with @user
    @project = FactoryGirl.create(:project, users: [@user])
  end
    
  describe "DELETE #destroy" do
      
    before :each do
      @ticket = FactoryGirl.create(:ticket, project: @project)
    end
    
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
  
  
  describe "PATCH #update" do
    
      before :each do
        @ticket = FactoryGirl.create(:ticket, project: @project, title: "title", description: "description", priority: 5, status: "open")
      end
      
      it "locates requested ticket" do
        patch :update, id: @ticket, ticket: FactoryGirl.attributes_for(:ticket), project_id: @project
        expect(assigns(:ticket)).to eq(@ticket)
      end
      
      it "changes attributes" do
        patch :update, id: @ticket, ticket: FactoryGirl.attributes_for(:ticket, title: "new title", description: "new description", priority: 10, status: "closed"), project_id: @project
        @ticket.reload
        expect(@ticket.title).to eq("new title")
        expect(@ticket.description).to eq("new description")
        expect(@ticket.priority).to eq(10)
        expect(@ticket.status).to eq("closed")
      end
      
      it "redirects to show action" do
        patch :update, id: @ticket, ticket: FactoryGirl.attributes_for(:ticket), project_id: @project
        expect(response).to redirect_to project_ticket_path(:id => @ticket.id)
      end
    
    
  end


end
