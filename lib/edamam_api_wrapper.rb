require 'httparty'
require 'ap'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search?"
  APP_KEY = ENV["EDAMAM_KEY"]
  APP_ID = ENV["EDAMAM_ID"]

  MAX_SEARCH_LENGTH = 100 #dev api max hits/search allowed
  MAX_API_CALLS = 5 # only 5 api calls per min allowed
  MINIMUM_BAR = %w(label uri image ingredientLines)
  RECIPE_URL = "http://www.edamam.com/ontologies/edamam.owl%23recipe_"

  #BUG: Too fast for API calls. WOuld need to run through a list of app keys and ids :/
  # def self.loop_search(query)
  #   i = 0
  #
  #   total_recipes = Array.new
  #   while i <= (MAX_API_CALLS - 1) * MAX_SEARCH_LENGTH
  #     total_recipes += self.search(query, from: i, to: (i + MAX_SEARCH_LENGTH))
  #     i += MAX_SEARCH_LENGTH
  #   end
  #
  #   return total_recipes
  #
  # end

  def self.search(query, options = { } )
    options[:app_id] ||= APP_ID
    options[:app_key]||= APP_KEY
    options[:from] ||= 0
    options[:to] ||= MAX_SEARCH_LENGTH

    url = BASE_URL + "q=#{query}" + "&app_id=#{options[:app_id]}" + "&app_key=#{options[:app_key]}" + "&from=#{options[:from]}" + "&to=#{options[:to]}"

    response = HTTParty.get(url)

    if response["hits"]
      recipe_hits = response["hits"].map do |hit|
        if self.complete?(hit["recipe"])
          Recipe.new(
            hit["recipe"]["label"],
            hit["recipe"]["uri"],
            hit["recipe"]["image"],
            hit["recipe"]["ingredientLines"],
            external_url: hit["recipe"]["url"],
            source: hit["recipe"]["source"],
            labels: hit["recipe"]["dietLabels"]
          )
        end
      end
      return recipe_hits
    else
      return []
    end
  end

  def self.find_recipe(mini_uri, options = { })
    options[:app_id] ||= APP_ID
    options[:app_key] ||= APP_KEY

    url = BASE_URL + "r=" + RECIPE_URL + mini_uri + "&app_id=#{options[:app_id]}" + "&app_key=#{options[:app_key]}"

    response = HTTParty.get(url)

    if response[0]
      if self.complete?(response[0])
        recipe = Recipe.new(
          response[0]["label"],
          response[0]["uri"],
          response[0]["image"],
          response[0]["ingredientLines"],
          external_url: response[0]["url"],
          source: response[0]["source"],
          labels: response[0]["dietLabels"]
        )
      end
      return recipe
    else
      return nil
    end
  end

  def self.complete?(hash)
    MINIMUM_BAR.each do |bar|
      unless hash[bar]
        return false
      end
      return true
    end

  end
end
