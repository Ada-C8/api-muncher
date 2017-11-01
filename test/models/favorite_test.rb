require "test_helper"

describe Favorite do
  let(:favorite) { Favorite.new }

  it "must be valid" do
    value(favorite).must_be :valid?
  end
end
