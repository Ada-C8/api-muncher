require 'test_helper'

describe Recipe do
  describe 'create recipe' do
    it "can create a recipe" do
      recipe = Recipe.new( "http://www.edamam.com/ontologies/edamam.owl#recipe_1b64abcd98711785fe3fdbff2ec67554", "Frozen Chocolate Bananas")

      recipe.must_be_instance_of Recipe
      recipe.name.must_equal "Frozen Chocolate Bananas"
      recipe.uri.must_equal URI.encode("http://www.edamam.com/ontologies/edamam.owl#recipe_1b64abcd98711785fe3fdbff2ec67554")
    end

    it "must have a uri and a name" do
      proc {
        Recipe.new
      }.must_raise ArgumentError
      proc {
        Recipe.new ("uri")
      }.must_raise ArgumentError
    end

    it "can accept optional parametrs" do
      recipe = Recipe.new( "uri", "name", image: "http://www.doggy.jpg", ingredients: "Several ingredients", url: "url", calories: "234", totalNutrients: "many many nutrients")

      recipe.must_be_instance_of Recipe
      recipe.name.must_equal "name"

    end
  end

  describe "attr_readers" do
    before do
      @recipe = Recipe.new(
       "http://www.edamam.com/ontologies/edamam.owl#recipe_1b64abcd98711785fe3fdbff2ec67554",
       "Frozen Chocolate Bananas",
      image: "https://www.edamam.com/web-img/ff0/ff0a00fadecac25559cce2cadedc9221.jpg",
      ingredients: "2 pounds dark chocolate, chopped",
      url: "http://www.marthastewart.com/347052/chocolate-clutch",
      calories: "4354.48681640625",
      totalNutrients: {
            ENERC_KCAL: {
                "label": "Energy",
                "quantity": 4354.48681640625,
                "unit": "kcal"
            },
            FAT: {
                "label": "Fat",
                "quantity": 272.1554260253906,
                "unit": "g"
            }
          })
    end
    it "can read a uri" do
      @recipe.uri.must_equal URI.encode("http://www.edamam.com/ontologies/edamam.owl#recipe_1b64abcd98711785fe3fdbff2ec67554")
    end

    it "can read a name" do
      @recipe.name.must_equal "Frozen Chocolate Bananas"
    end

    it "can read an image url" do
      @recipe.image.must_equal "https://www.edamam.com/web-img/ff0/ff0a00fadecac25559cce2cadedc9221.jpg"
    end

    it "can read the ingredients" do
      @recipe.ingredients.must_equal "2 pounds dark chocolate, chopped"
    end


    it "can read the calories" do
      @recipe.calories.must_equal "4354.48681640625"
    end

    it "can read the totalNutrients" do
      @recipe.totalNutrients.must_be_instance_of Hash
    end
  end
end
