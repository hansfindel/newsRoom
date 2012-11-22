require 'spec_helper'

describe Article do
  before (:each) do
    get log_out_path
  end

  describe "GET /articles" do
    it "get to index" do
      get articles_path
      response.status.should be(200)
    end
  end

  describe "it only can read news" do
  
    it "can't populate by glutton" do   
      visit store_glutton_feeds_path
      page.should have_content("No tienes los permisos necesarios")
    end

    it "can't write articles through the form" do
      visit new_article_path
      page.should have_content("No tienes los permisos necesarios")
    end

    it "can't qualify articles" do
      visit non_published_path
      page.should have_content("No tienes los permisos necesarios")
    end

    it "can't edit users" do
      visit users_path
      click_link "Edit"
      page.should have_content("No tienes los permisos necesarios")
    end

    it "can't create new areas" do
      visit users_path
      click_link "New Area"
      page.should have_content("No tienes los permisos necesarios")
    end

    it "can't edit areas" do
      visit users_path
      click_link "Edit"
      page.should have_content("No tienes los permisos necesarios")
    end

  end

end