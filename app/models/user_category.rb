class UserCategory
  include Mongoid::Document
  field :user_id, :type => String
  field :category_id, :type => String

  belongs_to :user
  belongs_to :category 

  def self.construct(user, category_name)
  	cat = Category.construct(category_name)
  	#ArticleCategory.
  	create(user: article, category: cat)
  end

end