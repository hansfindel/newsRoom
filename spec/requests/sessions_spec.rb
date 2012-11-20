require 'spec_helper'
#require 'capybara/rspec'

describe "Sessions" do
  before (:each) do
    @user = build(:user)
    @user.save 
    #user_pass -> "1234"
  end
  describe "login methods" do 
    it "should log in as admin" do 
        login_as_admin
        page.should have_content("Logged in as")
    end
  end
  describe "login" do    
    it "get to login" do
      get log_in_path
      response.status.should be(200)
    end
    it "log in link should redirect to log in path" do 
      visit root_url
      click_link "Log in"
      current_path.should == log_in_path
    end

    it "Should log in the user with correct {email, password}" do  
        visit log_in_path
        fill_in "email", :with => @user.email
        fill_in "password", :with => "1234"#@user.password
        click_button "Log in"
        page.should have_content("Logged in as")
        page.should have_content(@user.email)
    end  
    it "Should not log in the user with correct email and wrong password" do  
        visit log_in_path
        fill_in "email", :with => @user.email
        fill_in "password", :with => "12345"#@user.password
        click_button "Log in"
        page.should_not have_content("Logged in as")
        page.should have_content("Invalid email or password")
    end  
    it "Should log in the user with correct {email, password}" do  
        visit log_in_path
        fill_in "email", :with => ((@user.email.to_a).shuffle).to_s
        fill_in "password", :with => "1234"#@user.password
        click_button "Log in"
        page.should_not have_content("Logged in as")
        page.should have_content("Invalid email or password")
    end      
    it "should not show log in when logged in" do 
        visit log_in_path
        fill_in "email", :with => @user.email
        fill_in "password", :with => "1234"#@user.password
        click_button "Log in"
        page.should_not have_content("Log in")
    end

  end

  describe "log out" do 
    it "should be fine to log out" do 
        get log_out_path #ensure not logged in
        get log_out_path
        response.status.should be(302) #should not change!
    end
    it "if not logged in: it should not show the possibility to logout" do
        visit log_out_path
        page.should_not have_content("Log out")
        page.should_not have_content("Logged in as")      
        page.should have_content("Log in")        
    end
    it "if logged in: it should show the possibility to logout" do
        visit log_in_path
        fill_in "email", :with => @user.email
        fill_in "password", :with => "1234"#@user.password
        click_button "Log in"
        page.should have_content("Log out")
        page.should have_content("Logged in as")      
        page.should_not have_content("Log in")        
    end    
    it "log out link should log out" do
        visit log_in_path
        fill_in "email", :with => @user.email
        fill_in "password", :with => "1234"#@user.password
        click_button "Log in"
        click_link "Log out"
        page.should_not have_content("Log out")
        page.should_not have_content("Logged in as")      
        page.should have_content("Log in")        
    end        
  end

end