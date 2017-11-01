
class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search?"
  ID = ENV["EDAMAM_ID"]
  KEY = ENV["EDAMAM_KEY"]

  class ApiError < StandardError
  end

  class NoResultsError < StandardError
  end

  class BadSearchTermError < StandardError
  end

  class BlankSearchError < StandardError
  end

  def self.get_recipies(search_term, key=KEY)
    # check that the search term only contains letters and spaces before requesting info from the API
    empty_search_term(search_term)
    contain_symbols(search_term)

    # define the request url
    url = BASE_URL + "q=" + search_term + "&app_id=" + ID + "&app_key=" + key

    # send the request to the Edamam API
    response = HTTParty.get(url)

    # Create an empty array to hold the instances of Recipe created
    recipies_returned = []

    if response.code == 200
      # if there are search results than create an instance of recipe for each "hit"
      if response["count"] > 0
        response["hits"].each do |recipe_data|
          recipies_returned << create_recipe(recipe_data)
        end # .each
      else
        raise NoResultsError.new("Sorry, no recipies match that serch term.")
      end # if/else ["count"]
    else
      raise ApiError.new("Call to Edamam API failed. Status was #{response.code} #{response.message}")
    end # if ["hits"]
    return recipies_returned
  end # get_recipies

  def self.show_recipe(uri, key=KEY)
    begin
      # encode the uri from the show controller
      encoded_uri = URI.encode(uri)
      show_url = BASE_URL + "r=" + encoded_uri + "&app_id=" + ID + "&app_key=" + key

      # make the request
      response = HTTParty.get(show_url)

      #create an instance of Recipe from the api response
      # return this instance
      if response.message == "OK"
        if response[0]
          create_single_recipe(response)
        else
          raise ApiError.new("Could not get body for response")
        end # if response[0]["label"]
      else
        raise ApiError.new("Call to Edamam API failed. Status was #{response.code} #{response.message}")
      end

    # NOTE: HTTParty parses the json, which, in the case where the uri is bogus, will throw a JSON::ParserError. So, I need to have this rescue block to catch this to make the "bad uri" test pass
    rescue JSON::ParserError => e
      raise ApiError.new("Call to Edamam API failed. Exception message: #{e.message}")
    end # rescue
  end # show_recipe


  private

  def self.empty_search_term(search_term)
    if search_term == ""
      raise BlankSearchError.new("You entered a blank search term .... let's try that agine)")
    end
  end

  def self.contain_symbols(search_term)
    if !(search_term.match(/\A[[:alpha:][:blank:]]+\z/))
      raise BadSearchTermError.new("Sorry, your search term cannot contain numbers or symbols: #{search_term}")
    end # if
  end

  def self.create_single_recipe(response)
    return Recipe.new(
    response[0]["label"],
    response[0]["uri"],
    {
      photo: response[0]["image"],
      url: response[0]["url"],
      ingredients: response[0]["ingredients"],
      diet_labels: response[0]["dietLabels"],
      uri: response[0]["uri"],
      company: response[0]["source"]
    }
    )
  end # create_singe_recipe

  def self.create_recipe(api_hits)
    return Recipe.new(
    api_hits["recipe"]["label"],
    api_hits["recipe"]["uri"],
    {
      photo: api_hits["recipe"]["image"],
      url: api_hits["recipe"]["url"],
      ingredients: api_hits["recipe"]["ingredients"],
      diet_labels: api_hits["recipe"]["dietLabels"],
      uri: api_hits["recipe"]["uri"]
    }
    )
  end # self.create_recipe
end # class
