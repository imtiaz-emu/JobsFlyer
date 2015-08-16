# Create admin user
if User.where(email: 'admin@jobsflyer.com').count > 0
  puts 'Admin User already exist and skip to create admin user'
else
  puts 'Creating Admin User....'
  User.create!(email: 'admin@jobsflyer.com', password: 'adm*n@f1yer', password_confirmation: 'adm*n@f1yer' )
end

# Create admin profile
user = User.find_by_email('admin@jobsflyer.com')
if user.profile.present?
  puts 'Admin User profile already exist and skip to create admin user profile'
else
  puts 'Creating Admin User Profile....'
  Profile.create!(user_id: user.id, first_name: 'Jobsflyer', last_name: 'Admin', country: "BD")
end
