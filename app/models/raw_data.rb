class RawData
  require 'uri'
  require 'json'
  #include Mongoid::Document
  #field :value, type: Feed
  #field :data, type: Array

  #result_pos indica donde se guardan los articulos en el json recibido
  def self.store_from_api(data, api_values, result_pos)
    if data.nil? 
      #value = "No new feeds"
      value = []
    else
      data[result_pos].each do |entry|
        a = Article.new(
          :headline                     => entry[api_values['headline']],
          :deck                         => entry[api_values['deck']],
          :url                          => entry[api_values['url']],
          :published_on                 => entry[api_values['published_on']],
          :guid                         => entry[api_values['url']],
          :story                        => entry[api_values['story']],
          :is_published                 => false,
          :editors_grade                => 0,
          :chief_editor_grade           => 0, 
          :chief_editor_country_grade   => 0
        )
        my_uri = URI.parse(entry['url'])
        File.open("public/feeds/"+my_uri.host+entry['url'].split('/').last+".json", "w") do |f|
          f. << a.to_json
        end
      end
    end
  end

  def self.store(data, value=[])

    if data.nil? 
      #value = "No new feeds"
      value = []
    else
     	data.entries.each do |entry|
            
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
