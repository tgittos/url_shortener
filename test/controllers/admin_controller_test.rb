require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  setup do
    url = Faker::Internet.url
    UrlValidator.stubs(:validate).with(url).returns(true)
    @url = FactoryBot.create(:url, long_url: url)
  end

  test "should show url" do
    get url_url(@url)
    assert_response :success
  end

  test "should update url" do
    patch url_url(@url), params: { url: { active: false } }
    assert_redirected_to url_url(@url)
  end
end
