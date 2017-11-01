require "test_helper"

describe Recipe do
  before do
    @data = {
      "uri": "http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2",
      "label": "Teriyaki Chicken",
      "image_url": "https://www.edamam.com/web-img/262/262b4353ca25074178ead2a07cdf7dc1.jpg",
      "source": "David Lebovitz",
      "source_url": "http://www.davidlebovitz.com/2012/12/chicken-teriyaki-recipe-japanese-farm-food/",
      "ingredient_lines":
        ["1/2 cup (125ml) mirin",
          "1/2 cup (125ml) soy sauce",
          "One 2-inch (5cm) piece of fresh ginger, peeled and grated",
          "2-pounds (900g) boneless chicken thighs (4-8 thighs, depending on size)"]
    }

    @recipe = Recipe.new(@data[:uri], @data[:label], @data[:image_url], @data[:source], @data[:source_url], @data[:ingredient_lines])
  end

  describe "#initialize" do
    it "can be instantiated with all instances" do
      @recipe.must_be_kind_of Recipe
      @recipe.label.must_equal "Teriyaki Chicken"
    end

    it "requires all parameters" do
      proc {
        Recipe.new()
      }.must_raise ArgumentError

      proc {
        Recipe.new("uri", "label")
      }.must_raise ArgumentError

      proc {
        Recipe.new("", "")
      }.must_raise ArgumentError
    end
  end

  describe "#uri_id" do
    it "must return the id of a uri" do
      @recipe.uri_id.must_equal "7bf4a371c6884d809682a72808da7dc2"
    end
  end

end
