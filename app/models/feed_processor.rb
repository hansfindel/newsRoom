require 'feedzirra'

class FeedProcessor
  def self.process_feeds(data)
    #data = RawData.get_all
    entries = data.entries
    add_entries(entries)
  end

  private
  
  def self.add_entries(entries)
    entries.each do |entry|
      if Article.where(:guid => entry.id).empty?
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

end
