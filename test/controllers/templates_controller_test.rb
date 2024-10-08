require "test_helper"

class TemplatesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get templates_show_url
    assert_response :success
  end
end
