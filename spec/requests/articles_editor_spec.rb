require 'spec_helper'

describe Article do
  before (:each) do
    get log_out_path
  end

  describe "GET /articles" do
    it "get to index" do
      login_as_editor
      get articles_path
      response.status.should be(200)
    end
  end

    it "can populate by glutton" do    
      login_as_editor
      
      visit store_glutton_feeds_path
      page.should have_content("New feeds were fetched and processed")
    end

    it "can write articles through the form" do
      login_as_editor

      visit new_article_path
      fill_in "article_headline", :with => "headline"
      fill_in "article_story", :with => "story"      
      click_button "Create Article" 

      page.should have_content("Article was successfully created.")
      page.should have_content("headline")
      page.should have_content("story")
    end

    it "can qualify articles" do
      login_as_editor
      click_link "Editor Evaluation"
      page.should have_content("Noticias por clasificar")
    end

    it "should edit himself" do
      get log_out_path 
      editor ||= (User.where(role: 4).first || create(:editor))
      visit log_in_path
      fill_in "email", :with => editor.email
      fill_in "password", :with => "1234"
      click_button "Log in"
      
      visit edit_user_path(editor.id)

      fill_in "user_name", :with => 'NewName'
      click_button "Update User"
      page.should have_content("User was successfully updated.")
    end

    it "should not edit another user" do
      get log_out_path 
      login_as_editor

      @user = build(:user)
      @user.save.should be_true
      
      visit edit_user_path(@user.id)
      
      page.should have_content("No tienes los permisos necesarios")
    end

    it "can create new areas" do
      Area.destroy_all
      login_as_editor
      visit areas_path
      page.should have_content("New Area")
      click_link "New Area"
      page.should have_content("New area")
      fill_in "area_name", :with => "nombreArea" 
      click_button "Create Area"
      page.should have_content("Area was successfully created.")
      page.should have_content("nombreArea")
    end

    it "should not edit another user" do
      get log_out_path 
      login_as_editor

      @user = build(:user)
      @user.save.should be_true
      
      visit edit_user_path(@user.id)
      
      page.should have_content("No tienes los permisos necesarios")
    end

    it "should not enter to chief editor evaluation area" do
      get log_out_path 
      login_as_editor

      visit chief_editors_path
      
      page.should have_content("No tienes los permisos necesarios")
    end

    it "should not enter to chief editor country evaluation area" do
      get log_out_path 
      login_as_editor

      visit chief_editors_country_path
      
      page.should have_content("No tienes los permisos necesarios")
    end
end