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
	  sequence(:name) { |i| "user#{i}" }
	  sequence(:email) { |j| "user#{j}@example.com" }
	  password "1234"
	  password_confirmation "1234"
	  role User::ROLES.count - 1  #READER
	  factory :user_admin do 
	  	sequence(:email) { |x| "user_admin#{x}@example.com" }
	  	role 1#User::ROLES[0]
	  end
	  factory :user_email do 
	  	sequence(:email) { |x| "mi_random#{x}@example.com" }
	  	role 15#User::ROLES[0]
	  end	
	  factory :editor do 
	  	sequence(:email) { |x| "editor#{x}@example.com" }
	  	role 4
	  end  
	  factory :journalist do 
	  	sequence(:email) { |x| "journalist#{x}@example.com" }
	  	role 2
	  end
	  factory :chief_editor do 
	  	sequence(:email) { |x| "chief_editor#{x}@example.com" }
	  	role 8
	  end
	  factory :chief_editor_country do 
	  	sequence(:email) { |x| "chief_editor_country#{x}@example.com" }
	  	role 16
	  end  
	end
	
	factory :category do
	  sequence(:name) { |i| "category#{i}" }
	end

	factory :news_agency do
		name "Agencia Nueva"
		feed_url "http://urltest.com"
	end

	factory :area do
		name "Area Nueva"
	end

	factory :chief do
		slave "Esclavo"
		boss "Jefe"
	end

end