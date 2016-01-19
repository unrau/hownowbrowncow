module ApplicationHelper

  def render_markdown(markdown)
    context = {
      :asset_root => "#{request.base_url}/images/"  # public images path for EmojiFilter
    }

    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::YoutubeFilter,
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::EmojiFilter
    ], context

    result = pipeline.call markdown
    return result[:output].to_s.html_safe
  end

  def render_twitter(tweet)
    context = {
      :asset_root => "#{request.base_url}/images/",  # public images path for EmojiFilter
      :tag_url => 'https://twitter.com/hashtag/%{tag}'  # Twitter hashtag URL
    }

    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::AutolinkFilter,
      HTML::Pipeline::HashtagFilter,
      HTML::Pipeline::EmojiFilter
    ], context

    result = pipeline.call tweet
    return result[:output].to_s.html_safe
  end

end
