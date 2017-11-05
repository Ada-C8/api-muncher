require "test_helper"

describe RecipesController do
  def set_spanish
    get root_path(locale: :es)
  end

  def set_english
    get root_path(locale: :en)
  end

  describe "home" do
    it "can get the home page" do
      get root_path(locale: :en)
      must_respond_with :success
    end

    it "can get the home page in spanish" do
      get root_path(locale: :es)
      must_respond_with :success
    end
  end

  describe "index" do
    let(:ingredient) { "chicken" }

    it "responds with success if it returns results" do
      VCR.use_cassette("index_action") do
        set_english
        get recipes_path params: { locale: :en, ingredient: ingredient }
        must_respond_with :success
      end
    end

    it "responds with success if it returns results in spanish" do
      VCR.use_cassette("index_action_es") do
        set_spanish
        get recipes_path params: { locale: :es, ingredient: "pollo" }
        must_respond_with :success
      end
    end

    it "responds with success if it returns 0 results" do
      VCR.use_cassette("index_action") do
        set_english
        get recipes_path params: { locale: :en, ingredient: "jlk" }
        must_respond_with :success
      end
    end

  end

  describe "show" do
    let(:valid_uri) { "http://www.edamam.com/ontologies/edamam.owl%23recipe_6289468ceb188ec8103d4a0c4adab6b8"}
    let(:sp_uri) { "http://www.edamam.com/ontologies/edamam.owl%23recipe_2043890c7b3d1c7eb7cbd023d245d69d" }

    it "responds with success if the recipe exists" do
      VCR.use_cassette("show_action") do
        set_english
        get recipe_path("valid recipe"), params: { name: "valid recipe", locale: :en, uri: valid_uri }
        must_respond_with :success
      end
    end

    it "responds with success if the recipe exists in spanish" do
      VCR.use_cassette("show_action_es") do
        set_spanish
        get recipe_path("arroz con pollo"), params: { name: "arroz con pollo", locale: :es, uri: sp_uri }
        must_respond_with :success
      end
    end

    it "responds with not found if the recipe doesn't exist" do
      VCR.use_cassette("show_action") do
        set_english
        get recipe_path("invalid recipe"), params: { name: "invalid recipe", locale: :en, uri: "https://www.fake.com" }
        must_respond_with :not_found
      end
    end
  end

end
