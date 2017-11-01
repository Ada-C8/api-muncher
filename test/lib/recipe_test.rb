require 'test_helper'

describe Recipe do

  before do
    @uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2"
    @label = "Teriyaki Chicken"
    @url = "http://www.davidlebovitz.com/2012/12/chicken-teriyaki-recipe-japanese-farm-food/"
    @dietLabels = ["Low-Carb"]
    @ingredientLines = [
        "1/2 cup (125ml) mirin",
        "1/2 cup (125ml) soy sauce",
        "One 2-inch (5cm) piece of fresh ginger, peeled and grated",
        "2-pounds (900g) boneless chicken thighs (4-8 thighs, depending on size)"]

    @image = "https://www.edamam.com/web-img/262/262b4353ca25074178ead2a07cdf7dc1.jpg"
    @source = "David Lebovitz"
  end

  it "Must initialize with 5 required parameters (uri, label, url, ingredientLines, dietLabels) and optional variables (image, source)" do
    recipe = Recipe.new(@uri, @label, @url, @ingredientLines, @dietLabels, options = {image: @image, source: @source})

    recipe.id.must_equal @uri
    recipe.label.must_equal @label
    recipe.url.must_equal @url
    recipe.ingredientLines.must_equal @ingredientLines
    recipe.dietLabels.must_equal @dietLabels

    recipe.image.must_equal @image
    recipe.source.must_equal @source
  end

  it "Cannot be initialized without 5 required parameters" do
    proc {
      Recipe.new()
    }.must_raise ArgumentError

    proc {
      Recipe.new(@uri, @label)
    }.must_raise ArgumentError
  end

end
