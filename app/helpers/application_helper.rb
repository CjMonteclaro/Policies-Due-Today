module ApplicationHelper

  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def subtitle(subtitle)
    content_for(:subtitle) { (content_tag :small, subtitle).html_safe }
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end


  def format_date(date)
    date.try(:strftime,'%d %b %Y')
  end

  def nav_link(text, page, klass=nil)
    content_tag :li, (link_to text, page, class: "nav-link #{current?(page)} #{klass}"), class: 'nav-item'
  end

  def drop_link(text, page)
    link_to text, page, class: "dropdown-item"
  end

  def current?(page_name)
    "active" if current_page? page_name
  end


end
