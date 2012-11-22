require 'spec_helper'

describe Article do
  before (:each) do
    get log_out_path
  end

  describe "GET /articles" do
    it "get to index" do
      #login_as_reader
      get articles_path
      response.status.should be(200)
    end
  end
  
    it "can't populate by glutton" do    
      #login_as_reader
      
      visit store_glutton_feeds_path
      page.should have_content("No tienes los permisos necesarios")
    end

    it "can't write articles through the form" do
      #login_as_reader

      visit new_article_path
      page.should have_content("No tienes los permisos necesarios")

    end

end