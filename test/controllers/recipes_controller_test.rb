require "test_helper"

describe RecipesController do
  describe "#home" do
    it "successfully loads home page" do
      get root_path
      must_respond_with :success
    end
  end

  describe "#index" do

  end

  describe "#show" do

  end
end
