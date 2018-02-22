module TweetHelper
 def tweet_link(score)
   url = "https://twitter.com/intent/tweet?" +
    {
      status: tweet_message(score),
      related: Rails.application.config.twitter_related.to_a.join(',')
   }.to_query

   link_to 'Tweet', url, target: "_blank"
 end

  def tweet_message(score)
    # 'yes' and 'no' are reserved words in YAML,
    # so use 'for' and 'against' instead
    position = case score.position.downcase
    when 'yes'
      'for'
    when 'no'
      'against'
    else
      'undecided'
    end

    handle = score.congress_member.twitter_handle

    [
      I18n.t("tweet.message.#{position}", handle: handle),
      I18n.t("tweet.message.suffix")
    ].join(' ')
  end
end
