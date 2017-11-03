
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
    url = BASE_URL + "q=" + search_term + "&app_id=" + ID + "&app_key=" + key + "&to=1000"

    # send the request to the Edamam API
    response = HTTParty.get(url)

    # Create an empty array to hold the instances of Recipe created
    recipies_returned = []

    # if the API call was a success
    if response.code == 200
      # if there are search results then create an instance of Recipe for each "hit"
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
      # if there was a recipe returned from the API the message is "OK"
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

# Raises an error if the search term was empty (this is called in self.get_recipies before the API request)
  def self.empty_search_term(search_term)
    if search_term == ""
      raise BlankSearchError.new("You entered a blank search term .... let's try that agine)")
    end
  end

# Raises an error if the search term has numbers or symbols in it (this is called in self.get_recipies before the API request)
  def self.contain_symbols(search_term)
    if !(search_term.match(/\A[[:alpha:][:blank:]]+\z/))
      raise BadSearchTermError.new("Sorry, your search term cannot contain numbers or symbols: #{search_term}")
    end # if
  end

# This method picks out the data from the self.show_recipe that is needed to create and instance of Recipe to pass to the Show page
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

# this method picks out the data from the response in self.get_recipies that is needed to create and instance of Recipe.
# NOTE: Since I am making a new API call for the show page I don't really need to set the optional attributes when I am creating an instance of Recipe that will only be seen on the index page...
# QUESTION: Did I need to make a new API call for the show page? Could I have just accessed an instance of recipe if I had made Recipe a model? But do I want to store the results of every API request (that seems like a lot of data to store needlessly since the show page won't be shown for most of the instances of Recipe...)? What is the best way to do this???
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
