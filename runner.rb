require 'redis'
require 'benchmark'

redis = Redis.new

urls = File.readlines('urls.txt').collect { |url| url.strip }

URLS_KEY = 'urls'
OG_DATA_KEY = 'og_data'

# clear out any pre-existing data
redis.del URLS_KEY
redis.del OG_DATA_KEY

# load the URLS
urls.each do |url|
  redis.lpush URLS_KEY, url
end

# run a Web Finder process
# TODO need to do warmup for JVM processes
output = nil
Benchmark.bm do |bm|
  bm.report {
    output = `ruby simple-ruby-example/web_finder.rb`
  }
  puts output
end

# validate the results

# report on the run
keys = redis.hkeys OG_DATA_KEY
puts "keys count: #{keys.count}"
# keys.each do |k|
#   record = redis.hget OG_DATA_KEY, k
#   puts record
#   puts
# end
