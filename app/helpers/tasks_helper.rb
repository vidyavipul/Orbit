module TasksHelper
  def status_badge(task)
    if task.overdue?
      content_tag(:span, "Overdue", class: "badge badge-danger")
    else
      case task.status
      when "completed"
        content_tag(:span, "Completed", class: "badge badge-success")
      when "in_progress"
        content_tag(:span, "In Progress", class: "badge badge-warning")
      when "pending"
        content_tag(:span, "Pending", class: "badge badge-secondary") # Fallback style
      else
        content_tag(:span, task.status.titleize, class: "badge badge-secondary")
      end
    end
  end

  def priority_badge(priority)
    case priority
    when "high"
      content_tag(:span, "High", class: "badge badge-danger")
    when "medium"
      content_tag(:span, "Medium", class: "badge badge-warning")
    when "low"
      content_tag(:span, "Low", class: "badge badge-success")
    else
      content_tag(:span, priority.titleize, class: "badge badge-secondary")
    end
  end
end
