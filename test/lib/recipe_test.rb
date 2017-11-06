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
        ingredients: [{"text" => ["test_ingredient1"]}, {"text" => ["test_ingredient2" ]}],
        source: "test_source",
        dietLabels: "test_diet_labels",
        image: "test_image",
        healthLabels: "health_labels"
      }

      recipe = Recipe.new("uri", "url", "label", options)

      recipe.ingredients.must_equal [["test_ingredient1"], ["test_ingredient2"]]
      recipe.source.must_equal options[:source]
      recipe.diet_labels.must_equal options[:dietLabels]
      recipe.image.must_equal options[:image]
      recipe.health_labels.must_equal options[:healthLabels]

    end
  end

  describe "ingredients" do
    it "returns an array of ingredient text" do
      options = {
        ingredients: [{"text" => ["sample_ingredient_text_1"]}, {"text" => ["sample_ingredient_text_2"]}]
      }
      recipe = Recipe.new("uri", "url", "label", options)
      recipe.ingredients.must_equal [["sample_ingredient_text_1"], ["sample_ingredient_text_2"]]
    end
  end

  describe "id" do
    it "returns the unique portion of the uri that identifies an individual recipe" do
      uri = "http://www.edamam.com/ontologies/edamam.owl%23recipe_637913ec61d9da69eb451818c3293df2"

      recipe = Recipe.new(uri, "url", "label")
      recipe.id.must_equal "637913ec61d9da69eb451818c3293df2"
    end
  end
end
