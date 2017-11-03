# :nodoc:
class RecipeSearch
  ID = ENV['RECIPE_ID']
  KEY = ENV['RECIPE_KEY']

  BASE_URL = 'https://api.edamam.com/search?'
  AUTH_URL = "app_id=#{ID}&app_key=#{KEY}"
  FIND_URL = "http://www.edamam.com/ontologies/edamam.owl%23recipe_"

  # The RecipeSearch API has a 'more' value, but it seems to give inconsistent results?
  def self.search(query, page = 0, count = 10, more = false)
    from = page * count
    to = from + count + (more ? 1 : 0)
    url = BASE_URL + AUTH_URL + "&q=#{query}&from=#{from}&to=#{to}"

    response = HTTParty.get(url)
    raise(APIError, response.message) unless response.code == 200

    recipes = []
    response['hits'].each do |recipe|
      recipes << new_recipe(recipe['recipe'])
    end

    if more
      are_more = check_if_more(recipes, count)
      return [recipes, are_more]
    else
      return recipes
    end
  end

  def self.find(id)
    url = BASE_URL + AUTH_URL +  "&r=" + FIND_URL + id
    response = HTTParty.get(url)

    begin
      return nil if response.empty?
    rescue
      return nil
    end

    new_recipe(response[0])
  end

  private

  def self.check_if_more(recipes, count)
    if recipes.length < count
      return false
    else
      recipes.delete_at(-1)
      return true
    end
  end

  def self.new_recipe(params)
    Recipe.new(
      name: params['label'],
      image_url: params['image'],
      recipe_url: params['url'],
      recipe_uri: params['uri'][-32..-1],
      source: params['source'],
      ingredients: params['ingredientLines'],
      nutrition: params['totalNutrients'],
      diet_labels: params['healthLabels'],
      servings: params['yield']
    )
  end

  class APIError < RuntimeError; end
end
