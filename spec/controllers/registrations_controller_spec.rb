require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
    
  describe "POST #create" do

    before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user] 
        
    end
      
    context "create non-associated user" do
      
        it "creates new user user not associated with any project if project_id not specified" do
          expect{
            post :create, user: FactoryGirl.attributes_for(:user) 
          }.to change(User, :count).by(1)
        end
        
        it "signs in after registration" do
            expect(controller.current_user).to be_nil
            attributes = FactoryGirl.attributes_for(:user)
            post :create, user: attributes
            expect(controller.current_user.email).to eq(attributes[:email])
            
        end
        
        it "does not create new user if user data is not valid" do
          expect{
            post :create, user: FactoryGirl.attributes_for(:user, email: nil)
          }.to change(User, :count).by(0)
            
        end
    
    end
    
    
    context "create user associated with some project" do
    
        before :each do
            @owner = FactoryGirl.create(:user)
            login_with @owner 
            @project = FactoryGirl.create(:project, owner: @owner)
        end
    
        it "creates new user associated with project specified by project_id" do
          expect{
            post :create, user: FactoryGirl.attributes_for(:user), :project_id => @project.id
          }.to change(User, :count).by(1)
        end
        
        it "user is associated with project if project_id specified" do
            u = @project.users.count
            post :create, user: FactoryGirl.attributes_for(:user), :project_id => @project.id
            @project.reload
            expect(@project.users.count).to eq(u+1)
            
        end
        
        it "does not sign new user if associated with some project" do
            attributes = FactoryGirl.attributes_for(:user)
            post :create, user: attributes, :project_id => @project.id
            expect(controller.current_user.email).to eq(@owner.email)
            
        end
    
        it "redirects to show project after creation of associated user" do 
            post :create, user: FactoryGirl.attributes_for(:user), :project_id => @project.id
            expect(response).to redirect_to project_path(:id => @project.id)
        end

        it "does not create new user if user data is not valid" do
          expect{
            post :create, user: FactoryGirl.attributes_for(:user, email: nil), :project_id => @project.id
          }.to change(User, :count).by(0)
            
        end

    end
    
  end

end
