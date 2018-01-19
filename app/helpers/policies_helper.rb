module PoliciesHelper
  def format_date(date)
    date.try(:strftime,'%d %b %Y')
  end

  def format_currency(amount, unit=nil)
    number_to_currency(amount, unit: "#{unit} ")
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

  def endorsement_class_helper(main_object_id, instance_id)
    'bg-success p-2 mr-2' if main_object_id == instance_id
  end

  def row_span_helper(policy)
    count = policy.policy_item_perils.count
    if count > 1
      count + 1
    else
      count + 1
    end
  end

  def policy_type_helper(policy_type)
    if policy_type
      content_tag :span, "Endorsement", class: 'badge badge-pill badge-primary'
    else
      content_tag :span, "Master", class: 'badge badge-pill badge-primary'
    end
  end
end
