require 'factory_girl'

#en los modelos se cargan estos escribiendo: build(:article), retorna sin guardarlo

FactoryGirl.define do 
	factory :article do 
	  sequence(:headline) { |n| "Article #{n}" }
	  story 'it is an article'
	  factory :article_pub do 
	  	sequence(:headline) { |n| "i get published at once, #{n}" }
	  	is_published true
	  end
	end

	factory :user do 
	  name "user"
	  email "user@example.com"
	  password "1234"
	  role User::ROLES[-1]  #READER
	end
	
	factory :category do |u|
	  u.name "categoria nueva"
	end

	factory :news_agency do
		name "Agencia Nueva"
		feed_url "http://urltest.com"
	end

end