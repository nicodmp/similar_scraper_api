require "test_helper"

class SimilarScraperControllerTest < ActionDispatch::IntegrationTest
  test "should get save_info" do
    get similar_scraper_save_info_url
    assert_response :success
  end

  test "should get get_info" do
    get similar_scraper_get_info_url
    assert_response :success
  end
end
