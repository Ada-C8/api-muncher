
class EdamamApiWrapper
  # url, key and id needed to make API requests to the Edamam API
  BASE_URL = "https://api.edamam.com/search?"
  ID = ENV["EDAMAM_ID"]
  KEY = ENV["EDAMAM_KEY"]

  # Raised when API request fails
  class ApiError < StandardError
  end
  # Raised when the search term returns no results
  class NoResultsError < StandardError
  end
  # Raised when the search_term contains symbols or numbers
  class BadSearchTermError < StandardError
  end
  # Raised when the search_term is empty
  class BlankSearchError < StandardError
  end

# Method to make an api call to Edamam to get all the recipies that match a search term.
# get_recipies returns instances of Recipies that are created using data from the api response
  def self.get_recipies(search_term, key=KEY)
    # check that the search term only contains letters and spaces before making an API request
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
      # if there are search results then create an instance of Recipe for each recipe "hit" returned in the api response
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
    # return an array of all the Recipe instances that were generated from the API response
    return recipies_returned
  end # get_recipies

# method makes an api request for a single recipe that matches the provided uri in the api request
# show_recipe returns a single instance of Recipe that is made from data returned in the api response
  def self.show_recipe(uri, key=KEY)
    # wrap this method in a begin rescue block in order to catch the JSON::ParserError thrown by the Edamam API if the uri provided is invlaid
    begin
      # encode the uri from the argument passed from the show action
      encoded_uri = URI.encode(uri)
      # generate the url for the api request
      show_url = BASE_URL + "r=" + encoded_uri + "&app_id=" + ID + "&app_key=" + key

      # make the request
      response = HTTParty.get(show_url)

      #create and return an instance of Recipe generated from the api response data
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

    # NOTE: HTTParty parses the json, which, in the case where the uri is invalid, will throw a JSON::ParserError. So, I need to have this rescue block to catch the error raised when Edamam is sent an invalid uri
    rescue JSON::ParserError => e
      raise ApiError.new("Call to Edamam API failed. Exception message: #{e.message}")
    end # rescue
  end # show_recipe


  private

# Raises an error if the search term was empty (this is called in self.get_recipies before the API request)
  def self.empty_search_term(search_term)
    if search_term == ""
      raise BlankSearchError.new("You entered a blank search term .... let's try that again)")
    end
  end

# Raises an error if the search term has numbers or symbols in it (this is called in self.get_recipies before the API request)
  def self.contain_symbols(search_term)
    # if the search term is not all letter characters
    if !(search_term.match(/\A[[:alpha:][:blank:]]+\z/))
      raise BadSearchTermError.new("Sorry, your search term cannot contain numbers or symbols: #{search_term}")
    end # if
  end

# This method picks out the data from the api response in self.show_recipe that is needed to create a single instance of Recipe to pass to the Show page
  def self.create_single_recipe(response)
    return Recipe.new(
    # required arguments
    response[0]["label"],
    response[0]["uri"],
    # options
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
# NOTE: Since I am making a new API call for the show page I don't really need to set the optional attributes when I am creating an instance of Recipe that will only be seen on the index page... but it may be good to keep all instnces of Recipe consistent with what instance variables they have ....
# QUESTION: Did I need to make a new API call for the show page? Could I have just passed more data in the link_to params from the instance of that recipe I had already created from the get_recipies method? What is the best way to do this / best practice for this???
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
