require 'feedzirra'

class FeedProcessor
  def self.process_feeds(data)
    #data = RawData.get_all
    if data and data.class != Fixnum
      entries = data.entries
      add_entries(entries)
    end

  end

  private
  
  def self.add_entries(entries)
    random = false
    entries.each do |entry|
      unless Article.where(:guid => entry.id).count > 0
          Article.create(
            :headline                     => entry.title || "headline",
            :deck                         => entry.summary,
            :story                        => entry.content,
            :url                          => entry.url,
            :published_on                 => entry.published,
            :guid                         => entry.id,
            :category_names               => entry.categories,
            :is_published                 => random,
            :editors_grade                => 0,
            :chief_editor_grade           => 0, 
            :chief_editor_country_grade   => 0          )
      end
      random = !random 
    end
  end

  def self.add_entries_from_api(entries, api_values, results_pos)
        entries[results_pos].each do |entry|
          a = Article.create!(
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
      end
  end

end
