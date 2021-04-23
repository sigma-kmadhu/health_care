class PatientsController < ApplicationController
  before_action :set_company
  def index
    @patinet_status_dd = PatientStatusDd.all.pluck(:name)
  end

  def update
    respond_to do |format|
      if @company.update(company_params)
        @company.patients.update_all(is_updated: true)
        format.js { flash.now[:notice] = I18n.t 'controller.patient.success' }
      else
        format.js { flash.now[:error] = I18n.t 'controller.patient.all_fields' }
      end
    end  
  end

  private

  def company_params
    params.require(:company).permit(patients_attributes: [
      :id, :name, :insurance_provider, :dob, :therapist, :admit_date, :loc, :company_id, :missing_services,
      daywise_infos_attributes: [:id, :t_date, :status, :patient_id]
    ])
  end

  def set_company
    @company = Company.includes(patients: [:daywise_infos]).find(current_user.company_id)
  end
end
