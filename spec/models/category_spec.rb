require 'spec_helper'

describe Category do
	before :each do
		@category = Category.new
	end

  	it "should be valid" do
      	@category.name = "category"
      	@category.save == true
  	end

  	it "should create new category if does not exists" do
  		Category.where(name: "ThisNewCategory").count == 0
  		category = create(:category, :name => "ThisNewCategory")
		Category.where(name: "ThisNewCategory").count != 0
	end
end