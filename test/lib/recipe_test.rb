require 'test_helper'

describe Recipe do
  describe 'create recipe' do
    it "can create a recipe" do


    end

    it "must have a uri and a name" do
      proc {
        Recipe.new
      }.must_raise ArgumentError
      proc {
        Recipe.new
      }.must_raise ArgumentError
    end

    it "can accept optional parametrs" do


    end
  end

  describe "attr_readers" do
    it "can read a uri" do

    end

    it "can read a name" do

    end

    it "can read an image url" do

    end

    it "can read the ingredients" do

    end


    it "can read the calories" do


    end

    it "can read the totalNutrients" do
      
    end
  end



end
