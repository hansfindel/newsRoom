class Area
  include Mongoid::Document
  field :name, :type => String
  
  belongs_to :user
  belongs_to :article
  
  validates_uniqueness_of :name, message: "is already taken"
end
