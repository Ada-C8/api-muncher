require 'test_helper'

describe "Recipe" do
  before do
    @label = "test_label"
    @uri = "www.testuri_asdf1234"

    @options = {
      health_labels: "health health health",
      url: "www.testurl.com",
      image: "www.testimage.jpg",
      source: "anders",
      ingredients: [{"text" => "some ingredients", "weight" => 23}]
    }

    @test_recipe = Recipe.new(@label, @uri, @options)
  end

  describe "initialize" do
    it "should be instantiated with a label, url, uri, image and ingredients" do
      @test_recipe
    end

    it "should require a label and uri " do
      proc { Recipe.new() }.must_raise ArgumentError
      proc { Recipe.new(@label) }.must_raise ArgumentError
    end

    it "should track label and uri" do
      @test_recipe.label.must_equal @label
      @test_recipe.uri.must_equal @uri
    end

    it "should track optional arguments" do
      @test_recipe.url.must_equal @options[:url]
      @test_recipe.health_labels.must_equal @options[:health_labels]
      @test_recipe.image.must_equal @options[:image]
      @test_recipe.source.must_equal @options[:source]
      # @test_recipe.ingredients.must_equal @options[:ingredients]
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
