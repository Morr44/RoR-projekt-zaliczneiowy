require 'rails_helper'

RSpec.feature "EditTickets", type: :feature do
    
    it "edit existing ticket; signed in as project owner" do
        
        @user = FactoryGirl.create(:user)
        @owner = FactoryGirl.create(:user)
        @ticket = FactoryGirl.create(:ticket)
        @project = FactoryGirl.create(:project, owner: @owner, users: [@owner, @user], tickets: [@ticket])
        
        visit project_path(:id => @project.id)

        within "#new_user" do
            fill_in "user_email", with: @owner.email
            fill_in "user_password", with: @owner.password
        end

        click_link_or_button "Log in"
        
        visit edit_project_ticket_path(:id => @ticket.id, :project_id => @project.id)
        
        new_title = "New title"
        expect(@ticket.title).to_not eq(new_title)
        new_priority = @ticket.priority+1
        new_status = "cancelled"
        
        within "#edit_ticket_#{@ticket.id}" do
            fill_in "ticket_title", with: new_title
            fill_in "ticket_priority", with: new_priority
            select "cancelled", :from => "ticket_status"
        end
        
        click_link_or_button "Update Ticket"
        
        expect(page).to have_content new_title
        expect(page).to have_content new_priority
        expect(page).to have_content new_status

        expect(Ticket.count).to eq(1)
        expect(Ticket.first.title).to eq(new_title)
        expect(Ticket.first.priority).to eq(new_priority)
        
        
    end
  
end
