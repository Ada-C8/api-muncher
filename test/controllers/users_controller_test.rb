require "test_helper"

describe UsersController do
  describe "log in" do
    it "should create new if not in database" do
      new_user = User.new(provider: "google_oauth2", uid: "33321452032", name: "chris")

      proc {
        login(new_user, "google_oauth2")
      }.must_change "User.count", 1

      must_redirect_to root_path
      session[:user_id].must_equal User.last.id

    end

    it "should find existing user" do
      proc {
        login(users(:averi), "google_oauth2")
      }.wont_change "User.count"
      must_redirect_to root_path
      session[:user_id].must_equal users(:averi).id
    end

    it "shouldn't log in if bogus" do
      start_count = User.count
      new_user = User.new( name: "dot", email: "dot@user.com")

      login(new_user, :google_oauth2)

      must_redirect_to root_path
      User.count.must_equal start_count
      session[:user_id].must_be_nil
    end

    it "should get logout" do
      login(users(:averi),:google_oauth2)
      get logout_path
      session[:user_id].must_be_nil
      must_respond_with :redirect
    end
  end

  describe "show page" do
    it "should get show as logged in" do
      login(users(:averi),:google_oauth2)

      get user_path(users(:averi))
      must_respond_with :success
    end

    it "guests can not access" do
      get user_path(users(:averi).id)
      must_respond_with :bad_request
    end

    it "other users can't see page " do
      login(users(:averi),:google_oauth2)
      get user_path(users(:kayla).id)
      must_respond_with :bad_request
    end
  end

end
