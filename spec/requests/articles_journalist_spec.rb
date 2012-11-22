require 'spec_helper'

describe Article do
  before (:each) do
    get log_out_path
  end

  describe "GET /articles" do
    it "get to index" do
      login_as_journalist
      get articles_path
      response.status.should be(200)
    end
  end

  describe "journalists permissons" do

    it "can't populate by glutton" do    
      get log_out_path
      login_as_journalist
      
      visit store_glutton_feeds_path
      page.should have_content("No tienes los permisos necesarios")
    end

    it "can write articles through the form" do
      get log_out_path
      login_as_journalist

      visit new_article_path
      fill_in "article_headline", :with => "headline"
      fill_in "article_story", :with => "story"      
      click_button "Create Article" 

      page.should have_content("Article was successfully created.")
      page.should have_content("headline")
      page.should have_content("story")

    end

    #it "can't manage News Agencies" do
     # get log_out_path
      #login_as_journalist

      #visit news_agencies_path
      #click_link "Edit"
      #current_path.should == root_url    


      #visit news_agencies_path
      #click_link "Destroy"
      #current_path.should == root_url
    #end
  end


end