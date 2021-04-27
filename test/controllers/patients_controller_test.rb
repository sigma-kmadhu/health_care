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
    # post patients
    # assert_equal Company.find(1).is_updated, true
  end
end
