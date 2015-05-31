require 'rails_helper'

RSpec.feature "AddNewAssociatedUsers", type: :feature do
    
    it "adding new associated user with signing in as project owner" do
        
        user_attributes = FactoryGirl.attributes_for(:user)
        @owner = FactoryGirl.create(:user)
        @project = FactoryGirl.create(:project, owner: @owner, users: [@owner])
        
        visit project_path(:id => @project.id)
        
        within "#new_user" do
            fill_in "user_email", with: @owner.email
            fill_in "user_password", with: @owner.password
        end

        click_link_or_button "Log in"
        
        
        
        click_link_or_button "Create new developer account"
        
        within "#new_user" do
            fill_in "user_email", with: user_attributes[:email]
            fill_in "user_first_name", with: user_attributes[:first_name]
            fill_in "user_last_name", with: user_attributes[:last_name]
            fill_in "user_password", with: user_attributes[:password]
            fill_in "user_password_confirmation", with: user_attributes[:password]
        end
        
        click_link_or_button "Create account"

        expect(page).to have_content user_attributes[:first_name]
        expect(page).to have_content user_attributes[:last_name]
        expect(page).to have_content user_attributes[:email]

        expect(User.count).to eq(2)
        expect(User.second.email).to eq(user_attributes[:email])
        expect(User.second.projects).to include(@project)
        
    end
  
end
