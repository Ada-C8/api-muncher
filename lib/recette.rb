class Recette

  attr_reader :title, :image, :url, :ingredients, :calories, :nutrients, :dailyneed, :source, :diet_labels, :health_labels, :allergies, :uri
  NO_IMAGE = "https://i5.walmartimages.com/asr/f752abb3-1b49-4f99-b68a-7c4d77b45b40_1.39d6c524f6033c7c58bd073db1b99786.jpeg?odnHeight=450&odnWidth=450&odnBg=FFFFFF"

  def initialize(hash)
    raise ArgumentError if hash["label"] == nil || hash["label"] == "" || hash["uri"] == nil || hash["uri"] == ""

    @title = hash["label"]

    @uri = hash["uri"]

    hash["image"] ? @image = hash["image"] : @image = NO_IMAGE

    hash["url"] ? @url = hash["url"] : @url = nil

    hash["source"] ? @source = hash["source"] : @source = nil

    hash["dietLabels"] && hash["dietLabels"].count > 0 ? @diet_labels = hash["dietLabels"] : @diet_labels = nil

    hash["healthLabels"] && hash["healthLabels"].count > 0 ? @health_labels = hash["healthLabels"] : @health_labels = nil

    hash["ingredientLines"] && hash["ingredientLines"].count > 0 ? @ingredients = hash["ingredientLines"] : @ingredients = ["No ingredient found"]

    hash["cautions"] && hash["cautions"].count > 0 ? @allergies = hash["cautions"] : @allergies = nil

    calories = hash["calories"]
    if hash["yield"] && hash["yield"].to_f > 0
      if calories
        @calories = (hash["calories"].to_f/hash["yield"].to_f).to_i.to_s + " calories per serving"
      else
        @calories = "No calories info"
      end
    else
      if calories
        @calories = hash["calories"] + " calories total"
      else
        @calories = "No calories info"
      end
    end

    if hash["digest"] == nil || hash["digest"].empty?
      @nutrients = {}
    else
      @nutrients = hash["digest"]
    end

    if hash["totalDaily"] == nil || hash["totalDaily"].empty?
      @dailyneed = {}
    else
      @dailyneed = hash["totalDaily"]
    end

  end

end
