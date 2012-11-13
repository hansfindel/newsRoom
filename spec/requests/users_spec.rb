require 'spec_helper'
require 'capybara/rspec'

describe User do
  before (:each) do
    @user = User.new
    #@current_user = build(:user)
    #current_user = @current_user
    #@current_user.save
  end

  describe "GET /users" do    
    it "get to index" do
      get users_path
      response.status.should be(200)
    end
  end

  it "Should not create user with no email" do  
      @user = build(:user) 
      visit new_user_path  
      fill_in "user_password", :with => @user.password
      fill_in "user_password_confirmation", :with => @user.password_confirmation
      fill_in "user_name", :with => @user.name
      click_button "Create User"
      page.should have_content("Form is invalid")
  end  

end