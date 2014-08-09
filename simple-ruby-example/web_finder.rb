require 'redis'
require 'opengraph_parser'
require 'json'

redis = Redis.new
URL_KEY = 'urls'
OG_DATA_KEY = 'og_data'

while (url = redis.lpop(URL_KEY)) do
  og = OpenGraph.new(url)
  record = {'url' => og.url, 'title' => og.title, 'type' => og.type,
             'description' => og.description, 'image' => og.images.first}
  redis.hset OG_DATA_KEY, url, record.to_json
end
