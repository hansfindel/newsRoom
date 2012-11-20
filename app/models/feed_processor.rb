require 'feedzirra'

class FeedProcessor
  def self.process_feeds(data)
    #data = RawData.get_all
    self.add_entries(data.entries)
  end

  private
  
  def self.add_entries(entries)
    entries.each do |entry|
      unless Article.where(:guid => entry.id).count > 0
          Article.create!(
            :headline                     => entry.title,
            :deck                         => entry.summary,
            :story                        => entry.content,
            :url                          => entry.url,
            :published_on                 => entry.published,
            :guid                         => entry.id,
            :category_names               => entry.categories,
            :is_published                 => false,
            :editors_grade                => 0,
            :chief_editor_grade           => 0, 
            :chief_editor_country_grade   => 0
          )
      end
    end
  end

  def self.add_entries_from_api(entries, api_values)
        entries['results'].each do |entry|
          a = Article.create!(
            :headline                     => entry['title'],
            :deck                         => entry['deck'],
            :url                          => entry['url'],
            :published_on                 => entry['published_on'],
            :guid                         => entry['url'],
            :story                        => entry['body'],
            :is_published                 => false,
            :editors_grade                => 0,
            :chief_editor_grade           => 0, 
            :chief_editor_country_grade   => 0
          )
      end
  end

end
