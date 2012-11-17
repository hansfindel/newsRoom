require 'spec_helper'

describe NewsAgency do
	before :each do
		NewsAgency.destroy_all
		@news_agency = NewsAgency.new
	end

	describe "#new" do
	    it "takes no parameters and returns a news_agency object" do
	        @news_agency.should be_an_instance_of NewsAgency
	    end
	end

	describe "test the validations" do

		it "cannot be saved, it has no name or feed_url" do 
			@news_agency.save.should be_false
		end

		it "cannot be saved, it has no name" do 
			@news_agency.feed_url = "url"
			@news_agency.save.should be_false
		end

		it "cannot be saved, it has no url" do 
			@news_agency.name = "Agency Name"
			@news_agency.save.should be_false
		end

		it "cannot be saved, it uses an existing url" do 
			new1 = build(:news_agency, name: "2Agency", feed_url: "http://urltestx2.com")
			new1.save.should be_true
			new2 = build(:news_agency, name: "2OtherAgency", feed_url: "http://urltestx2.com")
			new2.save.should be_false
		end

		it "should be saved" do
			news = NewsAgency.new(name: "Agency_unique", feed_url: "http://urltest_unique.com")
			news.save.should  be_true		
	  	end

  	end

end