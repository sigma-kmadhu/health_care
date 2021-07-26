class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    def after_sign_in_path_for(resource)
        if current_user.role.name == 'User'
            fetch_records_patients_path
        elsif current_user.role.name == 'Admin'
            admins_path
        end
    end
end
