module PolicyResolutionsHelper
  def ar_date_helper(label, date)
    content_tag :p do
      "#{content_tag(:small, label)}<br> #{content_tag(:span, format_date(date))}".html_safe
    end if date.present?
  end

  def ar_format_helper(label, value, flag)
    if value.present?
      # output = case value
      # when value.type == 'String'
      #   value
      # when value.type == 'Decimal'
      #   format_currency(value)
      # when value.type == 'Date'
      #   format_date(value)
      # end

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
end
