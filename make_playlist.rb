require 'open-uri'
require 'nokogiri'

class PodCast
  def set_info(name,url)
    @name = name
    @url = url
  end

  def url
    @url
  end

  def name
    @name
  end

  def clean_name
    clean_name_step1 = @name.gsub(',', '')
    clean_name_step2 = clean_name_step1.gsub('-', '')
    clean_name_step3 = clean_name_step2.gsub('/', '')
  end
end

array_of_podcasts = []
url = "https://itunes.apple.com/us/podcast/international-departures-podcast/id534194714"
doc = Nokogiri::HTML(open(url))

html_body = doc.css("tbody")

html_body.css("tr").each do |set|
  podcast = PodCast.new
  v = set.values
  if v[2] == "episode"
    name = v[8]
    url  = v[5]
    podcast.set_info(name,url)
  elsif v[2] == "movie"
    name = v[8]
    url  = v[10]
    podcast.set_info(name,url)
  end
  array_of_podcasts << podcast
end

filename = "MS54.m3u"
outFile = File.new(filename, "w")
outFile.puts("#EXTM3U")
array_of_podcasts.each do |podcast|
  clean_name = podcast.clean_name

  outFile.puts("#EXTINF:0000,#{clean_name}")
  outFile.puts("#{podcast.url}")
end
outFile.close

puts "Your playlist has been created the file name is #{filename}"