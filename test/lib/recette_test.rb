require 'test_helper'

describe "Recette" do
  it "can be created" do
    my_recette = Recette.new({"label" => "I'm a label", "uri" => "I'm a valid uri"})
    my_recette.wont_be_nil
  end

  it "can't be created without a label and an uri key" do
    proc {
      Recette.new({"source" => "I'm a source"})
    }.must_raise ArgumentError
    proc {
      Recette.new({"label" => ""})
    }.must_raise ArgumentError
    proc {
      Recette.new({"label" => nil})
    }.must_raise ArgumentError
    proc {
      Recette.new({"uri" => ""})
  }.must_raise ArgumentError
  proc {
    Recette.new({"uri" => nil})
  }.must_raise ArgumentError
  proc {
    Recette.new({"uri" => "imuri"})
  }.must_raise ArgumentError
  proc {
    Recette.new({"label" => "imlabel"})
  }.must_raise ArgumentError
    proc {
      Recette.new({})
    }.must_raise ArgumentError
    proc {
      Recette.new
    }.must_raise ArgumentError
  end

  it "has an accessible name and uri" do
    my_recette = Recette.new({"label" => "I'm a label", "uri" => "httpimuri"})
    my_recette.must_respond_to :title
    my_recette.must_respond_to :uri
    my_recette.title.must_equal "I'm a label"
    my_recette.uri.must_equal "httpimuri"
  end

  it "has accessible optional parameters" do
    my_recette = Recette.new({"label" => "I'm a label", "uri" => "httpimuri"})
    my_recette.wont_be_nil

    my_recette.image.must_equal Recette::NO_IMAGE
    my_recette.url.must_be_nil
    my_recette.source.must_be_nil
    my_recette.ingredients.must_equal ["No ingredient found"]
    my_recette.calories.must_equal "No calories info"
    my_recette.nutrients.must_be_kind_of Hash
    my_recette.nutrients.must_be_empty
    my_recette.dailyneed.must_be_kind_of Hash
    my_recette.dailyneed.must_be_empty
    my_recette.diet_labels.must_be_nil
    my_recette.health_labels.must_be_nil
    my_recette.allergies.must_be_nil

    hash = {}
    hash["label"] = "Another label"
    hash["uri"] = "workinguri"
    hash["image"] = "https://www.jqueryscript.net/images/Simplest-Responsive-jQuery-Image-Lightbox-Plugin-simple-lightbox.jpg"
    hash["url"] = "http://www.theuselessweb.com/"
    hash["ingredientLines"] = ["I'm an ingredient", "I'm an ingredient too!"]
    hash["calories"] = "1000000"
    hash["digest"] = {NUTRIENT: {label: "Nutrient's name", quantity: 1, unit: "%"}}
    hash["totalDaily"] = {NUTRIENT: {label: "Nutrient's name", total: 1, unit: "g"}}
    hash["source"] = "I'm a source!"
    hash["dietLabels"] = ["No good"]
    hash["healthLabels"] = ["Bad, bad food."]
    hash["cautions"] = ["many allergizzzz"]
    hash["yield"] = 1

    another_recette = Recette.new(hash)

    another_recette.image.must_equal "https://www.jqueryscript.net/images/Simplest-Responsive-jQuery-Image-Lightbox-Plugin-simple-lightbox.jpg"
    another_recette.url.must_equal "http://www.theuselessweb.com/"
    another_recette.source.must_equal "I'm a source!"
    another_recette.ingredients.must_equal ["I'm an ingredient", "I'm an ingredient too!"]
    another_recette.calories.must_equal "1000000 calories per serving"
    another_recette.nutrients.must_be_kind_of Hash
    another_recette.nutrients.wont_be_empty
    another_recette.dailyneed.must_be_kind_of Hash
    another_recette.dailyneed.wont_be_empty
    another_recette.diet_labels.must_equal ["No good"]
    another_recette.health_labels.must_equal ["Bad, bad food."]
    another_recette.allergies.must_equal ["many allergizzzz"]
  end

end
