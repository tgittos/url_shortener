
require 'test_helper'
 
class Base52EncoderTest < ActiveSupport::TestCase
    test "RandomString generate only returns letters" do
        1000.times do
            random_id = rand(10000000)
            encoded = Base52Encoder.encode(random_id)
            assert_equal random_id, Base52Encoder.decode(encoded)
        end
    end
end