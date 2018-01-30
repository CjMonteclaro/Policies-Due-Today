Ransack.configure do |config|

  # Change default search parameter key name.
  # Default key name is :q
  config.search_key = :q

  # Raise errors if a query contains an unknown predicate or attribute.
  # Default is true (do not raise error on unknown conditions).
  config.ignore_unknown_conditions = false

  # Globally display sort links without the order indicator arrow.
  # Default is false (sort order indicators are displayed).
  # This can also be configured individually in each sort link (see the README).
  config.hide_sort_order_indicators = false

  config.add_predicate 'between',
    arel_predicate: 'between',
    formatter: proc { |v|
      parts = v.split(',')
      OpenStruct.new(begin: parts[0], end: parts[1])
    },
    validator: proc { |v| v.present? },
    type: :date

end
