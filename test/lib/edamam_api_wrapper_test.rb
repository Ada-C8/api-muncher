require 'test_helper'

describe EdamamApiWrapper do

  describe "self.create_recipe" do
    let(:recipe_info) {
      {
        "label" => "Recipe Name",
        "uri" => "http://www.edamam.com/ontologies/edamam.owl%23recipe_6289468ceb188ec8103d4a0c4adab6b8",
        "image" => "https://www.edamam.com/web-img/676/676a9be0cb7bc68b41ccc0ca765969ed.jpg",
        "url" => "http://leitesculinaria.com/97461/recipes-oven-roasted-chicken-thighs.html"
      }
    }

    it "can create a recipe given a hash" do
      recipe = EdamamApiWrapper.create_recipe(recipe_info)
      recipe.must_be_instance_of Recipe
      recipe.name.must_equal recipe_info["label"]
    end
  end


  describe "self.num_recipes" do
    it "Returns the total number of recipes matching given search term" do
      chicken = { name: "chicken", num: 88393 }
      portabella = { name: "portabella mushrooms", num: 673 }

      VCR.use_cassette("num_recipes") do
        num_recipes = EdamamApiWrapper.num_recipes(chicken[:name])
        num_recipes.must_equal chicken[:num]
      end

      VCR.use_cassette("num_recipes") do
        num_recipes = EdamamApiWrapper.num_recipes(portabella[:name])
        num_recipes.must_equal portabella[:num]
      end
    end

    it "Returns 0 if search term is gibberish or blank" do
      bad_queries = [nil, "", "   ", "lkj"]

      VCR.use_cassette("num_recipes") do
        bad_queries.each do |query|
          num_recipes = EdamamApiWrapper.num_recipes(query)
          num_recipes.must_equal 0, "#{query} should return 0 results"
        end
      end
    end

    it "Returns nil for broken request" do
      VCR.use_cassette("num_recipes") do
        bad_auth = EdamamApiWrapper.num_recipes("pot roast", id: "bogus", key: "bogus")
        bad_auth.must_be_nil
      end
    end

  end

  describe "list_recipes" do

  it "Can return a list of recipes in groups of 10" do
    VCR.use_cassette("list_recipes") do
      recipes = EdamamApiWrapper.list_recipes("chicken")

      recipes.must_be_instance_of Array
      recipes.length.must_equal 10

      recipes.each do |recipe|
        recipe.must_be_instance_of Recipe
      end
    end
  end

  it "Can return a specific number of recipes" do
    VCR.use_cassette("list_recipes") do
      recipes = EdamamApiWrapper.list_recipes("chicken", from: 10, to: 12)

      recipes.length.must_equal 2
    end
  end

  it "Returns [] if request is broken" do
    VCR.use_cassette("list_recipes") do
      bad_request = EdamamApiWrapper.list_recipes("broccoli", id: "bogus", key: "bad")
      bad_request.must_equal []
    end
  end

  end

  # will be private method; temp testing to ensure validity
  describe "validate_req_range" do
    it "returns from and to unchanged if from and to are valid (ints, to > from)" do
      range = EdamamApiWrapper.validate_req_range(10, 20)
      range[:from].must_equal 10
      range[:to].must_equal 20
    end

    it "changes from to 0 if from < 0" do
      range = EdamamApiWrapper.validate_req_range(-2, 20)
      range[:from].must_equal 0
      range[:to].must_equal 20
    end

    it "changes to to (from + 10; default) if to < from or to < 0" do
      range = EdamamApiWrapper.validate_req_range(1, 0)
      range[:from].must_equal 1
      range[:to].must_equal 11

      range = EdamamApiWrapper.validate_req_range(5, -5)
      range[:from].must_equal 5
      range[:to].must_equal 15
    end

    it "changes to to 10 if from < 0 and to <= 0" do
      range = EdamamApiWrapper.validate_req_range(-2, 0)
      range[:from].must_equal 0
      range[:to].must_equal 10

      range = EdamamApiWrapper.validate_req_range(-7, -7)
      # puts range
      range[:from].must_equal 0
      range[:to].must_equal 10
    end

  end


end
