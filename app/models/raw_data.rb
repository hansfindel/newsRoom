class RawData
  #include Mongoid::Document
  #field :value, type: Feed
  #field :data, type: Array

  def self.store(data, value=[])
  	#could write in a "temporal" folder
  	#not implemented
  	
  	#save it on the data base
    if data.nil? 
      #value = "No new feeds"
      value = []
    else
      data = get_data data
    	data.entries.each do |feed|
    		#value = self.new(:value => feed)#, :data => data.entries)
    		#value.save
    		value << feed
    	end
    end
    value
  end

  private

  def self.get_data data
    if data.class.eql?(Array)
      return data
    else
      return []
    end
  end

end



# def self.store(data, value=[])
#    if data.nil? 
#      value = []
#    else
#      data = get_data data
#      data.entries.each do |feed|
#        value << feed
#      end
#    end
#    value
#  end