require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  # this test encodes an assumption that we want to allow duplicate long urls
  # so that each person tracking that url has their own count of clicks
  test "long urls do not have to be unique" do
    url = Faker::Internet.url
    UrlValidator.stubs(:validate).with(url).returns(true)
    FactoryBot.create(:url, long_url: url)
    valid_url = FactoryBot.build(:url, long_url: url)
    UrlValidator.stubs(:validate).with(valid_url.long_url).returns(true)
    assert valid_url.valid?, "url is incorrectly invalid with duplicated long url"
  end

  test "long url has to pass validity test" do
    valid_long_url = Faker::Internet.url
    invalid_long_url = Faker::Internet.url
    UrlValidator.expects(:validate).with(valid_long_url).returns(true)
    UrlValidator.expects(:validate).with(invalid_long_url).returns(false)
    valid_url = FactoryBot.build(:url, long_url: valid_long_url)
    invalid_url = FactoryBot.build(:url, long_url: invalid_long_url)
    assert valid_url.valid?, "url is incorrectly invalid with valid long url"
    assert invalid_url.invalid?, "url is incorrectly valid with invalid long url"
  end

  test 'unsaved url has a nil slug' do
    url = FactoryBot.build(:url)
    assert_nil url.slug
  end

  test 'saved url has a not-nil slug' do
    valid_long_url = Faker::Internet.url
    UrlValidator.stubs(:validate).with(valid_long_url).returns(true)
    url = FactoryBot.create(:url, long_url: valid_long_url)
    assert_not_nil url.slug
  end

  test 'can find a url by the slug' do
    valid_long_url = Faker::Internet.url
    UrlValidator.stubs(:validate).with(valid_long_url).returns(true)
    url = FactoryBot.create(:url, long_url: valid_long_url)
    assert_equal url, Url.find_by_slug(url.slug)
  end

  test 'unsaved url has nil admin slug' do
    url = FactoryBot.build(:url)
    assert_nil url.admin_slug
  end

  test 'saved url has a not-nil admin slug' do
    valid_long_url = Faker::Internet.url
    UrlValidator.stubs(:validate).with(valid_long_url).returns(true)
    url = FactoryBot.create(:url, long_url: valid_long_url)
    assert_not_nil url.admin_slug
  end
end
