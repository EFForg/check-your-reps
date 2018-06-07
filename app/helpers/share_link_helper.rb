# frozen_string_literal: true
module ShareLinkHelper
  def share_link(type)
    fixed_type = type.to_s.gsub(/\W/, "")
    attrs = { class: "share-#{fixed_type}", target: "_blank", rel: "noopener noreferrer" }
    link_to send("#{fixed_type}_share_url"), attrs do
      content_tag(:i) +
      content_tag(:span) {
        "Share on #{type.to_s.capitalize}"
      }
    end
  end

  def twitter_share_url(status = nil)
    status ||= I18n.t("tweet.message.generic")
    "https://twitter.com/intent/tweet?" +
    {
      text: status,
      related: Rails.application.config.twitter_related.to_a.join(",")
    }.to_query
  end

  def google_share_url
    "https://plus.google.com/share?#{{url: url_for_share}.to_query}"
  end

  def facebook_share_url
    "https://www.facebook.com/sharer/sharer.php?" +
    {
      u: url_for_share,
      display: "popup"
    }.to_query
  end

  def tweet_score_link(score)
    message = tweet_score_message(score)
    link_to "Tweet", twitter_share_url(message), { target: "_blank", rel: "noopener noreferrer" }
  end

  def tweet_score_message(score)
    # 'yes' and 'no' are reserved words in YAML,
    # so use 'for' and 'against' instead
    position = case score.position.downcase
    when "yes"
      "for"
    when "no"
      "against"
    else
      "undecided"
    end

    handle = score.congress_member.twitter_handle

    [
      I18n.t("tweet.message.#{position}", handle: handle),
      I18n.t("tweet.message.suffix")
    ].join(" ")
  end

  def url_for_share
    "https://checkyourreps.org"
  end
end
