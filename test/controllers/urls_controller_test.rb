require 'test_helper'

class UrlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    url = Faker::Internet.url
    UrlValidator.stubs(:validate).with(url).returns(true)
    @url = FactoryBot.create(:url, long_url: url)
  end

  test "should get index" do
    get urls_url
    assert_response :success
  end

  test "should get new" do
    get new_url_url
    assert_response :success
  end

  test "should create url" do
    assert_difference('Url.count') do
      url = Faker::Internet.url
      UrlValidator.stubs(:validate).with(url).returns(true)
      post urls_url, params: { url: { long_url: url } }
    end

    assert_redirected_to url_url(Url.last)
  end

  test "should show url" do
    get url_url(@url)
    assert_response :success
  end

  test "should get edit" do
    get edit_url_url(@url)
    assert_response :success
  end

  test "should update url" do
    patch url_url(@url), params: { url: { active: false } }
    assert_redirected_to url_url(@url)
  end

  test "should destroy url" do
    assert_difference('Url.count', -1) do
      delete url_url(@url)
    end

    assert_redirected_to urls_url
  end

  test 'navigate should redirect to the long url' do
    get "/#{@url.user_slug}"
    assert_redirected_to @url.long_url
  end

  test 'navigate should increment the num_clicks for a url' do
    assert_difference('@url.num_clicks', 1) do
      get "/#{@url.user_slug}"
      @url.reload
    end
  end

  test 'navigate should render a 404 if url never existed' do
    fake_slug = "sadfasdgasdf"
    get "/#{fake_slug}"
    assert_response :missing
  end

  test 'navigate should render a 404 if the url was disabled' do
    url = Faker::Internet.url
    UrlValidator.stubs(:validate).with(url).returns(true)
    disabled_url = FactoryBot.create(:url, long_url: url, active: false)
    get "/#{disabled_url.user_slug}"
    assert_response :missing
  end

  test "navigate shouldnt increment the num_clicks for a disabled url" do
    url = Faker::Internet.url
    UrlValidator.stubs(:validate).with(url).returns(true)
    disabled_url = FactoryBot.create(:url, long_url: url, active: false)
    assert_no_difference('disabled_url.num_clicks') do
      get "/#{disabled_url.user_slug}"
    end
  end
end
