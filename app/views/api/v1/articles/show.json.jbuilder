json.article do
  if @articles&.empty?
    json.error("No")
  else
    json.title(@article[:title])
    json.description(@article[:description])
    json.author(@article.user.username)
  end
end