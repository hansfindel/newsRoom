class Category
  include Mongoid::Document
  field :name, :type => String
  field :parent_name, :type => String

  has_many :article_categories
  has_many :articles, :through => :article_categories
  has_many :user_categories
  has_many :users, :through => :user_categories
  
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.construct(name)
  	category = Category.where(name: name)
  	if category.empty?
  		category = Category.create(name: name)
  	else
  		category = category.first
  	end
  	category
  end

  #returns all the parents of this category for future search
  #parent_name should be administered by some editor 
  #should be registered in the database and updated every now and then?
  def ancestors
  	if parent_name.blank?
	  	ancestors = [] 
  	else
  		p = Category.where(name: parent_name).first
  		ancestors = p.ancestors
  		ancestors << parent_name
  	end
  	ancestors
  end

end
