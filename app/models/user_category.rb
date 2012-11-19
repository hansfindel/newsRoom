class UserCategory
  include Mongoid::Document
  field :user_id, :type => String
  field :category_id, :type => String

  belongs_to :user
  belongs_to :category 

  def self.construct(user, category_name)
  	if category_name.class.eql?(String)
      cat = Category.construct(category_name)
    else #assumming it is a Category object
      cat = category_name
    end

    if user.class.eql?(User) 
      if user.id.blank?
        #it should not create a new user
        false
      else
        #ArticleCategory.
        create(user: user, category: cat)
        true
      end
    else
      false
    end
  end

end