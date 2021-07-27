class PatientsController < ApplicationController
  include PatientsHelper
  before_action :set_company

  def index
    @loc_services = construct_loc_services
    @from_date = @@selected_dates.to_date.beginning_of_week
    @to_date = @from_date + 6.days
  end

  def submit_success
  end

  def get_date
    @@selected_dates = params[:selected_date]
    respond_to do |format|
      if @company.last_updated_at.beginning_of_week.to_date == @@selected_dates.to_date
        format.js { render js: "window.location.href = '/patients'"}
      else
        format.js { flash.now[:notice] = I18n.t 'controller.patient.invalid_dates' }
      end
    end
  end

  def update
    respond_to do |format|
      begin 
        ActiveRecord::Base.transaction do 
          if @company.update(company_params)
            submit_value = params[:commit] == "Save For Later" ? false : true
            @company.update(submitted: submit_value)
            submit_value ? @company.update(last_updated_at: DateTime.now) : @company.update(last_saved_at: DateTime.now)
            # create csv with headers
            report = init_patients_report(@@selected_dates)
            # import updated patient details into csv
            construct_report_records(report,@@selected_dates)
            if submit_value
              format.html {redirect_to submit_success_patients_url, notice: "#{I18n.t 'controller.patient.success'}" }
              UserMailer.notify_company(@company, report).deliver
            else
              format.js { flash.now[:notice] = I18n.t 'controller.patient.saved' } unless submit_value
            end
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
    params.require(:company).permit(:submitted, patients_attributes: [
      :id, :name, :insurance_provider, :dob, :therapist, :admit_date, :loc, :company_id, :missing_services,
      daywise_infos_attributes: [:id, :t_date, {status:[]}, :patient_id]
    ])
  end

  # set current company
  def set_company
    @company = Company.includes(patients: [:daywise_infos]).find(current_user.company_id)
  end
end
