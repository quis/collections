atom_feed(language: 'en-GB', root_url: @organisation.web_url) do |feed|
  feed.title("#{@organisation.title} - Activity on GOV.UK")
  feed.author do |author|
    author.name('HM Government')
  end
  feed.updated(@items.first.updated) if @items.any?

  unless @organisation_status.nil?
    feed.entry(@organisation_status, id: feed_entry_id(@organisation.web_url, @organisation), url: @organisation.web_url, updated: public_updated_at(@organisation)) do |entry|
      entry.summary(@organisation_status)
    end
  end

  @items.each do |item|
    feed.entry(item, id: item.id, url: item.url, updated: item.updated) do |entry|
      entry.title(item.title)
      if item.display_type
        entry.category(label: item.display_type, term: item.display_type)
      end
      entry.summary(item.description)
    end
  end
end
