namespace :add_user_role do
  desc "TODO"
  task create_admin_add_user_role: :environment do
    roles = ["Admin", "User"]
    roles.each { |role| Role.create({name:role}) }
    users = User.all
    users.each do |user|
      role = Role.find_by_name("User")
      user.update(role_id: role.id)
    end
    admin_role = Role.find_by_name("Admin")
    User.create({email: "admin@gmail.com", password: "password", password_confirmation: "password", role_id: admin_role.id})
  end
end
