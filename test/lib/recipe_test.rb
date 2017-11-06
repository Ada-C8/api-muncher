require 'test_helper'

describe Recipe do
  before do
    @recipe = Recipe.new("uri", "label", "image", "source", "url")
  end

  it "can create a new recipe instance" do
    @recipe.must_be_instance_of Recipe

    [:uri, :label, :image, :source, :url].each do |name|
      @recipe.must_respond_to name
    end

    ["uri", "label", "image", "source", "url"].each do |name|
      @recipe.instance_variable_get("@#{name}").must_equal name
    end
  end

  it "must have all the required parameters" do
    proc{Recipe.new}.must_raise ArgumentError
    proc{Recipe.new "only one"}.must_raise ArgumentError
  end
end
