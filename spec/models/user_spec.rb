require File.dirname(__FILE__) + '/../spec_helper'

describe User do
	before :each do
		User.destroy_all
		@user = User.new
	end

	describe "#new" do
	    it "takes no parameters and returns an User object" do
	        @user.should be_an_instance_of User
	    end
	end

	describe "test the validations" do
		it "cannot be saved, it has no password nor email" do 
			@user.save.should == false
		end

		it "cannot be saved, it has no email" do 
			@user.password = "12345"
			@user.password_confirmation = "12345"
			@user.save.should == false
		end

		it "cannot be saved, it has no password" do 
			@user.email ="test@hmail.com"
			@user.save.should == false
		end

		it "cannot be saved, it uses an existing email" do 
			@user.email = "user@example.com"
			@user.save.should == false
		end

		it "it should be saved" do 
			#user = User.new(name: "me#{User.count}", email: "mi@ma.il", password: "1234")
			user2 = build(:user)
			user2.password = "hola"
			user2.password_confirmation = "hola"
			user2.save.should be_true
			admin = build(:user_admin)
			admin.email = "asf.as@fac.cs"
			admin.save.should be_true			
		end
		
		it "should be reader by default" do
			@user = build(:user)
			@user.save
			@user.role.should == "reader"
		end
	end

end