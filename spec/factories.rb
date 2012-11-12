require 'factory_girl'

#en los modelos se cargan estos escribiendo: build(:article), retorna sin guardarlo

FactoryGirl.define do 
	factory :article do 
	  sequence(:headline) { |n| "Article #{n}" }
	  story 'it is an article'
	end

	factory :user do |u|
	  u.name "user"
	  u.email "user@example.com"
	  u.password "1234"
	  u.role User::ROLES[-1]  #READER
	end
	
	#definir otros constructores para los modelos

end