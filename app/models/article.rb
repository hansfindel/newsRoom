class Article
  include Mongoid::Document
  field :headline,      type: String
  field :deck,          type: String
  field :story,         type: String
  field :published_on,  type: Date
  field :guid,          type: String
  field :url,           type: String
  field :categories,    type: Array

  belongs_to :news_agency
end
