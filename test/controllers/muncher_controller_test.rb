require "test_helper"

describe MuncherController do
  describe "root" do
    it "will return success" do
      get root_path
      must_respond_with :success
    end # success
  end # root


  describe "index" do
    it "will return success when there are recipies to display" do
      get muncher_path
      must_respond_with :success
    end # sucess when there are recipies

    it "will return sucess when there are no recipies" do
      # QUESTION: how do I delete all instances of the Recipe class?
    end # sucess with no recipies
  end # index
end # MuncherController
