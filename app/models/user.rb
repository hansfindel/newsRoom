class User

  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :password_hash, type: String
  field :password_salt, type: String
  field :role, type: Integer
  field :country, type: String
  
  has_many :articles
  has_many :user_categories
  has_many :categories, :through => :user_categories

  before_create :encrypt_password

  attr_accessor :password


  validates_presence_of :password, :on => :create, message: "must be present"
  validates_confirmation_of :password, message: "must be confirmated"
  validates_presence_of :email, message: "must be present"
  validates_uniqueness_of :email, message: "is already taken"

  ROLES = %w[admin journalist editor chief_editor chief_editor_country reader]
  COUNTRY = %w[Chile Argentina Brazil Spain Ecuador Bolivia Peru Colombia Uruguay Paraguay Mexico Venezuela Panama]



def self.authenticate(email, password)
    user = User.where(:email => email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
end

def getSlaves()
  Chief.where(:slave => self._id)
end

def getBoss()
  Chief.where(:boss => self._id).first
end

def setSlave(userID)
  a = Chief.create(:boss => self._id.to_s, :slave => userID.to_s)
  a.save
end



  protected
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
