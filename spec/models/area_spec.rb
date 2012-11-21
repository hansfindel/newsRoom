require File.dirname(__FILE__) + '/../spec_helper'

describe Area do
	before :each do
		Area.destroy_all
		@area = Area.new
	end

	describe "#new" do
	    it "takes no parameters and returns an Area object" do
	        @area.should be_an_instance_of Area
	    end
	end

	describe "test the validations" do
		it "cannot be saved, no name" do 
			@area.save.should be_false
		end

		it "cannot be saved, it has already taken name" do
			@area = build(:area) 
			@area.save.should be_true
			newarea = Area.new
			newarea = build(:area)
			newarea.save.should be_false
		end

		it "can be saved" do
			@area = build(:area) 
			@area.save.should be_true
		end
	end
end
