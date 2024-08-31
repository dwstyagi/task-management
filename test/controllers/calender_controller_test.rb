require "test_helper"

class CalenderControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get calender_index_url
    assert_response :success
  end
end
