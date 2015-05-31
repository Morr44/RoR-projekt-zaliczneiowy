require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  
  describe "GET #index" do
    describe "Logged in" do
        
        before :each do
            @user = FactoryGirl.create(:user)
            login_with @user
        end
        
        it "returns http success if user logged in" do
          get :index
          expect(response).to have_http_status(:success)
        end
        
        it "populates an array of projects" do
            get :index
            project = FactoryGirl.create(:project)
            expect(assigns(:projects)).to eq([project])
        end
        
        it "renders index template" do
            get :index
            expect(response).to render_template("index")
        end
        
        it "does not display projects in which current_user is not on developers list" do
            project = FactoryGirl.create(:project)
            get :index, :private => "true"
            expect(assigns(:projects)).to_not include(project)
            
        end
        
    end
    describe "No user logged in" do
        it "Fails with no user logged in" do
          login_with nil
          get :index
          expect(response).to_not have_http_status(:success)
        end
    end
    
  end


  describe "PATCH #invite" do
      
    before :each do
        
        @owner = FactoryGirl.create(:user)
        @user = FactoryGirl.create(:user)
        @project = FactoryGirl.create(:project, owner: @owner)

    end
        
    it "add developer after calling invite with project owner logged in" do
        
        login_with @owner
        patch :invite, id: @project.id, email: @user.email
        expect(@project.users).to include(@user)
        
    end
        

    it "do not add developer if invite called without project owner logged in" do
        
        login_with nil
        patch :invite, id: @project.id, email: @user.email
        expect(@project.users).to_not include(@user)
            
    end
    
    it "redirects to registration after failiture" do
        
        login_with FactoryGirl.create(:user)
        patch :invite, id: @project.id, email: @user.email
        expect(response).to redirect_to(@project)
            
    end
    
    it "redirects to project's show action after success" do
        
        login_with @owner
        patch :invite, id: @project.id, email: @user.email
        expect(response).to redirect_to(@project)
            
    end

  end
  
  
  
end
