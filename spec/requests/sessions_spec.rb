require 'spec_helper'
require 'capybara/rspec'

describe "Sessions" do
  before (:each) do
    @user = build(:user)
    @user.save 
    #user_pass -> "1234"
    #@current_user = build(:user)
    #current_user = @current_user
    #@current_user.save
  end

  describe "login" do    
    it "get to login" do
      get log_in_path
      response.status.should be(200)
    end


    it "Should log in the user with correct {email, password}" do  
        visit log_in_path
        fill_in "email", :with => @user.email
        fill_in "password", :with => "1234"#@user.password
        click_button "Log in"
        page.should have_content("Logged in as")
        page.should have_content(@user.email)
    end  

  end
end