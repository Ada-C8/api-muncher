
class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  BASE_URI = "http://www.edamam.com/ontologies/edamam.owl%23recipe_"
  ID = ENV["APP_ID"]
  KEY = ENV["APP_KEY"]
  # https://api.edamam.com/search?q=chicken&app_id=f7b7eda5&app_key=27bec363ca9b3dd18381e83986bb5fc9
  def self.search(q)
    url = BASE_URL + "?q=#{q}" + "&app_id=#{ID}" + "&app_key=#{KEY}"
    data = HTTParty.get(url)
    recipes = []
    if data["hits"]
      data["hits"].each do |recipe|
        recipes << create_recipe(recipe["recipe"])
      end
      return recipes
    else
      return []
    end
  end

#http://www.edamam.com/ontologies/edamam.owl%23recipe_637913ec61d9da69eb451818c3293df2
  def self.find_recipe(id)
    url = BASE_URL + "?r=" + BASE_URI + "#{id}" + "&app_id=#{ID}" + "&app_key=#{KEY}"
    data = HTTParty.get(url)
    # data is an array
    # recipe_result
    unless data.empty?
      return create_recipe(data[0])
    else
      return []
    end
  end


  private

  def self.create_recipe(api_params)
    return Recipe.new(
      api_params["uri"],
      api_params["url"],
      api_params["label"],
      api_params["image"],
      api_params["ingredients"]
      # {
      #   purpose: api_params["purpose"],
      #   is_archived: api_params["is_archived"],
      #   members: api_params["members"]
      # }
    )
  end

end
