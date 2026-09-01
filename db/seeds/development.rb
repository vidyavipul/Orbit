# This file intentionally rebuilds local demo data from scratch.
# It is loaded by db/seeds.rb only outside production.

demo_password = "password123"

users_data = [
  { key: :admin, username: "Sarah", email: "admin@orbit.com", role: :admin, employee_code: 1001, is_active: true },
  { key: :manager_one, username: "Marcus", email: "marcus@orbit.com", role: :manager, employee_code: 1002, is_active: true },
  { key: :manager_two, username: "Elena", email: "elena@orbit.com", role: :manager, employee_code: 1003, is_active: true },
  { key: :employee_one, username: "Priya", email: "employee1@orbit.com", role: :employee, employee_code: 2001, is_active: true },
  { key: :employee_two, username: "Liam", email: "employee2@orbit.com", role: :employee, employee_code: 2002, is_active: true },
  { key: :employee_three, username: "Sofia", email: "employee3@orbit.com", role: :employee, employee_code: 2003, is_active: true },
  { key: :employee_four, username: "Noah", email: "employee4@orbit.com", role: :employee, employee_code: 2004, is_active: true },
  { key: :employee_five, username: "Aisha", email: "employee5@orbit.com", role: :employee, employee_code: 2005, is_active: true },
  { key: :employee_six, username: "Mateo", email: "employee6@orbit.com", role: :employee, employee_code: 2006, is_active: true },
  { key: :employee_seven, username: "Mei", email: "employee7@orbit.com", role: :employee, employee_code: 2007, is_active: true },
  { key: :employee_eight, username: "Daniel", email: "employee8@orbit.com", role: :employee, employee_code: 2008, is_active: true },
  { key: :employee_nine, username: "Leila", email: "employee9@orbit.com", role: :employee, employee_code: 2009, is_active: true },
  { key: :inactive_employee, username: "Arjun", email: "employee10@orbit.com", role: :employee, employee_code: 2010, is_active: false }
]

projects_data = [
  {
    key: :website_redesign,
    title: "Website Redesign",
    description: "Modernize Orbit's public website with clearer navigation, accessible interactions, and responsive layouts.",
    deadline_in_days: 35,
    status: :active,
    tasks: [
      { key: :audit_navigation, title: "Audit navigation and information architecture", due_in_days: 5, priority: :high, status: :in_progress, assignee: :employee_one },
      { key: :accessible_tables, title: "Implement accessible project tables", due_in_days: 12, priority: :medium, status: :pending, assignee: :employee_two },
      { key: :responsive_dashboard, title: "Build the responsive dashboard layout", due_in_days: 20, priority: :high, status: :pending, assignee: :employee_three },
      { key: :website_release, title: "Prepare the website release checklist", due_in_days: 28, priority: :low, status: :pending, assignee: :admin }
    ]
  },
  {
    key: :mobile_beta,
    title: "Mobile App Beta",
    description: "Prepare a focused mobile beta that validates onboarding, notifications, and the core task workflow.",
    deadline_in_days: 60,
    status: :active,
    tasks: [
      { key: :api_contract, title: "Define the mobile API contract", due_in_days: 10, priority: :high, status: :completed, assignee: :manager_one },
      { key: :onboarding_prototype, title: "Prototype the mobile onboarding flow", due_in_days: 18, priority: :medium, status: :in_progress, assignee: :employee_four },
      { key: :notification_preferences, title: "Add notification preferences", due_in_days: 30, priority: :medium, status: :pending, assignee: :employee_five },
      { key: :beta_test, title: "Coordinate the closed beta test", due_in_days: 45, priority: :high, status: :pending, assignee: :employee_six }
    ]
  },
  {
    key: :support_automation,
    title: "Customer Support Automation",
    description: "Reduce response time by classifying support requests and defining safe escalation rules for complex issues.",
    deadline_in_days: 45,
    status: :active,
    tasks: [
      { key: :ticket_samples, title: "Categorize representative ticket samples", due_in_days: 7, priority: :medium, status: :completed, assignee: :employee_seven },
      { key: :escalation_rules, title: "Build support escalation rules", due_in_days: 16, priority: :high, status: :in_progress, assignee: :manager_two },
      { key: :agent_playbook, title: "Draft the support agent playbook", due_in_days: 24, priority: :low, status: :pending, assignee: :employee_eight }
    ]
  },
  {
    key: :onboarding_portal,
    title: "Employee Onboarding Portal",
    description: "Give new employees one place to track required documents, training, access requests, and first-week progress.",
    deadline_in_days: 25,
    status: :active,
    tasks: [
      { key: :onboarding_workflow, title: "Map the employee onboarding workflow", due_in_days: 4, priority: :high, status: :in_progress, assignee: :manager_one },
      { key: :document_checklist, title: "Create the required document checklist", due_in_days: 9, priority: :medium, status: :pending, assignee: :employee_nine },
      { key: :progress_dashboard, title: "Add onboarding progress tracking", due_in_days: 15, priority: :medium, status: :pending, assignee: :employee_one },
      { key: :privacy_review, title: "Review onboarding data access", due_in_days: 20, priority: :high, status: :pending, assignee: :admin }
    ]
  },
  {
    key: :analytics_dashboard,
    title: "Analytics Dashboard",
    description: "Deliver a compact reporting dashboard for weekly delivery, workload, and project health metrics.",
    deadline_in_days: 14,
    status: :completed,
    tasks: [
      { key: :business_metrics, title: "Confirm the dashboard business metrics", due_in_days: 0, priority: :high, status: :completed, assignee: :manager_two },
      { key: :weekly_report, title: "Build the weekly delivery report", due_in_days: 1, priority: :medium, status: :completed, assignee: :employee_two },
      { key: :sample_dataset, title: "Validate the analytics sample dataset", due_in_days: 2, priority: :medium, status: :completed, assignee: :employee_three }
    ]
  },
  {
    key: :database_migration,
    title: "Database Migration",
    description: "Move legacy operational data into PostgreSQL with rehearsed rollback and verification procedures.",
    deadline_in_days: 70,
    status: :active,
    tasks: [
      { key: :legacy_inventory, title: "Inventory the legacy database tables", due_in_days: 14, priority: :high, status: :in_progress, assignee: :employee_four },
      { key: :rollback_plan, title: "Design the database rollback plan", due_in_days: 21, priority: :high, status: :pending, assignee: :admin },
      { key: :staging_rehearsal, title: "Rehearse migration in staging", due_in_days: 42, priority: :medium, status: :pending, assignee: :employee_five },
      { key: :verification_queries, title: "Document migration verification queries", due_in_days: 50, priority: :low, status: :pending, assignee: :employee_six }
    ]
  },
  {
    key: :launch_campaign,
    title: "Q4 Launch Campaign",
    description: "Coordinate launch messaging, customer communication, creative assets, and post-launch measurement.",
    deadline_in_days: 55,
    status: :active,
    tasks: [
      { key: :campaign_brief, title: "Approve the campaign brief", due_in_days: 8, priority: :high, status: :completed, assignee: :manager_one },
      { key: :launch_assets, title: "Produce the launch creative assets", due_in_days: 20, priority: :medium, status: :in_progress, assignee: :employee_seven },
      { key: :customer_emails, title: "Schedule the customer email sequence", due_in_days: 32, priority: :medium, status: :pending, assignee: :employee_eight },
      { key: :campaign_analytics, title: "Review post-launch campaign analytics", due_in_days: 48, priority: :low, status: :pending, assignee: :employee_nine }
    ]
  }
]

comments_data = [
  { task: :audit_navigation, author: :employee_one, body: "I found two navigation paths that need clearer labels and keyboard focus states." },
  { task: :audit_navigation, author: :manager_one, body: "Please include the mobile navigation findings in the final audit." },
  { task: :accessible_tables, author: :admin, body: "Use real links so the rows remain usable without JavaScript." },
  { task: :onboarding_prototype, author: :employee_four, body: "The first prototype now covers account creation and the initial workspace tour." },
  { task: :escalation_rules, author: :manager_two, body: "The security and billing categories should always require a human review." },
  { task: :onboarding_workflow, author: :employee_nine, body: "I added the document verification step after the manager approval." },
  { task: :privacy_review, author: :admin, body: "Limit sensitive onboarding documents to administrators and the assigned manager." },
  { task: :weekly_report, author: :employee_two, body: "The report now separates completed work from work carried into the next week." },
  { task: :rollback_plan, author: :employee_six, body: "I added validation queries we can run before deciding whether to roll back." },
  { task: :launch_assets, author: :manager_one, body: "Please prepare both light and dark variants of the final campaign graphics." }
]

ActiveRecord::Base.transaction do
  puts "Clearing existing local demo data..."
  Comment.delete_all
  Task.delete_all
  Project.delete_all
  User.delete_all

  puts "Creating users..."
  users = users_data.to_h do |user_data|
    key = user_data.fetch(:key)
    attributes = user_data.except(:key).merge(password: demo_password, password_confirmation: demo_password)
    [ key, User.create!(attributes) ]
  end

  puts "Creating projects and tasks..."
  tasks = {}

  projects_data.each do |project_data|
    project = Project.create!(
      title: project_data.fetch(:title),
      description: project_data.fetch(:description),
      deadline: project_data.fetch(:deadline_in_days).days.from_now,
      status: project_data.fetch(:status)
    )

    project_data.fetch(:tasks).each do |task_data|
      task = project.tasks.create!(
        title: task_data.fetch(:title),
        description: "Complete this deliverable and record decisions, review notes, and follow-up work in Orbit.",
        due_date: Date.current + task_data.fetch(:due_in_days),
        priority: task_data.fetch(:priority),
        status: task_data.fetch(:status),
        user: users.fetch(task_data.fetch(:assignee))
      )
      tasks[task_data.fetch(:key)] = task
    end
  end

  puts "Creating task comments..."
  comments_data.each do |comment_data|
    Comment.create!(
      task: tasks.fetch(comment_data.fetch(:task)),
      user: users.fetch(comment_data.fetch(:author)),
      body: comment_data.fetch(:body)
    )
  end
end

puts "Seeding complete!"
puts "----------------------------------------"
puts "Admin: admin@orbit.com / #{demo_password}"
puts "Manager: marcus@orbit.com / #{demo_password}"
puts "Employee: employee1@orbit.com / #{demo_password}"
puts "Users: #{User.count} (#{User.active.count} active, #{User.inactive.count} inactive)"
puts "Projects: #{Project.count} (#{Project.active.count} active, #{Project.completed.count} completed)"
puts "Tasks: #{Task.count} (#{Task.pending.count} pending, #{Task.in_progress.count} in progress, #{Task.completed.count} completed)"
puts "Comments: #{Comment.count}"
