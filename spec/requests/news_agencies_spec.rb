require 'spec_helper'
require 'capybara/rspec'

describe "News_Agencies" do

	before :each do
		NewsAgency.destroy_all
		@news_agency = NewsAgency.new
	end

	describe "GET /news_agencies" do
    	it "get to index" do
    	  get news_agencies_path
    	  response.status.should be(200)
    	end
	end

end