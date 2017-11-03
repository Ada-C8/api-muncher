require "test_helper"

describe Recipe do
  before do
    data = {
      "uri": "http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2",
      "label": "Teriyaki Chicken",
      "image_url": "https://www.edamam.com/web-img/262/262b4353ca25074178ead2a07cdf7dc1.jpg",
      "source": "David Lebovitz",
      "source_url": "http://www.davidlebovitz.com/2012/12/chicken-teriyaki-recipe-japanese-farm-food/",
      "ingredient_lines":
        ["1/2 cup (125ml) mirin",
          "1/2 cup (125ml) soy sauce",
          "One 2-inch (5cm) piece of fresh ginger, peeled and grated",
          "2-pounds (900g) boneless chicken thighs (4-8 thighs, depending on size)"],
      "totalNutrients": {
        "ENERC_KCAL": {
            "label": "Energy",
            "quantity": 948.5783323955536,
            "unit": "kcal"
        },
        "FAT": {
            "label": "Fat",
            "quantity": 66.042283310318,
            "unit": "g"
        }
      }
    }

    @recipe = Recipe.new(
      data[:uri],
      data[:label],
      data[:source],
      options = {
        image_url: data[:image_url],
        source_url: data[:source_url],
        ingredient_lines: data[:ingredient_lines],
        total_nutrients: data[:total_nutrients]
      }
    )
  end

  describe "#initialize" do
    it "can be instantiated with all instances" do
      @recipe.must_be_kind_of Recipe
      @recipe.label.must_equal "Teriyaki Chicken"
      @recipe.uri.must_equal "http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2"
      @recipe.source.must_equal "David Lebovitz"
    end

    it "requires all required parameters" do
      proc {
        Recipe.new()
      }.must_raise ArgumentError

      proc {
        Recipe.new("uri", "label")
      }.must_raise ArgumentError

      proc {
        Recipe.new("", "", "")
      }.must_raise ArgumentError
    end
  end

  describe "#uri_id" do
    it "must return the id of a uri" do
      @recipe.uri_id.must_equal "7bf4a371c6884d809682a72808da7dc2"
    end
  end

end
