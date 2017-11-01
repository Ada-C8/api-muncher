require "test_helper"

describe Search do
  let(:search) { Search.new }

  it "must be valid" do
    value(search).must_be :valid?
  end
end
