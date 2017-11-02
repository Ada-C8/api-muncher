require 'test_helper'

describe Recipe do
  describe "initialize" do
    it "can be instantiated with a uri, url, and label" do
      recipe = Recipe.new("uri", "url", "label")
      recipe.must_be_kind_of Recipe
    end

    it "Requires a uri, url, and label" do
          proc {
            Recipe.new()
          }.must_raise ArgumentError

          proc {
            Recipe.new("uri")
          }.must_raise ArgumentError

          proc {
            Recipe.new("uri", "url")
          }.must_raise ArgumentError

          # Empty strings are not permitted either
          proc {
            Recipe.new("", "", "")
          }.must_raise ArgumentError
    end

      it "Tracks uri, url, and label" do
        uri = "test_uri"
        url = "test_url"
        label = "test_label"
        recipe = Recipe.new(uri, url, label)
        recipe.uri.must_equal uri
        recipe.url.must_equal url
        recipe.label.must_equal label
      end

      it "Tracks optional args" do
        options = {
          ingredients: ["test_ingredients"],
          source: "test_source",
          dietLabels: "test_diet_labels",
          image: "test_image"
        }

        recipe = Recipe.new("uri", "url", "label", options)

        recipe.ingredients.must_equal options[:ingredients]
        recipe.source.must_equal options[:source]
        recipe.diet_labels.must_equal options[:dietLabels]
        recipe.image.must_equal options[:image]
      end
  end

end
