require "httparty"
# require "pry"
#
class EdamamApiMuncher
  BASE_URL = "https://api.edamam.com/search?q="
  APP_ID = ENV["API_ID"]
  API_KEY = ENV["API_KEY"]
#
#
# # q=chicken&app_id=3959fd1f&app_key=d4f2a5e71269a4e586e6b5bf09346f8a
  def self.list_recipes(food)
    url = BASE_URL + food + "&app_id=#{APP_ID}" + "&app_key=#{API_KEY}"
    data = HTTParty.get(url)

    # check_status(data)

    # recipe_list = []
    # if data["hits"]
    #   data["hits"].each do |hit|
    #     hit.each do |recipe|
    #       recipe_list << create_recipe(recipe)
    #     end
    #   end
    # end
    # return recipe_list
  end

  # private

  # def self.check_status(response)
  #   unless response["ok"]
  #     raise ApiError.new("API call to slack failed: #{response["error"]}")
  #   end
  # end

  # def self.create_recipe(api_params)
  #     return Recipe.new(
  #       api_params["hits"]
  #       {
  #         api_params["recipe"]["uri"],
  #         api_params["recipe"]["label"],
  #         api_params["recipe"]["image"],
  #         api_params["recipe"]["source"],
  #         api_params["recipe"]["url"],
  #         api_params["recipe"]["ingredients"]{
  #           text: api_params["text"],
  #           quantity: api_params["quantity"],
  #           measure: api_params["measure"],
  #           food: api_params["food"],
  #           weight: api_params["weight"]
  #         }
  #       }
  #     )
  #   end
end
