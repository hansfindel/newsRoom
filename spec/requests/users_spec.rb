require 'spec_helper'
require 'capybara/rspec'

describe User do
  before (:each) do
    #@current_user = build(:user)
    #current_user = @current_user
    #@current_user.save
  end

  describe "GET /users" do
    
    it "get to index" do
      get users_path
      response.status.should be(200)
    end

  end
end