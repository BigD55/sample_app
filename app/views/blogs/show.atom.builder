atom_feed :language => 'de-DE' do |feed|
  feed.title @blog.title
  feed.updated Time.now

  @blog.blogposts.each do |item|
    next if item.created_at.blank?

    feed.entry( item ) do |entry|
      entry.title item.title
      entry.content :type => 'html' do entry.cdata!(item.content) end

      # the strftime is needed to work with Google Reader.
      entry.updated(item.created_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 
      entry.author item.user.name
    end
  end
end
