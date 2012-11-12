require 'spec_helper'

describe User do

  	it "should be valid" do
  		build(:user).should be_valid
  	end
	it "is invalid without email" do
		build(:user, email: nil).should_not be_valid
	end
	it "is invalid without password" do
		build(:user, password: nil).should_not be_valid
	end

	it "does not allow duplicate emails" do
	  user = build(:user)
	  user.save.should eq(true)
	  build(:user).should_not be_valid
	end


end