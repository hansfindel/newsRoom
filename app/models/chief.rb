class Chief
    include Mongoid::Document
    
    field :boss, :type => String
    field :slave, :type => String
    
    validates_uniqueness_of :slave, message: "already has boss" 
  
end