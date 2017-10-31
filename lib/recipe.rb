require 'httparty'

class Recipe

  # base_uri 'api.edamam.com'  ### NOT SURE IF I NEED THIS?!?

  attr_reader :label, :image, :url, :ingredients, :servings, :dietary_info

  def initialize(label, image, url, options = {})
    raise ArgumentError if name == nil || name == "" || id == nil || id == ""

    @label = label
    @image = image
    @url = url

    @ingredients = options[:ingredients]
    @yield = options[:servings]
    @total_nutrients = options[:total_nutrients]

  end




  # def self.get_weather(state, city)
  #   response = get("/api/#{ENV["wunderground_key"]}/conditions/q/#{state}/#{city}.json")
  #   if response.success?
  #     new(response)
  #   else
  #     raise response.response
  #   end
  # end

end
