class Category
  include Mongoid::Document
  field :name, :type => String
  field :parent_name, :type => String

  has_many :article_categories
  has_many :article, :through => :article_categories

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
