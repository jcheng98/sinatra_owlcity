# file: owl_city.rb
require_relative 'scraping.rb'

account_sid = 'ACe330ba04d082392df4cb3511dcb72cec'
auth_token = '2008ea097713e401a16c54029058da82'

class Texting

  def recipient=(recipient)
    @recipient = recipient
  end

  def recipient
    @recipient
  end

  def body=(body)
    @body = body
  end

  def body
    @body
  end

  def send(account_sid, auth_token)


    @client = Twilio::REST::Client.new(account_sid, auth_token)

    Tweet.create_tweets

    #an array of all tweets

    @tweets = []

    Tweet.all.each do |t|
      @tweets << "#{t.body} (tweeted #{t.time} ago)"
    end

    if @tweets.length > 1
      @tweets.each do |tweet|
      @client.account.messages.create(
        :from => '+18152642023',
        :to => ENV[MY_PHONE_NUMBER],
        :body => tweet
      )
      end
    end

  end

end


