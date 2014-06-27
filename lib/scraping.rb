# file: owl_city.rb

require 'nokogiri'
require 'open-uri'
# require 'pry'

class ScrapeTweet

  def initialize
    owl_city_html = open('https://twitter.com/owlcity')
    @owl_city_doc = Nokogiri::HTML(owl_city_html)
  end

  def scrape_tweet_data
    updates = []
   # Iterate through the updates
    @owl_city_doc.css("div.StreamItem div.ProfileTweet").each do |project|
      date = project.css(".ProfileTweet-timestamp").text.strip #css of date
      if date[-1] == "m" || date[-1] == "s" # check if last character is an m - strings have indexes
        updates << {
          :body => project.css(".ProfileTweet-text").text,
          :time_stamp => project.css(".ProfileTweet-timestamp").text.strip
        }
      end
    end
    updates
  end
end
                                                  



class Tweet

  #body reader and writer
  #time reader and writer

  # attr_reader
  # attr_writer
  # attr_accessor

  # def initialize
  #   @body
  #   @time
  # end

  def body
    @body
  end

  def body=(body)
    @body = body
  end

  def time
    @time
  end

  def time=(time)
    @time = time
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end

  #a method that will give us the update array

  def self.create_tweets
    scraped_data = ScrapeTweet.new

    # binding.pry
    
    updates = scraped_data.scrape_tweet_data
    updates.each do |hash|
      hash_name = hash[:body][0..10]
      hash_name = Tweet.new
      hash.each do |k, v|
        hash_name.body= hash[:body]
        hash_name.time= hash[:time_stamp]
      end
    end
  end

  #create a new instance of your ScrapeTweet class.
  #class scrape_tweet_time on that instance

end

