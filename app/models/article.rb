class Article
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

  field :headline,      type: String
  field :deck,          type: String
  field :story,         type: String
  field :published_on,  type: Date
  field :guid,          type: String
  field :url,           type: String
  field :is_published,  type: Boolean
  #field :categories,    type: Array
  field :country,       type: String
  
  field :grade, type: Float
  field :editors_grade, type: Integer
  field :chief_editor_grade, type: Integer
  field :chief_editor_country_grade, type: Integer   #xq integer? si son varias notas!


  belongs_to :news_agency
  belongs_to :user
  belongs_to :area #seccion

  has_many :article_categories
  has_many :categories, through: :article_categories

  embeds_many :pictures

  before_save :categorize
  before_save :not_published
  before_save :add_country
  after_create :create_guid

  scope :published, -> { where(is_published: true) }
  scope :nonpublished, -> { where(is_published: false) }

  validates_presence_of :headline, message: "Headline must be present"

  PUBLISH_GRADE = 15

  #paginate(:page => params[:page], :per_page => 30)
  def self.paginated(page_num, per_page=5)
    page(page_num).per(per_page)
  end
  
  def not_published
    unless is_published
      self.is_published = false      
    end
    true   #it does not prevent the object being saved
  end

  def self.by_area(area)
    unless area.blank?
      where(area: area)      
    else
      scoped
    end
  end
  def self.by_country(country)
    unless country.blank?
      where(country: country)
    else
      scoped
    end
  end
  def self.by_area_and_country(user)
    if user
      by_country(user.country).by_area(user.area)      
    else
      scoped
    end
  end

  def add_grade
  	#self.grade = self.grade || 0 
    self.grade  = self.editors_grade || 0 #if editors_grade
  	self.grade += 3 * (self.chief_editor_grade || 0) #if chief_editor_grade
  	self.grade += 3 * (self.chief_editor_country_grade || 0) #if self.chief_editor_country_grade
    will_remove_cache = false
    if self.grade.to_i >= Article::PUBLISH_GRADE
      self.is_published = true
      #kills the page cache
      #remove_cache
      will_remove_cache = true
    end
  	self.save
    will_remove_cache
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

  def add_country
    if self.country.blank?
      self.country = "Chile"
    end
  end
  def create_guid
    if self.guid.blank?
      self.guid = self._id.to_s
      self.save
    end
  end

  def set_initial_grades
    self.grade = 0
    self.editors_grade = 0
    self.chief_editor_grade = 0
    self.chief_editor_country_grade = 0
  end

  def picture_name
    if self.pictures.any?
      self.pictures.first.name 
    else
      ""
    end
  end

  def add_picture( image_params )
    self.pictures.create(image_params) if image_params
  end

  def get_category_names
    array = []
    if self.article_categories
      self.article_categories.each do |c|
        array.append(c.category.name)
      end
    end
    array.join(',')
  end

end
