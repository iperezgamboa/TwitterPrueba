require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get create_api_tweet" do
    get api_create_api_tweet_url
    assert_response :success
  end

end
