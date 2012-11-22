require 'spec_helper'

describe Article do
  before (:each) do
    get log_out_path
  end

  describe "GET /articles" do
    it "get to index" do
      login_as_chief_editor
      get articles_path
      response.status.should be(200)
    end
  end
  
    it "can populate by glutton" do    
      login_as_chief_editor
      
      visit store_glutton_feeds_path
      page.should have_content("New feeds were fetched and processed")
    end

    it "can write articles through the form" do
      login_as_chief_editor

      visit new_article_path
      fill_in "article_headline", :with => "headline"
      fill_in "article_story", :with => "story"      
      click_button "Create Article" 

      page.should have_content("Article was successfully created.")
      page.should have_content("headline")
      page.should have_content("story")

    end

end