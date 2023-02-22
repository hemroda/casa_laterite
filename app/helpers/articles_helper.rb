module ArticlesHelper
  def markdown(text)
    extensions = %i[
      hard_wrap
      autolink
      no_intra_emphasis
      tables
      fenced_code_blocks
      disable_indented_code_blocks
      strikethrough
      lax_spacing
      space_after_headers
      quote
      footnotes
      highlight
      underline
    ]
    # Markdown.new(text, *extensions).to_html
    Markdown.new(text, *extensions).to_html.html_safe
  end

  def advanced_markdown(text)
    render_options = {
      no_links: false,
      hard_wrap: true,
      link_attributes: {
        target: "_blank"
      }
    }
    extensions = {
      disable_indented_code_blocks: true,
      hard_wrap: true,
      autolink: true,
      no_intra_emphasis: true,
      tables: true,
      fenced_code_blocks: true,
      strikethrough: true,
      lax_spacing: true,
      space_after_headers: true,
      quote: true,
      footnotes: true,
      highlight: true,
      underline: true
    }
    renderer = Redcarpet::Render::HTML.new(render_options)
    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end
end
