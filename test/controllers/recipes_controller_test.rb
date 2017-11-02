require "test_helper"

describe RecipesController do

  describe "homepage" do

    it "must get home page" do
      get root_path
      must_respond_with :success
    end
  end


end
