class Recipe

  def initialize(response)
    @title = response['recipe']['label']
  end

end
