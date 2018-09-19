require 'test_helper'
 
class RandomStringTest < ActiveSupport::TestCase
    test "RandomString generate only returns letters" do
        1000.times do
            assert_match /[A-Za-z]/, RandomString.generate
        end
    end
end