require 'test_helper'

describe EdamamApiWrapper do
  describe "search" do
    it "can return an array of recipe objects" do
      VCR.use_cassette("search") do

      end

    end

    it "will return an empty array for a search that returns no results" do
      VCR.use_cassette("search") do

      end

    end

    #Test for lack of APP key or App ID
    it "will return return an empty array if it lacks an app key or an app id" do
      VCR.use_cassette("search") do

      end

    end

    it "will return an empty array if given a bogus id or key" do
      VCR.use_cassette("search") do

      end

    end
  end


  describe "search_item" do

    it "will return a recipe object" do
      VCR.use_cassette("search_item") do

      end

    end

    it "will return nil for a search that doesn't exit" do
      VCR.use_cassette("search_item") do

      end

    end

    it "will return nil if the app_key is wrong" do
      VCR.use_cassette("search_item") do

      end

    end

    it "will return nil if the app_id is wrong" do
      VCR.use_cassette("search_item") do

      end

    end

  end



end
