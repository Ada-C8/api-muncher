require "test_helper"

describe Recipe do

  it "can be instantiatd with all instances" do
    Recipe.new
  end

  it "requires all parameters" do
    proc {
      Recipe.new()
    }.must_raise ArgumentError

    proc {
      Recipe.new("name")
    }.must_raise ArgumentError

    proc {
      Recipe.new("", "")
    }.must_raise ArgumentError
  end

end
