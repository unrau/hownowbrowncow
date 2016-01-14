module ApplicationHelper

  def render_markdown(markdown)
    filter = HTML::Pipeline::MarkdownFilter.new(markdown)
    return filter.call.html_safe
  end

end
