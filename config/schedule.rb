every 2.hours do
  rake "movienight:fetch"
end

every 1.hours do
  rake "tmdb:reindex"
end
