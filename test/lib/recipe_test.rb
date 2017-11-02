require 'test_helper'

describe Recipe do
  it "must initialize name, id, url, and ingredients properly" do
    recipe = Recipe.new(name: "Name", id: "ID", url: "www.url.com", ingredients: ["sugar", "spinach"])
    recipe.name.must_equal "Name"
    recipe.id.must_equal "ID"
    recipe.url.must_equal "www.url.com"
    recipe.ingredients.must_equal ["sugar", "spinach"]
  end

  it "Cannot be initialized with less than 4 parameters" do
    proc {
      Recipe.new
    }.must_raise ArgumentError

    proc {
      Recipe.new "Name"
    }.must_raise ArgumentError
  end
end
