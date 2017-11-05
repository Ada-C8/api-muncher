require 'test_helper'

describe RecipesController do
  describe "index" do
    it "must respond with success" do
      get root_path
      must_respond_with :success
    end
  end
end
