class PatientsController < ApplicationController
  include PatientsHelper
  before_action :set_company

  def index
    @loc_services = construct_loc_services
  end

  def update
    respond_to do |format|
      begin 
        ActiveRecord::Base.transaction do 
          if @company.update(company_params)
            @company.update(last_updated_at: DateTime.now)
            # create csv with headers
            report = init_patients_report
            # import updated patient details into csv
            construct_report_records(report)
            UserMailer.notify_company(@company, report).deliver
            format.js { flash.now[:notice] = I18n.t 'controller.patient.success' }
          else
            format.js { flash.now[:error] = I18n.t 'controller.patient.all_fields' }
          end
        end
      rescue ActiveRecord::ActiveRecordError => error
        format.js { flash.now[:error] = I18n.t 'transaction.error' } 
      end
    end
  end

  private

  # company params with nested attribtes
  def company_params
    params.require(:company).permit(patients_attributes: [
      :id, :name, :insurance_provider, :dob, :therapist, :admit_date, :loc, :company_id, :missing_services,
      daywise_infos_attributes: [:id, :t_date, {status:[]}, :patient_id]
    ])
  end

  # set current company
  def set_company
    @company = Company.includes(patients: [:daywise_infos]).find(current_user.company_id)
  end
end
