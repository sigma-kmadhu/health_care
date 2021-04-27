class UserNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    user_list = []
    un_updated_companies = Company.where("last_updated_at < ?", DateTime.now-7.day)
    un_updated_companies.each do |company|
      user_list.push(company.users.pluck(:email))
    end
    UserMailer.notify_users(user_list.flatten).deliver if !user_list.nil?
  end
end
