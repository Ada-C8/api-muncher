require 'test_helper'

describe Search do
  before do
    VCR.use_cassette("list_all") do
      @search = EdamamApiWrapper.find_recipes("chicken")
    end
  end

  it "initializes" do
    @search.must_be_instance_of Search
  end

  it "must respond to attributes" do
    @search.must_respond_to :query

    @search.must_respond_to :hits
    @search.hits.must_be_instance_of Array

    @search.must_respond_to :page
    @search.page.must_be_instance_of Integer
    @search.page.must_equal 1
  end
end
