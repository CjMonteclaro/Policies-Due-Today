module PolicyResolutionsHelper
  def ar_date_helper(label, date)
    content_tag :p do
      "#{content_tag(:small, label)}<br> #{content_tag(:span, format_date(date))}".html_safe
    end if date.present?
  end

  def ar_format_helper(label, value, flag)
    if value.present?

      formatted_value = case flag
      when 1
        value
      when 2
        format_currency(value)
      when 3
        format_date(value)
      end

      content_tag :p do
        "#{content_tag(:small, label)}<br> #{content_tag(:span, formatted_value)}".html_safe
      end
    end
  end

  def show_row_helper(label, content)
    content_tag :tr do
      (content_tag :th, label) + (content_tag :td, content, class: "text-right")
    end
  end

end
