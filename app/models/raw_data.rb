class RawData
  #include Mongoid::Document
  #field :value, type: Feed
  #field :data, type: Array

  def self.store(data, value=[])
  	#could write in a "temporal" folder
  	#not implemented
  	
  	#save it on the data base
    if data.nil?
      value = "No new feeds"
    else
    	data.entries.each do |feed|
    		unless exists? :guis => feed.id
          Article.create!(
            :headline => entry.title,
            :deck => entry.summary,
            :url => entry.url,
            :published_on => entry.published_at
            :guid => entry.guid
            )
    		  value << feed
    	end
    end
  end


end
