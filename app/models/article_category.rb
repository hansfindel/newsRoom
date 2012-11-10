class ArticleCategory
  include Mongoid::Document
  field :article_id, :type => String
  field :category_id, :type => String

  belongs_to :article
  belongs_to :category 

  def self.construct(article, category_name)
  	cat = Category.construct(category_name)
  	#ArticleCategory.
  	create(article: article, category: cat)
  end

end
