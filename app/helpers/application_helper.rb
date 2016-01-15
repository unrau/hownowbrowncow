module ApplicationHelper

  def render_markdown(markdown)
    context = {
      :asset_root => "#{request.base_url}/images/"
    }

    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::YoutubeFilter,
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::EmojiFilter
    ], context

    result = pipeline.call markdown
    return result[:output].to_s.html_safe
  end

end
