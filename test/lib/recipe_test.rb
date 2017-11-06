require 'test_helper'


describe Recipe do
  it "Cannot be initialized without label or id" do
    proc {
      Recipe.new
    }.must_raise ArgumentError

    proc {
      Recipe.new ("label")
    }.must_raise ArgumentError
  end

  it "Can be initialize with all the fields" do
   recipe = Recipe.new("id", "label", "image", "url", "ingridientLines", "dietLabels")
   recipe.must_be_kind_of Recipe
  end

  it "Tracks arguments" do
    recipe = Recipe.new("id", "label", "image", "url", "ingridientLines", "dietLabels")
    recipe.id.must_equal "id"
    recipe.label.must_equal "label"
  end


#TODO what fields needs to be optional

end
