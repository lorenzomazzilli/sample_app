namespace :db do
	desc "Populate database with sample data"
	task populate: :environment do
		make_users
		make_microposts
		make_sites
		make_relationships
    end
end

def make_users
		admin = User.create!(name: "Example User",
					email: "example@railstutorial.org",
					password: "foobar",
					password_confirmation: "foobar")
		admin.toggle!(:admin)
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password  = "password"
			User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)	
		end
end

def make_microposts
	users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
end

def make_sites
	users = User.all(limit: 6)
    3.times do |n|
      name = "site-#{n+1}"
	  description = Faker::Lorem.sentence(5)
	  hostname = "www.site-#{n+1}.com"
	  layout = "standard"
      users.each { |user| user.sites.create!(name: name, description: description, hostname: hostname, layout: layout) }
    end
end

def make_relationships
	users = User.all
	user = users.first
	followed_users 	= users[2..50]
	followers		= users[3..40]
	followed_users.each {|followed| user.follow!(followed)}
	followers.each {|follower| follower.follow!(user)}
end