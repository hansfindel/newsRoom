class Article
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

  field :headline, type: String
  field :deck, type: String
  field :story, type: String
  field :published_on, :type => Date
  field :grade, type: Float
  field :editors_grade, type: Integer
  field :chief_editor_grade, type: Integer
  field :chief_editor_country_grade, type: Integer
  belongs_to :news_agency
  belongs_to :user

  def add_grade
  	self.grade = (self.grade + 
  		self.editors_grade + 
  		self.chief_editor_grade + 
  		self.chief_editor_country_grade)

  	self.save
  end

end
