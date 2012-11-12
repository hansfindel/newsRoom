require 'spec_helper'

describe Category do

  	it "should be valid" do
      	category = Category.new(:name => "category")
  	end

  	it "should create new category if does not exists" do
  		Category.where(name: "ThisNewCategory").empty?.should eq(true)
  		category = Category.new(:name => "ThisNewCategory")
  		category.save
  		Category.where(name: "ThisNewCategory").empty?.should eq(false)
  	end

end