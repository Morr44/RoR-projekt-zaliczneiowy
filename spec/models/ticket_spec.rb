require "rails_helper"

describe Ticket do

    it "has a valid factory" do
        expect(FactoryGirl.create(:ticket)).to be_valid
    end
    
    it "is invalid without an title" do
        expect(FactoryGirl.build(:ticket, title: nil)).to_not be_valid 
    end
   
    it "is invalid without an description" do
        expect(FactoryGirl.build(:ticket, description: nil)).to_not be_valid 
    end
   
    it "is invalid without a priority" do
        expect(FactoryGirl.build(:ticket, priority: nil)).to_not be_valid 
    end 
    
    it "is valid without estimation" do
        expect(FactoryGirl.build(:ticket, estimation: nil)).to be_valid 
    end     
    
    it "is valid without status" do
        expect(FactoryGirl.build(:ticket, status: nil)).to be_valid 
    end
    
    it "is valid with status open closed or cancelled" do
        
        expect(FactoryGirl.build(:ticket, status: :open)).to be_valid
        expect(FactoryGirl.build(:ticket, status: :closed)).to be_valid
        expect(FactoryGirl.build(:ticket, status: :cancelled)).to be_valid
        
    end
    
    describe "tests related to attachments" do
        
        context "delete_attachment and attach methods" do
            before :each do
                @ticket = FactoryGirl.create(:ticket)
            end
            
            it "attach method returns 0 when if there is no file attached" do
                expect(FactoryGirl.create(:ticket, attachment: nil).attach).to eq("0")
            end
            
            it "attach method returns 1 when if there there is an file attached" do
                expect(@ticket.attach).to eq("1")
            end
            
            it "delete_attachment method removes attachment file" do
                expect(@ticket.attachment_file_name).to_not be_nil
                @ticket.delete_attachment
                expect(@ticket.attachment_file_name).to be_nil
                
            end
            
            it "delete_attachment method clears attachment name" do
                expect(@ticket.attachment_name).to_not be_nil
                @ticket.delete_attachment
                expect(@ticket.attachment_name).to be_nil
                
            end
        end
        
        context "attachment validation" do
        
            it { should have_attached_file(:attachment) }
            it { should_not validate_attachment_presence(:attachment) }
            it { should validate_attachment_content_type(:attachment).
            allowing("image/jpg",
                    "image/jpeg",
                    "image/png",
                    "image/gif",
                    "application/vnd.ms-excel",
                    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                    "application/msword",
                    "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
                    "text/plain" 
            ).
            rejecting('text/xml') }
        end
        
    end
    
    
end