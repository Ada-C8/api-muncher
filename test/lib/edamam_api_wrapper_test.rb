require 'test_helper'

describe EdamamApiWrapper do

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
          num_recipes.must_equal 0
        end
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
