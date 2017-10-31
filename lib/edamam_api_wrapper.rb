class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]
#https://api.edamam.com/search?q=chicken&app_id=d2fbdaf7&app_key=6e7b5b6faead1b3deffb7fe4416542c2

  def self.search(q)
    url = BASE_URL + "?q=#{q}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"
    # + "&from=0" + "&to=1000"
    data = HTTParty.get(url)
    #
    matched_recipes = []
    if data["hits"]
      data["hits"].each do |hit_data|
        matched_recipes << create_recipe(hit_data)
      end
    end
    return matched_recipes
  end
# response.parsed_response["hits"]

  private
  # TODO: Continue to create new instance of a recipe
  def self.create_recipe(api_params)
    return Channel.new()
  end
end

# Wrap HTTP Party in a class and then call it in the controller
