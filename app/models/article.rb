class Article
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

  field :headline,      type: String
  field :deck,          type: String
  field :story,         type: String
  field :published_on,  type: Date
  field :guid,          type: String
  field :url,           type: String
  #field :categories,    type: Array
  
  field :grade, type: Float
  field :editors_grade, type: Integer
  field :chief_editor_grade, type: Integer
  field :chief_editor_country_grade, type: Integer   #xq integer? si son varias notas!

  belongs_to :news_agency
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories


  before_save :categorize
  after_save :create_guid
  #before_save :categorize

  #scope :with_category, ->(name){ where(name: name) }

  validates_presence_of :headline, message: "Headline must be present"
  


  def add_grade
  	self.grade = (self.grade + 
  		self.editors_grade + 
  		self.chief_editor_grade + 
  		self.chief_editor_country_grade)

  	self.save
  end

  def user_name
    if user
      return user.name
    else
      return ""
    end
  end

  def categorize
    if available_category_names
      category_names.each do |c|
        ArticleCategory.construct(self, c)
      end
    end
  end
  def category_names=(array)
    @category_names = array
  end
  def category_names
    @category_names
  end

  def available_category_names
    return false if @category_names.nil?
    return false if !(@category_names.class.eql?(Array))
    return false if @category_names.empty?
    return true
  end

  def create_guid
    if self.guid.blank?
      guid = self._id.to_s
    end
  end


end
