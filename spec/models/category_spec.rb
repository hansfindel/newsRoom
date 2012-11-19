require File.dirname(__FILE__) + '/../spec_helper'
#require 'spec_helper'

describe Category do
	before :each do
    Category.destroy_all
		@category = Category.new
	end

  	it "should be valid" do
      @category.name = "category"
      @category.save.should be_true
  	end

  	it "should be invalid without name" do
  		@category.save.should be_false
  	end

  	it "should create new category if does not exists" do
  		#Category.where(name: "ThisNewCategory").count == 0
  		#category = 
      create(:category, :name => "aNewCategory").should be_true
		  #Category.where(name: "ThisNewCategory").count != 0
	end

	it "should not create a new category if already exists" do
  		#Category.where(name: "ThisNewCategory").count == 0
  		#category = 
      create(:category, :name => "ThisNewCategory").should be_true
		  #Category.where(name: "ThisNewCategory").count == 1
  		#category = 
      cat_name = Category.first.name
      category = build(:category, :name => cat_name)
      category.valid? #checking validations
      (category.errors.blank?).should be_false
  		#Category.where(name: "ThisNewCategory").count == 1
	end

end