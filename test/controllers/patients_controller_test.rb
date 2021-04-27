require "test_helper"

class PatientsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get '/users/sign_in'
    sign_in users(:user_1)
    post user_session_url
  end

  test "should get index" do
    get patients_path
    assert_response :success
  end

  test "should update patient data" do
    patient_data = patients(:one).as_json(except: [:created_at, :updated_at])
    patient_data[:daywise_infos_attributes] = daywise_infos(:one,:two).as_json(except: [:created_at, :updated_at])
    put '/patients/1', xhr: true, params: { company: { patients_attributes: [patient_data] } }
    assert_equal Company.find(1).last_updated_at.to_date, Date.today
  end
end
