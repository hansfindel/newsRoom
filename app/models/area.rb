class Area
  include Mongoid::Document
  field :name, :type => String
  
  has_many :user
  has_many :article
  
  validates_uniqueness_of :name, message: "is already taken"
end
