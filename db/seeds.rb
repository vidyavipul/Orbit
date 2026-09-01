if Rails.env.production?
  required_variables = %w[ORBIT_ADMIN_EMAIL ORBIT_ADMIN_USERNAME ORBIT_ADMIN_PASSWORD]
  missing_variables = required_variables.select { |name| ENV[name].blank? }

  if missing_variables.any?
    puts "Production demo data was not loaded."
    puts "To create the initial admin, set: #{missing_variables.join(', ')}"
  else
    email = ENV.fetch("ORBIT_ADMIN_EMAIL").strip.downcase
    admin = User.find_or_initialize_by(email: email)

    if admin.new_record?
      admin.assign_attributes(
        username: ENV.fetch("ORBIT_ADMIN_USERNAME"),
        password: ENV.fetch("ORBIT_ADMIN_PASSWORD"),
        password_confirmation: ENV.fetch("ORBIT_ADMIN_PASSWORD"),
        role: :admin,
        is_active: true
      )
      admin.save!
      puts "Created the initial production admin."
    else
      puts "The production admin already exists; no attributes were changed."
    end
  end
else
  load Rails.root.join("db/seeds/development.rb")
end
