class RecipesController < ApplicationController
  def index
    @recipes = ApiMuncherWrapper.list_recipes("chicken")
  end

  # def new
  #   # @channel = SlackApiWrapper.new
  #   @channel = params[:channel]
  # end
  #
  # def create
  #   response = SlackApiWrapper.send_msg(params[:channel], params[:message])
  #
  #   if response
  #     flash[:message] = "Message Posted Successfully"
  #     flash[:status] = "success"
  #   else
  #     flash[:message] = "Error Sending Message"
  #     flash[:status] = "error"
  #   end
  #   redirect_to root_path
  # end
end
