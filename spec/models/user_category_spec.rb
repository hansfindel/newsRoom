require File.dirname(__FILE__) + '/../spec_helper'

describe "UserCategory" do
	before :each do
		@user = build(:user)
		@user.save
		@category = build(:category)
		@category.save
	end

	describe "#construct" do
	    it "requires one valid object of each" do
	    	(UserCategory.construct(@user, @category)).should be_true
	    end
	    it "works with one user and a category name" do 
	    	prev = Category.all.count
	    	(UserCategory.construct(@user, "arte_user #{@user.id}")).should be_true
	    	post = Category.all.count
	    	(post > prev).should be_true #the category should be created
	    end
	    it "does recibe a valid unsaved user and creates it" do
	    	@user2 = build(:user)
	    	(UserCategory.construct(@user2, @category)).should be_true
	    	@user2.id.should_not be_nil
	    end
	end

	describe "#construct that should fail" do
	    it "does not recibe a valid user" do
	    	(UserCategory.construct(@user.name, @category)).should be_false
	    end
	    it "does recibe an user headline and a category name" do 
	    	(UserCategory.construct(@user.name, "user_artes #{@user.id}")).should be_false
	    end
	    it "recibes de values in the wrong order" do 
	    	(UserCategory.construct("inverse_user #{@user.id}", @user)).should be_false
	    end
	end	

end