class User

  include Mongoid::Document

  ROLES = %w[admin journalist editor chief_editor chief_editor_country reader]


  field :name, type: String
  field :email, type: String
  field :password_hash, type: String
  field :password_salt, type: String
  field :role, type: Integer
  has_many :articles
  has_many :categories

  before_create :encrypt_password

  attr_accessor :password
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

 


def self.authenticate(email, password)
    user = User.where(:email => email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
end




  protected
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
