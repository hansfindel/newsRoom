require 'spec_helper'
#require 'capybara/rspec'

describe "Areas" do

	before :each do
		#get log_out_path
		Area.destroy_all
		@area = build(:area)
		login_as_admin
	end

  	describe "GET /areas" do
	    it "get to index" do
	      get areas_path
    	  (response.status == 200 || response.status == 302).should be_true
	    end
	end


	describe "creating areas" do 

		it "New area link should redirect to New area path" do 
	      visit areas_path
	      click_link "New Area"
	      current_path.should == new_area_path
	    end

	    it "Should not create area with no name" do  
	        visit new_area_path 
	        click_button "Create Area"
	        page.should have_content("must be present")
	        page.should_not have_content("Area was successfully created.")
	    end  

	    it "Should not create area with already taken name" do  
	    	@area.save.should be_true
	        visit new_area_path 
	        fill_in "area_name", :with => @area.name
	        click_button "Create Area"
	        page.should have_content("Name is already taken")
	        page.should_not have_content("Area was successfully created.")
	    end  

	   	it "Should create area" do  
	        visit new_area_path
	        fill_in "area_name", :with => @area.name
	        click_button "Create Area"
	        page.should have_content("Area was successfully created.")
	    end  

	end



	describe "manage areas" do

		it "Should show an area" do
			@area.save.should be_true 
	        visit areas_path
	        click_link "Show"
	        page.should have_content(@area.name)
	    end  

	    it "Should edit an area" do  
	    	@area.save.should be_true
	        visit areas_path
	        click_link "Edit"
	        page.should have_content("Editing area")
	    end  

	    it "Should destroy an area" do  
	    	@area.save.should be_true
	        visit areas_path
	        click_link "Destroy"
	        page.should_not have_content(@area.name)
	    end  


	end

end
