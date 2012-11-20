class RawData
  require 'uri'
  require 'json'
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
     	data.entries.each do |entry|
      puts entry.title
      a = Article.new(
          :headline                     => entry.title,
          :deck                         => entry.summary,
          :url                          => entry.url,
          :published_on                 => entry.published,
          :guid                         => entry.id,
          :category_names               => entry.categories,
          :is_published                 => false,
          :editors_grade                => 0,
          :chief_editor_grade           => 0, 
          :chief_editor_country_grade   => 0
        )
        my_uri = URI.parse(entry.id)
    	  File.open("public/feeds/"+my_uri.host+entry.id.split('/').last+".json", "w") do |f|
          f. << a.to_json
        end
        value << data
      end
    end
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
