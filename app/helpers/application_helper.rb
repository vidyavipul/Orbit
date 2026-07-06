module ApplicationHelper
  # Returns the user's initials for avatar display.
  def user_initials(user)
    user.username.split(/[\s_.-]+/).map { |part| part[0] }.join.upcase[0, 2]
  end

  def format_date(date)
    return "N/A" unless date
    date.strftime("%b %d, %Y")
  end

  def truncate_text(text, length: 100)
    truncate(text, length: length)
  end

  def page_title(title)
    content_for(:title, title)
  end
end
