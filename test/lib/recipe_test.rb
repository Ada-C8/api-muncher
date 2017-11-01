require 'test_helper'

describe Recipe do
  let(:recipe_name) { "chicken recipe" }
  let(:uri) { "http://www.edamam.com/ontologies/edamam.owl%23recipe_7bf4a371c6884d809682a72808da7dc2" }
  let(:image) { "https://www.edamam.com/web-img/262/262b4353ca25074178ead2a07cdf7dc1.jpg" }
  let(:orig_url) { "http://www.davidlebovitz.com/2012/12/chicken-teriyaki-recipe-japanese-farm-food/" }

  it "can be created" do
    recipe = Recipe.new recipe_name, uri, image, orig_url

    recipe.wont_be_nil
    recipe.name.must_equal recipe_name
    recipe.uri.must_equal uri
    recipe.image.must_equal image
    recipe.orig_url.must_equal orig_url
  end

  it "requires 4 params" do
    proc {
      Recipe.new
    }.must_raise ArgumentError

    proc {
      Recipe.new recipe_name
    }.must_raise ArgumentError

    proc {
      Recipe.new recipe_name, uri
    }.must_raise ArgumentError

    proc {
      Recipe.new recipe_name, uri, image
    }.must_raise ArgumentError

    proc {
      Recipe.new "", "", "", ""
    }.must_raise ArgumentError

  end

end
