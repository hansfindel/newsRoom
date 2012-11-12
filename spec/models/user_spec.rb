require File.dirname(__FILE__) + '/../spec_helper'

describe User do
	before :each do
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
			#@user.password = "hola"
			#@user.password_confirmation = "hola"
			#@user.email =  "hola2@hola.com"
			#@user.save.should == true
			build(:user, password: "hola", password_confirmation: "hola", email: "hola@hola.com").save  == true
		end
		
	end

end