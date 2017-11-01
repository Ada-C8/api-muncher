require 'test_helper'

describe "Recipe" do
  before do
    @test_recipe = Recipe.new("label", "url", "uri", "image", [{"text" => "some ingredients", "weight" => 23}])
  end

  describe "initialize" do
    it "should be instantiated with a label, url, uri, image and ingredients" do
      @test_recipe
    end

    it "should require a label, url, uri, image and ingredients " do
      proc { Recipe.new() }.must_raise ArgumentError
      proc { Recipe.new("label") }.must_raise ArgumentError
      proc { Recipe.new("label", "url")}.must_raise ArgumentError
      proc { Recipe.new("label", "url", "uri")}.must_raise ArgumentError
      proc { Recipe.new("label", "url", "uri", "image", [])}.must_raise ArgumentError
      proc { Recipe.new("", "", "", "", [])}.must_raise ArgumentError
    end

    it "should track label, url, uri, image" do
      label = "test_label"
      url = "www.testurl.com"
      uri = "www.testuri.com"
      image = "www.testimage.jpg"
      ingredients = [{"text" => "some ingredients", "weight" => 23}]

      recipe = Recipe.new(label, url, uri, image, ingredients)

      recipe.label.must_equal label
      recipe.url.must_equal url
      recipe.uri.must_equal uri
      recipe.image.must_equal image

      #does track ingredients - I think this is the right decision?
    end
  end

  describe "ingredients_text" do
    it "should be able to be called" do
      @test_recipe.must_respond_to :ingredients_text
    end

    it "should return an Array" do
      @test_recipe.ingredients_text.must_be_instance_of Array
    end

    it "should only return the values for the 'text' key" do
      @test_recipe.ingredients_text[0].must_equal "some ingredients"
    end
  end

  describe "uri_id" do
    it "text" do

    end
  end

end
