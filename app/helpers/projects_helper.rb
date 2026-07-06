module ProjectsHelper
  def project_status_badge(project)
    if project.overdue?
      content_tag(:span, "Overdue", class: "badge badge-danger")
    elsif project.completed?
      content_tag(:span, "Completed", class: "badge badge-success")
    else
      content_tag(:span, project.status.titleize, class: "badge badge-success")
    end
  end
end
