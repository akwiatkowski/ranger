require "./spec_helper"

describe Ranger do
  it "add 2 simple ranges" do
    ra = (1..2)
    rb = (2..3)

    r = Ranger.new(ra)
    r.include(rb)

    result = r.render

    result.size.should eq 1
    result[0].should eq 1..3
  end

  it "add more ranges" do
    r = Ranger.new(1..5)
    r.include(31..32)
    r.include(0..8)
    r.include(10..20)
    r.include(11..13)
    r.include(11..12)
    r.include(18..19)
    r.include(30..32)

    result = r.render

    result.size.should eq 3
    result[0].should eq 0..8
    result[1].should eq 10..20
    result[2].should eq 30..32
  end

  it "exclude small range from bigger one to make 2 separate ranges" do
    r = Ranger.new(10..20)
    r.exclude(15..16)

    result = r.render

    result.size.should eq 2
    result[0].should eq 10..15
    result[1].should eq 16..20
  end

end
