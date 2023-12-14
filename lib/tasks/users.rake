namespace :users do
  task :make_admin, [:email] => :environment do |_, args|
    email = args[:email]

    user = User.where(email: email).first_or_create do |u|
      u.password = SecureRandom.hex(16)
      u.password_confirmation = u.password
      puts "Didn't find a user with email #{email}, so created one with password #{u.password}"
    end
    if user.update(admin: true)
      puts "Grandfathered user #{user.email} into admin role"
    else
      puts "Failed to grandfather user #{user.email} into admin role"
    end
  end
end
