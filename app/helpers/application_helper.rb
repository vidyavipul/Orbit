module ApplicationHelper
  # Returns the user's initials for avatar display.
  def user_initials(user)
    user.username.split(/[\s_.-]+/).map { |part| part[0] }.join.upcase[0, 2]
  end
end
