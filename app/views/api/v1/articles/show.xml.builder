xml.rss('version' => '2.0') do

  if @articles&.empty?
    xml.error('No articles')
  else
    xml.article('type' => 'article') do
      xml.title(@article[:title], 'type' => 'article_title')
      xml.tag!('description', @article[:description])
      xml.author(@article.user.username)
    end
  end
end