class Rollout
  include Mongoid::Document
  field :name, :type => String
  field :time, :type => Time
#  field :count, :tipe => Integer
  

  def self.lapsus
  	1.minute.ago
  end

  def self.mark(name)
  	if Rollout.where(name: name).any?
  		#r = Rollout.where(name: name).first
  		#if r.time < lapsus
  			#r.count = 1
  		  #r.time = Time.now
  		#else
  		#	r.time = Time.now
  			#r.count = r.count + 1
  		#end
      #r.count = Time.now
  		#r.save
  	else
  		#Rollout.create(name: name, time: Time.now, count: 1)
      Rollout.create(name: name, time: Time.now)
  	end
  end

  def self.overloaded?(name, lapso=nil)
  	lapso ||= lapsus 
  	Rollout.where(name: name, :time.gte => lapso).any?
  end

end
