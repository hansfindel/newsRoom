require 'spec_helper'
require 'capybara/rspec'

describe "News_Agencies" do

	before :each do
		NewsAgency.destroy_all
		@news_agency = build(:news_agency)
	end

	describe "GET /news_agencies" do
    	it "get to index" do
    	  get news_agencies_path
    	  response.status.should be(200)
    	end
	end

	describe "creating agencies" do 

		it "New News agency link should redirect to New News agency path" do 
	      visit news_agencies_path
	      click_link "New News agency"
	      current_path.should == new_news_agency_path
	    end

	    it "Should not create agency with no feed_url" do  
	        visit new_news_agency_path 
	        fill_in "news_agency_name", :with => @news_agency.name
	        click_button "Create News agency"
	        page.should have_content("must be present")
	        page.should_not have_content("News agency was successfully created.")
	    end  

	    it "Should not create agency with no name" do  
	        visit new_news_agency_path 
	        fill_in "news_agency_feed_url", :with => @news_agency.feed_url
	        click_button "Create News agency"
	        page.should have_content("must be present")
	        page.should_not have_content("News agency was successfully created.")
	    end  

	   	it "Should create agency" do  
	        visit new_news_agency_path
	        fill_in "news_agency_name", :with => @news_agency.name
	        fill_in "news_agency_feed_url", :with => @news_agency.feed_url
	        click_button "Create News agency"
	        page.should have_content("News agency was successfully created.")
	    end  

	end

end