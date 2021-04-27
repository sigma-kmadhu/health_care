class UserMailer < ApplicationMailer
    def notify_users(user_list)
        mail(to: user_list.join(','), subject: 'Reminder: Update Patient Report')
    end
end
