require "./spec_helper"

describe Ranger do
  it "add 2 ranges" do
    ra = (1..2)
    rb = (2..3)

    r = Ranger.new(ra)
    r.include(rb)

    result = r.render

    result.size.should eq 1
    result[0].should eq 1..3
  end

end
