

class MuncherApiWrapper
  BASE_URL = "https://test-es.edamam.com/search"
  ID = ENV["EDAMAN_ID"]
  KEY = ENV["EDAMAN_KEY"]

  class ApiError < StandardError
  end

  def self.find_recipes(word, page, api_id = ID, api_key = KEY)
    url = BASE_URL + "?q=" + word + "&app_id=#{api_id}" + "&app_key=#{api_key}"+"&from=#{((page.to_i)*10)-10}&to=#{page.to_i*10}"

    data = HTTParty.get(url)
    amount = data["count"]
    status(data)
    recipe_list = []
    if data["hits"]
      data["hits"].each do |recipe_array|
        recipe_list << create_recipe(recipe_array["recipe"])
      end
    end
    return recipe_list, amount
  end

  def self.one_recipe(id)
    url = BASE_URL + "?r=http://www.edamam.com/ontologies/edamam.owl%23recipe_" + "#{id}" + "&app_id=#{ID}" + "&app_key=#{KEY}"
    data = HTTParty.get(url)
    status(data)
    if data.empty?
      return []
    else
      return create_recipe(data[0])
    end
  end

  private
  def self.create_recipe(api_params)
    return Recipe.new(
    api_params["uri"][-32..-1],
    api_params["label"],
    api_params["image"],
    api_params["url"],
    api_params["ingredientLines"],
    api_params["dietLabels"]
    )
  end

  def self.status(data)
    if data.code == 401
      raise ApiError.new("Find recipes failed: #{data.message}")
    end
  end
end
