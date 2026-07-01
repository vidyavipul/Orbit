puts "\n--- Testing Validations ---"

# 1. Valid Project
p1 = Project.new(title: "Website Redesign", description: "Update homepage", deadline: 1.week.from_now)
puts "1. Valid Project: #{p1.valid?} (Expected: true)"

# 2. Missing Title
p2 = Project.new(description: "Update homepage", deadline: 1.week.from_now)
puts "2. Missing Title: #{p2.valid?} (Expected: false)"
puts "   Errors: #{p2.errors.full_messages.join(', ')}"

# 3. Missing Description
p3 = Project.new(title: "Website Redesign", deadline: 1.week.from_now)
puts "3. Missing Description: #{p3.valid?} (Expected: false)"
puts "   Errors: #{p3.errors.full_messages.join(', ')}"

# 4. Missing Deadline
p4 = Project.new(title: "Website Redesign", description: "Update homepage")
puts "4. Missing Deadline: #{p4.valid?} (Expected: false)"
puts "   Errors: #{p4.errors.full_messages.join(', ')}"

# 5. Deadline in the past
p5 = Project.new(title: "Website Redesign", description: "Update homepage", deadline: 1.day.ago)
puts "5. Past Deadline: #{p5.valid?} (Expected: false)"
puts "   Errors: #{p5.errors.full_messages.join(', ')}"

puts "---------------------------\n"
