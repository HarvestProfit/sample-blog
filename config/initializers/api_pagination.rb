ApiPagination.configure do |config|
  # If you have more than one gem included, you can choose a paginator.
  config.paginator = :kaminari # or :will_paginate

  # By default, this is set to 'Total'
  config.total_header = "Total"

  # By default, this is set to 'Per-Page'
  config.per_page_header = "Per-Page"

  # Optional: set this to add a header with the current page number.
  config.page_header = "Page"
end
