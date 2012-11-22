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


end