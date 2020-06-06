unless User.exists?(email: "admin@ticketmaster.com")
  User.create!(email: "admin@ticketmaster.com", password: "password", admin: true)
end

unless User.exists?(email: "viewer@ticketmaster.com")
  User.create!(email: "viewer@ticketmaster.com", password: "password")
end

["Sublime Text 3", "Internet Explorer"].each do |name|
  unless Project.exists?(name: name)
    Project.create!(name: name, description: "A sample project about #{name}")
  end
end