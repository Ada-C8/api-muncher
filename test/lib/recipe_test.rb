require 'test_helper'

describe "Recipe" do
  it "can be instantiated" do
    Recipe.new("name", "id")
  end

  it "Requires a name and an ID" do
    proc {
      Recipe.new()
    }.must_raise ArgumentError

    proc {
      Recipe.new("name")
    }.must_raise ArgumentError

    proc {
      Recipe.new("", "")
    }.must_raise ArgumentError
  end

  it "keeps track of name and ID" do
    name = "name"
    id = "id"
    recipe = Recipe.new(name, id)
    recipe.name.must_equal name
    recipe.id.must_equal id
  end

  it "tracks optionals" do
    
  end
end
