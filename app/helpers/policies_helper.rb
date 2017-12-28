module PoliciesHelper
  def format_date(date)
    date.try(:strftime,'%d %b %Y')
  end

  def format_currency(amount)
    number_to_currency(amount, unit: "")
  end

  def shorten(string, length)
    truncate(string, length: length)
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end

  def format_days(number_of_days)
    pluralize(number_of_days, 'day')
  end
end
