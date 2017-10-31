require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]


  # def self.list_channels
  #   # url = BASE_URL + "channels.list?" + "token=#{TOKEN}" + "&exclude_archived=1"
  #   # url = "https://slack.com/api/channels.list?token=sdfkljljksdf/&exclude_archived=1" -- This is what it will look like
  #
  # url = BASE_URL + "channels.list?" + "token=#{TOKEN}" + "&pretty=1&exclude_archived=1"
  # data = HTTParty.get(url)
  # channel_list = []
  #
  # if data["channels"]
  #   data["channels"].each do |channel_data|
  #     channel_list << create_channel(channel_data)
  #   end
  # end
  # return channel_list
  # end
end
