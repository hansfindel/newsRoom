require 'spec_helper'
#require 'capybara/rspec'

describe Glutton do

  describe "GET /articles" do
	  it "get to index" do
	    get articles_path
	    response.status.should be(200)
	  end
	end

	it "populates" do
    get log_out_path
    login_as_admin
    
    visit store_glutton_feeds_path
    #page.should have_content("glutton")
    #click_link "Populate by glutton"
    page.should have_content("New feeds were fetched and processed")
  end

end