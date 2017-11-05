class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  EDAMAM_KEY = ENV["EDAMAM_KEY"]
  EDAMAM_ID = ENV["EDAMAM_ID"]

  class ApiError < StandardError
  end

  def self.list_recipes(search_term)

    url = BASE_URL + "q=#{search_term}" + "&app_id=" + EDAMAM_ID + "&app_key=" + EDAMAM_KEY

    data = HTTParty.get(url)
    recipe_list = []
    if data["hits"]
      data["hits"].each do |result|

      recipe_list << parse_recipe(result["recipe"])
      end
    end

    return recipe_list
  end

  # https://api.edamam.com/search?r=http://www.edamam.com/ontologies/edamam.owl%23recipe_637913ec61d9da69eb451818c3293df2&app_id=a1c4badd&app_key=c5abe96e61c6a92d0ba6194cdf6469fb

  def self.show_recipe(uri)
    # encoded_uri = URI.encode(uri)
    # construct the url
    url = BASE_URL + "http://www.edamam.com/ontologies/edamam.owl%23recipe_" + "r=#{uri}" + "&app_id=" + EDAMAM_ID + "&app_key=" + EDAMAM_KEY
    # make httparty request
    data = HTTParty.get(url).parsed_response
    # return instance of recipe
    parse_recipe(data[0])

  end

  private

  def self.parse_recipe(raw_recipe)
    return Recipe.new(
      name: raw_recipe["label"],
      uri: raw_recipe["uri"],
      url: raw_recipe["url"],
      ingredients: raw_recipe["ingredients"],
      image_url: raw_recipe["image_url"],
      servings: raw_recipe["yield"],
      calories: raw_recipe["calories"],
      total_nutrients: raw_recipe["total_nutrients"],
      health_labels: raw_recipe["health_labels"],
      diet_labels: raw_recipe["diet_labels"]
    )
  end
end
