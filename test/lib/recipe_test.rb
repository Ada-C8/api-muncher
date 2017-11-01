require 'test_helper'

describe "Recipe" do
  before do
    @label = "test_label"
    @url = "www.testurl.com"
    @uri = "www.testuri_asdf1234"
    @image = "www.testimage.jpg"
    @source = "anders"
    @ingredients = [{"text" => "some ingredients", "weight" => 23}]

    @options = {
      health_labels: "health health health",
    }

    @test_recipe = Recipe.new(@label, @url, @uri, @image, @source, @ingredients, @options)
  end

  describe "initialize" do
    it "should be instantiated with a label, url, uri, image and ingredients" do
      @test_recipe
    end

    it "should require a label, url, uri, image and ingredients " do
      proc { Recipe.new() }.must_raise ArgumentError
      proc { Recipe.new(@label) }.must_raise ArgumentError
      proc { Recipe.new(@label, @url)}.must_raise ArgumentError
      proc { Recipe.new(@label, @url, @url)}.must_raise ArgumentError
      proc { Recipe.new(@label, @url, @uri, @image, @source, [])}.must_raise ArgumentError
      proc { Recipe.new("", "", "", "", [])}.must_raise ArgumentError
    end

    it "should track label, url, uri, image" do
      @test_recipe.label.must_equal @label
      @test_recipe.url.must_equal @url
      @test_recipe.uri.must_equal @uri
      @test_recipe.image.must_equal @image
      @test_recipe.source.must_equal @source
      #does not track ingredients - I think this is the right decision?
    end

    it "should track optional arguments" do
      @test_recipe.health_labels.must_equal @options[:health_label]
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
    it "should be able to be called" do
      @test_recipe.must_respond_to :uri_id
    end

    it "should return a String" do
      @test_recipe.uri_id.must_be_instance_of String
    end

    it "should return all the characters following the '_'" do
      @test_recipe.uri_id.must_equal "asdf1234"
    end
  end

end
