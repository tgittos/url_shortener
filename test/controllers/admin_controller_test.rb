require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  setup do
    url = Faker::Internet.url
    UrlValidator.stubs(:validate).with(url).returns(true)
    @url = FactoryBot.create(:url, long_url: url)
  end

  test "should show url" do
    get "#{root_url}a/#{@url.admin_slug}"
    assert_response :success
  end

  test "should update url" do
    patch "#{root_url}a/#{@url.admin_slug}", params: { url: { active: false } }
    assert_response :success
  end
end
