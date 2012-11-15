class ArticleCategory
  include Mongoid::Document
  field :article_id, :type => String
  field :category_id, :type => String

  belongs_to :article
  belongs_to :category 

  def self.construct(article, category_name)
    if category_name.class.eql?(String)
  	  cat = Category.construct(category_name)
    else #assumming it is a Category object
      cat = category_name
    end
    if article.class.eql?(Article)
    	#ArticleCategory.
    	create(article: article, category: cat)
      return true
    end
    false
  end

end
