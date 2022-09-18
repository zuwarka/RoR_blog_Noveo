json.articles do
  if @articles&.empty?
    json.error("No")
  else
    json.array! @articles do |article|
      json.title(article[:title])
      json.description(article[:description])
      json.author(article.user.username)
    end
  end
end