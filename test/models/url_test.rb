require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  test "admin slug and user slug cannot be the same" do
    invalid_url = FactoryBot.build(:url, admin_slug: 'foobar', user_slug: 'foobar')
    UrlValidator.stubs(:validate).with(invalid_url.long_url).returns(true)
    assert invalid_url.invalid?, "url is incorrectly valid with matching slugs"
  end

  test "user slug cannot already exist in the database" do
    url = Faker::Internet.url
    UrlValidator.stubs(:validate).with(url).returns(true)
    valid_url = FactoryBot.create(:url, long_url: url)
    assert valid_url.valid?
    invalid_url = FactoryBot.build(:url, user_slug: valid_url.user_slug)
    UrlValidator.stubs(:validate).with(invalid_url.long_url).returns(true)
    assert invalid_url.invalid?, "url is incorrectly valid with duplicated user slug"
  end

  test "admin slug cannot already exist in the database" do
    url = Faker::Internet.url
    UrlValidator.stubs(:validate).with(url).returns(true)
    valid_url = FactoryBot.create(:url, long_url: url)
    assert valid_url.valid?
    invalid_url = FactoryBot.build(:url, admin_slug: valid_url.admin_slug)
    UrlValidator.stubs(:validate).with(invalid_url.long_url).returns(true)
    assert invalid_url.invalid?, "url is incorrectly valid with duplicated admin slug"
  end

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
end
