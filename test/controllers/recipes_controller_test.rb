require "test_helper"

describe RecipesController do
  describe 'index' do
    it 'returns success and has no recipes without params' do
      get recipes_path

      controller.instance_variables.wont_include :@recipes
      must_respond_with :success
    end

    it 'returns success and has recipes and page data with params' do
      VCR.use_cassette('cheese') do
        get recipes_path(search: "cheese")

        controller.instance_variables.must_include :@recipes
        controller.instance_variables.must_include :@more
        controller.instance_variables.must_include :@less
        must_respond_with :success
      end
    end
  end

  describe 'show' do
    it 'returns success and has a recipe with existing ID' do
      VCR.use_cassette('tacos') do
        get recipe_path("78920305364c0086ffca6bcd1def9014")

        controller.instance_variables.must_include :@recipe
        must_respond_with :success
      end
    end

    it 'returns not_found with invalid ID' do
      VCR.use_cassette('not_found') do
        get recipe_path("this-is-nothing")

        must_respond_with :not_found
      end
    end
  end

end
