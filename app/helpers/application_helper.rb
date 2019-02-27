module ApplicationHelper
  include DeviseHelper 

  def full_title(page_title = '')
    base_title = "衢州吃喝玩乐"
    if page_title.empty?
      base_title
    else
      page_title
    end
  end

  def has_error?(resource, field)
    resource.errors.messages[field].present?
  end

  def get_error(resource, field)
    resource.errors.messages[field].join(', ')
  end 

  def reserve_words(word, length)
  end

  #markdown
  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      language ||= :plaintext
      #CodeRay.scan(code, language).div
      CodeRay.scan(code, language).div(line_numbers: :table)
    end
  end

  def markdown(text)
    coderayified = CodeRayify.new(hard_wrap: true)
  
    options = {
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      autolink: true,
      lax_html_blocks: true,
    }
  
    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    markdown_to_html.render(text).html_safe
  end
end
