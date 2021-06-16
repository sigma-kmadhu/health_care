class UserMailer < ApplicationMailer
    def notify_users(user_list)
        mail(to: user_list.join(','), subject: 'Reminder: Update Patient Report')
    end

    # notify user after the data is submitted
    def notify_company(user, company, report)
        @user = user
        attachments["#{company.name}_Updated_Patients_Report.csv"] = File.read(report.path) unless report.blank?
        mail(to: user.email, subject: 'Updated Patients Details')
    end
end
