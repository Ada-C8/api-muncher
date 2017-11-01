require "test_helper"

describe User do
  let(:user) { User.new }

  it "can be created" do
    user =User.new(name:'averi',uid:'12312312', provider: 'google_oauth2')
    user.valid?.must_equal true

  end

  it "must have 3 parameters" do
    user =User.new(name:'averi',uid:'12312312')
    user.valid?.must_equal false
    user =User.new(uid:'12312312', provider: 'google_oauth2')
    user.valid?.must_equal false

    user =User.new(name:'averi', provider: 'google_oauth2')
    user.valid?.must_equal false

    user =User.new
    user.valid?.must_equal false
  end
end
