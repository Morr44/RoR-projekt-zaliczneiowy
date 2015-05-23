require "rails_helper"

describe User do

    it "has a valid factory" do
        expect(FactoryGirl.create(:user)).to be_valid
    end
    
    it "is invalid without email address" do
       expect(FactoryGirl.build(:user, email: nil)).to_not be_valid 
    end
    
    it "is valid without first name" do
       expect(FactoryGirl.build(:user, first_name: nil)).to be_valid 
    end    
    
    it "is valid without last name" do
       expect(FactoryGirl.build(:user, last_name: nil)).to be_valid 
    end    
    
    it "is invalid without password" do
       expect(FactoryGirl.build(:user, password: nil)).to_not be_valid 
    end
    
    it "is invalid with password not long enough" do
       expect(FactoryGirl.build(:user, password: "1234567")).to_not be_valid
    end    
    
    it "description constructs correctly" do
        @user = FactoryGirl.create(:user)
        expect(@user.get_description).to eq([@user.first_name, @user.last_name, @user.email].join(' ')) 
    end       
    
    
    
end