class Picture
  include Mongoid::Document
  field :name, type: String
  field :image, type: String
  attr_accessible :remote_image_url, :name, :image

  embedded_in :article
  mount_uploader :image, ImageUploader  #uploads the file
  
  before_create :default_name

  def default_name
    self.name ||= File.basename(image.filename, '.*').titleize if image
  end

  #innecesario.... no lo estoy usando
  def picture_save 
  	uploader = ImageUploader.new
  	uploader.store!(image)
  	image = uploader.store_dir
  	save
  end

end
