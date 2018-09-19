require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  test "admin slug and user slug cannot be the same" do
    invalid_url = FactoryBot.build(:url, admin_slug: 'foobar', user_slug: 'foobar')
    assert invalid_url.invalid?, "url is incorrectly valid with matching slugs"
  end

  test "user slug cannot already exist in the database" do
    valid_url = FactoryBot.create(:url)
    assert valid_url.valid?
    invalid_url = FactoryBot.build(:url, user_slug: valid_url.user_slug)
    assert invalid_url.invalid?, "url is incorrectly valid with duplicated user slug"
  end

  test "admin slug cannot already exist in the database" do
    valid_url = FactoryBot.create(:url)
    assert valid_url.valid?
    invalid_url = FactoryBot.build(:url, admin_slug: valid_url.admin_slug)
    assert invalid_url.invalid?, "url is incorrectly valid with duplicated admin slug"
  end

  # this test encodes an assumption that we want to allow duplicate long urls
  # so that each person tracking that url has their own count of clicks
  test "long urls do not have to be unique" do
    url = Faker::Internet.url
    FactoryBot.create(:url, long_url: url)
    valid_url = FactoryBot.build(:url, long_url: url)
    assert valid_url.valid?, "url is incorrectly invalid with duplicated long url"
  end
end
