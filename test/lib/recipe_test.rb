require 'test_helper'

describe "Recipe Class" do
  describe "initialize" do
    it "Can be instanciated with name, original_url, ingredients, dietLabels" do
      Recipe.new("name", "original_url", "ingredients", "dietLabels").must_be_instance_of Recipe
    end

    it "Raises ArgumentError if name is either nil or empty string" do
      proc {
        Recipe.new()
      }.must_raise ArgumentError

      proc {
        Recipe.new("", "")
      }.must_raise ArgumentError

    end

    it "Tracks required parameters: name, original_url, ingredients, dietLabels" do

    end


  end
end
