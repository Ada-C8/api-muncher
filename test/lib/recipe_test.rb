require 'test_helper'

describe Recipe do

  it "Can be instantiated with required fields" do
    Recipe.new("name", "image", "source", "url", "ingredients")
  end

  it "Requires a name, image, source, url, and ingredients" do
    proc {
      Recipe.new()
    }.must_raise ArgumentError

    proc {
      Recipe.new("name")
    }.must_raise ArgumentError

    # Empty strings are not permitted either
    proc {
      Recipe.new("", "")
    }.must_raise ArgumentError
  end

  it "Tracks name, image, source, url, and ingredients" do
    name = "test_name"
    image = "test_image"
    source = "test_source"
    url = "test_url"
    ingredients = "test_ingredients"

    recipe = Recipe.new(name, image, source, url, ingredients)

    recipe.name.must_equal name
    recipe.image.must_equal image
    recipe.source.must_equal source
    recipe.url.must_equal url
    recipe.ingredients.must_equal ingredients
  end

  # it "Tracks optional args" do
  #   options = {
  #     purpose: "test_purpose",
  #     is_archived: "test_archived",
  #     is_general: "test_general",
  #     members: "test_members"
  #   }
  #   chan = Recipe.new("name", "id", options)
  #
  #   chan.purpose.must_equal options[:purpose]
  #   chan.is_archived.must_equal options[:is_archived]
  #   chan.is_general.must_equal options[:is_general]
  #   chan.members.must_equal options[:members]
  # end


end
