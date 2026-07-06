# Clear existing data
puts "Clearing old data..."
Comment.destroy_all
Task.destroy_all
Project.destroy_all
User.destroy_all

puts "Creating users..."
# Admin
admin = User.create!(
  username: "Sarah",
  email: "admin@orbit.com",
  password: "password123",
  password_confirmation: "password123",
  role: "admin",
  employee_code: 1001,
  is_active: true
)

# Managers
manager1 = User.create!(
  username: "Marcus",
  email: "marcus@orbit.com",
  password: "password123",
  password_confirmation: "password123",
  role: "manager",
  employee_code: 1002,
  is_active: true
)

manager2 = User.create!(
  username: "Elena",
  email: "elena@orbit.com",
  password: "password123",
  password_confirmation: "password123",
  role: "manager",
  employee_code: 1003,
  is_active: true
)

# Employees
employees = []
10.times do |i|
  employees << User.create!(
    username: "Employee #{i + 1}",
    email: "employee#{i + 1}@orbit.com",
    password: "password123",
    password_confirmation: "password123",
    role: "employee",
    employee_code: 2000 + i,
    is_active: true
  )
end
all_users = [admin, manager1, manager2] + employees

puts "Creating projects..."
project_titles = [
  "Website Redesign", 
  "Q3 Marketing Campaign", 
  "Mobile App V2.0", 
  "Database Migration", 
  "Employee Onboarding Portal",
  "Customer Support AI",
  "Annual Financial Audit",
  "Social Media Strategy"
]

projects = []
project_titles.each_with_index do |title, index|
  status = index % 3 == 0 ? "completed" : "active"
  # Ensure deadline is in the future
  deadline = (index * 10 + 15).days.from_now
  
  projects << Project.create!(
    title: title,
    description: "This is a detailed description for the #{title} project. It outlines all the necessary goals, resources, and timelines required to successfully complete the objective. Team members should refer to this project hub for all related tasks.",
    deadline: deadline,
    status: status
  )
end

puts "Creating tasks..."
priorities = ["low", "medium", "high"]
statuses = ["pending", "in_progress", "completed"]

task_titles = [
  "Design mockups", "Write API documentation", "Setup CI/CD", 
  "Client kickoff meeting", "Database schema review", "Frontend implementation",
  "User testing", "Fix critical bugs", "Deploy to production", "Write marketing copy",
  "Review analytics", "Update dependencies", "Create presentation", "Onboard new hire"
]

tasks = []
projects.each do |project|
  # Create 3-8 tasks per project
  rand(3..8).times do |i|
    status = project.completed? ? "completed" : statuses.sample
    due_date = project.deadline ? project.deadline - rand(1..5).days : rand(1..30).days.from_now
    
    tasks << Task.create!(
      title: "#{task_titles.sample} - Part #{i + 1}",
      description: "Detailed instructions for this specific task. Please ensure all acceptance criteria are met before marking as completed.",
      due_date: due_date,
      priority: priorities.sample,
      status: status,
      project_id: project.id,
      user_id: all_users.sample.id
    )
  end
end

puts "Creating comments..."
tasks.each do |task|
  # Add 0-3 comments per task
  rand(0..3).times do
    Comment.create!(
      body: ["Great progress on this!", "Can we discuss this in the next sync?", "I'm blocked on step 2.", "Looks good to me, approved.", "I've uploaded the requested files.", "Please review the latest PR."].sample,
      task_id: task.id,
      user_id: all_users.sample.id
    )
  end
end

puts "Seeding complete!"
puts "----------------------------------------"
puts "Admin Login: admin@orbit.com / password123"
puts "Total Users: #{User.count}"
puts "Total Projects: #{Project.count}"
puts "Total Tasks: #{Task.count}"
puts "Total Comments: #{Comment.count}"
