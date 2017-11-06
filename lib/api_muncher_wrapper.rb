require "httparty"

class  ApiMuncherWrapper
  BASE_URL = "https://edamam.com/"

  def self.get_recipes(search_term, from)
    puts "Searching for recipes about #{search_term}."
    # url = BASE_URL + "search?q=#{search_term}" + "&from=0" + "&to=5"
    url = BASE_URL + "search?q=#{search_term}" + "&from=#{from}"
    data = HTTParty.get(url)

    recipe_list = []
    if data["hits"]
      data["hits"].each do |hit|
        recipe_list << create_recipe(hit["recipe"])
      end #
    end

    return recipe_list
  end #method

  def self.show_recipe(id)
    puts "Searching for specific recipe"
    puts "#{id}"
    search_uri = "http://www.edamam.com/ontologies/edamam.owl" + "\#" + "#{id}"
    url = BASE_URL + "search?r=#{URI.encode(search_uri)}"
    data = HTTParty.get(url)
    result = create_recipe(data[0])

    return result
  end


  private

  def self.create_recipe(api_params)
    return Recipe.new(
      api_params["uri"],
      api_params["label"],

      {
        image: api_params["image"],
        source: api_params["source"],
        shareAs: api_params["shareAs"],
        ingredientLines: api_params["ingredientLines"],
        yield: api_params["yield"],
        calories: api_params["calories"],
        dietLabels: api_params["dietLabels"],
        healthLabels: api_params["healthLabels"]
      }
    )
  end #method

end #class
