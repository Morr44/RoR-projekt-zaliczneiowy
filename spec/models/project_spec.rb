require "rails_helper"

describe Project do

    
    it "has a valid factory" do
        expect(FactoryGirl.create(:project)).to be_valid
    end
    
    it "is invalid without a name" do
       expect(FactoryGirl.build(:project, name: nil)).to_not be_valid 
    end
    
    it "is valid without description" do
       expect(FactoryGirl.build(:project, description: nil)).to be_valid 
    end
    
    
    describe "tests related to project's owner and associates" do
        
        before :each do
            @project = FactoryGirl.create(:project)
            @user = FactoryGirl.create(:user)
            @another_user = FactoryGirl.create(:user)
            
        end
        
        context "associates" do
            
            it "starts with users list empty" do
                expect(@project.users).to be_empty
            end
            
            it "adds user to users array" do
                @project.add_associate(@user)
                expect(@project.users).to include @user
            end
            
            it "available to add more than one user" do
                @project.add_associate(@user)
                @project.add_associate(@another_user)
                
                expect(@project.users).to include @user
                expect(@project.users).to include @another_user
                
            end
        

            
        end
        
        context "owner" do
            it "setting owner works correctly when promoted user exists in user table" do
                
                expect(@project.owner).to be_nil
                expect(@project.users).to be_empty
                @project.add_associate(@user)
                @project.set_owner(@user)
                expect(@project.owner).to be(@user)
                
            end
            it "unable to set owner that is not present at users list" do
                expect(@project.owner).to be_nil
                expect(@project.users).to be_empty
                @project.add_associate(@user)
                @project.set_owner(@another_user)
                expect(@project.owner).to_not be(@another_user)
                
            end
                
        end
    
    end
    
    
end