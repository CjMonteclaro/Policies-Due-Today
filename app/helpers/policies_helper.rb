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

  def policy_type_tagger(number, mother_policy=nil)
    if mother_policy
      tag = "Mother Policy"
    else
      tag = "Endorsement"
    end

    (number + content_tag(:span, tag, class: 'badge badge-pill badge-light ml-4 text-dark')).html_safe
  end

  def show_view_row_helper(label, content, amount_tag=nil, total_tag=nil)
    content_tag :tr, class: ("h5 bg-success text-white" if total_tag) do
      (content_tag :th, label) + (content_tag :td, content, class: ("text-right" if amount_tag))
    end
  end

  def show_view_table_helper(label, content, p_class=nil, span_class=nil )
    content_tag :p, class: ("#{p_class}" if p_class) do
      (content_tag :b, label) + (content_tag :span, content, class: ("#{span_class}" if span_class))
    end
  end

end
