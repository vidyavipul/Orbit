require 'will_paginate/view_helpers/action_view'

# Custom will_paginate renderer matching the Orbit prototype circular buttons
class OrbitPaginationRenderer < WillPaginate::ActionView::LinkRenderer
  protected

  def html_container(html)
    tag(:div, html, class: "pagination-pages")
  end

  def page_number(page)
    if page == current_page
      tag(:span, page, class: "pagination-btn active")
    else
      link(page, page, class: "pagination-btn")
    end
  end

  def previous_page
    num = @collection.current_page > 1 && @collection.current_page - 1
    previous_or_next_page(num, "‹", "pagination-btn")
  end

  def next_page
    num = @collection.current_page < total_pages && @collection.current_page + 1
    previous_or_next_page(num, "›", "pagination-btn")
  end

  def previous_or_next_page(page, text, classname)
    if page
      link(text, page, class: classname)
    else
      tag(:span, text, class: "#{classname} disabled")
    end
  end

  def gap
    tag(:span, "…", class: "pagination-btn disabled")
  end
end
