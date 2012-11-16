require 'spec_helper'
require 'capybara/rspec'

describe User do
  before (:each) do
    User.destroy_all
    @user = User.new
  end

  describe "GET /users" do    
    it "get to index" do
      get users_path
      response.status.should be(200)
    end
  end

  describe "creating users" do 

    it "Should not create user with no email" do  
        #@user = build(:user) 
        visit new_user_path  
        fill_in "user_password", :with => "1234"
        fill_in "user_password_confirmation", :with => "1234" # @user.password_confirmation
        fill_in "user_name", :with => "user_name" #@user.name
        click_button "Create User"
        page.should have_content("Form is invalid")
        page.should have_content("must be present")
    end  

    it "Email should be unique" do  
        @user = build(:user_email)
        @user.save.should eq(true)
        name = @user.name
        email = @user.email
        visit new_user_path  
        fill_in "user_password", :with => "1234"
        fill_in "user_password_confirmation", :with => "1234"
        fill_in "user_name", :with => name
        fill_in "user_email", :with => email
        click_button "Create User"
        page.should have_content("is already taken")
        page.should have_content("Form is invalid")
    end 

    it "Should not create user with no password" do  
        @user = build(:user) 
        visit new_user_path  
        fill_in "user_email", :with => @user.email
        fill_in "user_password_confirmation", :with => "1234"
        fill_in "user_name", :with => @user.name
        click_button "Create User"
        page.should have_content("Form is invalid")
    end  

    it "Should not create user with no password confirmation" do  
        @user = build(:user) 
        visit new_user_path  
        fill_in "user_email", :with => @user.email
        fill_in "user_password", :with => "1234"
        fill_in "user_name", :with => @user.name
        click_button "Create User"
        page.should have_content("Form is invalid")
    end  

    it "Password should match with password confirmation" do  
        @user = build(:user) 
        visit new_user_path  
        fill_in "user_password", :with => "1234"
        fill_in "user_password_confirmation", :with => "1234"
        fill_in "user_name", :with => @user.name
        click_button "Create User"
        page.should_not have_content("doesn't match confirmation")
        page.should have_content("Form is invalid")
    end  


    it "Should create user" do  
        @user = build(:user) 
        visit new_user_path  
        fill_in "user_email", :with => @user.email
        fill_in "user_password", :with => "1234"
        fill_in "user_password_confirmation", :with => "1234"
        fill_in "user_name", :with => @user.name
        click_button "Create User"
        page.should have_content("User was successfully created")
        page.should have_content(@user.email)
    end  

    it "should destroy user with the link rout" do
        @user = build(:user)
        @user.save.should be_true
        get user_path(@user.id, method: :delete)
        response.status.should be(200)
    end
    it "should destroy user with the link" do
        User.destroy_all #ensure there is no other users
        @user = build(:user)
        @user.save.should be_true
        visit users_path
        click_link "Destroy"
        page.should_not have_content(@user.email)
    end


  end 
  
end