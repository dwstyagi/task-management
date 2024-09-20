require "test_helper"

class OrganisationUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get organisation_users_index_url
    assert_response :success
  end
end
