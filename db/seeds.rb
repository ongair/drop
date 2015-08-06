# Create an admin user
if Admin.find_by(email: Rails.application.secrets.master_email).nil?
  Admin.create! email: Rails.application.secrets.master_email, name: Rails.application.secrets.master_name, password: Rails.application.secrets.master_password
end

# Default enabled sources
# ["BBC News", "Kenya Broadcasting Corporation", "Africa Review", "Business Daily Africa", "The Star (Kenya)", "This is Africa"]

# Create the initial seed categories - to be refined by machine learning and further seeding
Category.find_or_create_by! name: 'Sports', keywords: 'Premier League, Football'
Category.find_or_create_by! name: 'Politics', keywords: 'Politics, Current Affairs'
Category.find_or_create_by! name: 'Travel', keywords: 'Travel, Holiday'
Category.find_or_create_by! name: 'Fashion', keywords: 'Fashion, Runway'
Category.find_or_create_by! name: 'Science', keywords: 'Tech, Science, STEM, Web, Android, iOs', metadata: 'Tech Moran, The Daily Telegraph, The Sun, The Australian, Mail and Guardian'
Category.find_or_create_by! name: 'Nature', keywords: 'Nature'
Category.find_or_create_by! name: 'Weather', keywords: 'Climate, Weather'
Category.find_or_create_by! name: 'Entertainment', keywords: 'Gossip, Entertainment, Celebrity'
Category.find_or_create_by! name: 'Culture', keywords: 'Culture, Music, Artists'