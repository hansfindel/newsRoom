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

  describe "editors permissons" do
    it "can populate by glutton" do
      get log_out_path 
      login_as_editor
      
      visit store_glutton_feeds_path
      page.should have_content("New feeds were fetched and processed")
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

  end

end