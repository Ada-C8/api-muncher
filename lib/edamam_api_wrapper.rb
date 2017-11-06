
class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  BASE_URI = "http://www.edamam.com/ontologies/edamam.owl%23recipe_"
  ID = ENV["APP_ID"]
  KEY = ENV["APP_KEY"]

  class ApiError < StandardError
  end

  def self.search(q, options = {}, app_id=ID, app_key=KEY)
    @url = BASE_URL + "?q=#{q}" + "&app_id=#{app_id}" + "&app_key=#{app_key}&to=100"
    if options.keys.count > 0
      options.each do |key, value|
        unless options[key].empty?
          value.each do |value|
            @url << "&#{key.to_s}=#{value}"
          end
        end
      end
    end
    data = HTTParty.get(@url)

    check_status(data)
    recipes = []
    if data["hits"]
      data["hits"].each do |recipe|
        recipes << create_recipe(recipe["recipe"])
      end
    end
    return recipes
  end

  def self.find_recipe(id)
    url = BASE_URL + "?r=" + BASE_URI + "#{id}" + "&app_id=#{ID}" + "&app_key=#{KEY}"

    data = HTTParty.get(url)

    check_status(data)
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
      {
        ingredients: api_params["ingredients"],
        source: api_params["source"],
        dietLabels: api_params["dietLabels"],
        image: api_params["image"],
        healthLabels: api_params["healthLabels"]
      }
    )
  end

  def self.check_status(response)
    unless response.code == 200
      raise ApiError.new("API call to Edamam failed with a status code of #{response.code} and a message of #{response.message}")
    end
  end

end
