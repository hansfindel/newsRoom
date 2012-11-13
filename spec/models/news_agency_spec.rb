require 'spec_helper'

describe NewsAgency do
	before :each do
		@news_agency = NewsAgency.new
	end

	describe "#new" do
	    it "takes no parameters and returns a news_agency object" do
	        @news_agency.should be_an_instance_of NewsAgency
	    end
	end

	describe "test the validations" do

		it "cannot be saved, it has no name or feed_url" do 
			@news_agency.save.should == false
		end

		it "cannot be saved, it has no name" do 
			@news_agency.feed_url = "url"
			@news_agency.save.should == false
		end

		it "cannot be saved, it has no url" do 
			@news_agency.name = "Agency Name"
			@news_agency.save.should == false
		end

		it "cannot be saved, it uses an existing url" do 
			build(:news_agency, name: "Agency", feed_url: "http://urltest.com").save == true
			build(:news_agency, name: "OtherAgency", feed_url: "http://urltest.com").save == false
		end

		it "should be saved" do
			build(:news_agency, name: "Agency", feed_url: "http://urltest.com").save  == true		
	  	end

  	end

end