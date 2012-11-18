require File.dirname(__FILE__) + '/../spec_helper'

describe Chief do
	before :each do
		Chief.destroy_all
		@chief = Chief.new
	end

	describe "#new" do
	    it "takes no parameters and returns a Chief object" do
	        @chief.should be_an_instance_of Chief
	    end
	end

	describe "test the validations" do

		it "cannot be saved, slave already has a boss" do 
			@chief = build(:chief)
			@chief.save.should be_true
			chief = Chief.new
			chief.slave = "Esclavo"
			chief.save.should be_false
		end

		it "can be saved with no boss and no slave" do
			@chief.save.should be_true
		end

		it "can be saved with no boss and slave" do
			@chief.slave = "Esclavo2"
			@chief.save.should be_true
		end

		it "can be saved with boss and no slave" do
			@chief.boss = "Jefe2"
			@chief.save.should be_true
		end

		it "can be saved with boss and slave" do
			@chief = build(:chief)
			@chief.save.should be_true
		end
	end
end
