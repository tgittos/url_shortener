require 'test_helper'

# this test suite requires an internet connection to pass!
class UrlValidatorTest < ActiveSupport::TestCase
    test 'validate returns false when url can\'t be resolved' do
        # Faker can sometimes come up with a valid url!
        # note - if this test starts failing, change the URL to a new fake one
        fake_url = 'http://asdflkasdflaskdfjasdlfkj.io'
        assert !UrlValidator.validate(fake_url)
    end

    test 'validate returns true when url can be resolved' do
        real_url = 'http://www.google.com'
        assert UrlValidator.validate(real_url)
    end

    test 'handles urls without http correctly' do
        real_url = 'google.com'
        assert UrlValidator.validate(real_url)
    end
end