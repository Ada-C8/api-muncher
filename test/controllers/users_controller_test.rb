require "test_helper"

describe UsersController do
  it "should get create" do
    get users_create_url
    value(response).must_be :success?
  end

  it "should get logout" do
    get users_logout_url
    value(response).must_be :success?
  end

end
