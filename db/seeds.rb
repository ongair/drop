# Create an admin user
if Admin.find_by(email: Rails.application.secrets.master_email).nil?
  Admin.create! email: Rails.application.secrets.master_email, name: Rails.application.secrets.master_name, password: Rails.application.secrets.master_password
end

# Create the initial seed categories
Category.find_or_create_by! name: 'Sports'
Category.find_or_create_by! name: 'Politics'
Category.find_or_create_by! name: 'Travel'
Category.find_or_create_by! name: 'Fashion'
Category.find_or_create_by! name: 'Science'
Category.find_or_create_by! name: 'Nature'
Category.find_or_create_by! name: 'Weather'
Category.find_or_create_by! name: 'Entertainment'
Category.find_or_create_by! name: 'Culture'