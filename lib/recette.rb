class Recette
  attr_reader :title, :image, :url, :ingredients
  NO_IMAGE = "https://i5.walmartimages.com/asr/f752abb3-1b49-4f99-b68a-7c4d77b45b40_1.39d6c524f6033c7c58bd073db1b99786.jpeg?odnHeight=450&odnWidth=450&odnBg=FFFFFF"

  def initialize(hash)
    raise ArgumentError if hash["label"] == nil || hash["label"] == ""

    @title = hash["label"]

    hash["image"] ? @image = hash["image"] : @image = NO_IMAGE

    hash["url"] ? @url = hash["url"] : @url = www.google.com

    hash["ingredientLines"].count > 0 ? @ingredients = hash["ingredientLines"] : @ingredients = ["No ingredient found"]

  end

end
