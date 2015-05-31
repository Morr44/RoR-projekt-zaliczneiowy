require 'rails_helper'

RSpec.feature "AddNewProjects", type: :feature do
    
    it "adding new project as signed in user" do
        
        @user = FactoryGirl.create(:user)
        expect( Project.count ).to eq(0)
        
        visit projects_path

        within "#new_user" do
            fill_in "user_email", with: @user.email
            fill_in "user_password", with: @user.password
        end

        click_link_or_button "Log in"
        
        click_link_or_button "New project"
        
        
        name = "Very extraordinary title"
        description = "Not less extraordinary description"
        
        within "#new_project" do
            fill_in "project_name", with: name
            fill_in "project_description", with: description
        end

        click_link_or_button "Create Project"

        expect(Project.count).to eq(1)
        expect(Project.first.name).to eq(name)
        expect(Project.first.description).to eq(description)

        expect(page).to have_content name
        expect(page).to have_content description
        
        
    end
  
end
