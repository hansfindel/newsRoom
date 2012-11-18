require 'spec_helper'
require 'capybara/rspec'

describe Glutton do

  	describe "GET /articles" do
	  it "get to index" do
	    get articles_path
	    response.status.should be(200)
	  end
	end

	it "populates" do
		@user = build(:user)
    	@user.save 
    	visit log_in_path
        fill_in "email", :with => @user.email
        fill_in "password", :with => "1234"#@user.password
        click_button "Log in"
        page.should have_content("Logged in as")
        page.should have_content(@user.email)
        
        page.should have_content("glutton")
      	click_link "Populate by glutton"
      	page.should have_content("New feeds were fetched and processed")
   	end

end