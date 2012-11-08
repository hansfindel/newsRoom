require 'feedzirra'

class FeedProcessor
  def self.process_feeds(data)
    #data = RawData.get_all
    add_entries(data.entries)
  end

  private
  
  def self.add_entries(entries)
    entries.each do |entry|
      unless Article.where(:guid => entry.id).any?
        Article.create!(
          :headline        => entry.title,
          :deck            => entry.summary,
          :story           => entry.content,
          :url             => entry.url,
          :published_on    => entry.published,
          :guid            => entry.id,
          :categories      => entry.categories
        )
      end
    end
  end

end
