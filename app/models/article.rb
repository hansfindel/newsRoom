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
  has_one :area

  embeds_many :pictures

  before_save :categorize
  before_save :not_published

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
      is_published = false      
    end
    true   #it does not prevent the object being saved
  end

  def add_grade
  	self.grade = self.grade || 0 
    self.grade += self.editors_grade || 0 #if editors_grade
  	self.grade += 3 * (self.chief_editor_grade || 0) #if chief_editor_grade
  	self.grade += 5 * (self.chief_editor_country_grade || 0) #if self.chief_editor_country_grade

    if self.grade.to_i >= Article::PUBLISH_GRADE
      self.is_published = true
    end
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
      self.guid = self._id.to_s
      self.save
    end
  end

  def set_initial_grades
    grade = 0
    editors_grade = 0
    chief_editor_grade = 0
    chief_editor_country_grade = 0
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


end
