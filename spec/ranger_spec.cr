require "./spec_helper"

describe Ranger do
  it "check inclusion methods" do
    # includes_range?
    (1..10).includes_range?(2..5).should eq true
    (1..10).includes_range?(2..12).should eq false
    (1..10).includes_range?(0..5).should eq false
    (1..10).includes_range?(0..20).should eq false
    (1..10).includes_range?(20..30).should eq false

    # includes_begin_of?
    (1..10).includes_begin_of?(2..5).should eq false
    (1..10).includes_begin_of?(2..12).should eq true
    (1..10).includes_begin_of?(0..5).should eq false
    (1..10).includes_begin_of?(0..20).should eq false
    (1..10).includes_begin_of?(20..30).should eq false

    # includes_end_of?
    (1..10).includes_end_of?(2..5).should eq false
    (1..10).includes_end_of?(2..12).should eq false
    (1..10).includes_end_of?(0..5).should eq true
    (1..10).includes_end_of?(0..20).should eq false
    (1..10).includes_end_of?(20..30).should eq false

    # exclusive?(other)
    (1..10).exclusive?(2..5).should eq false
    (1..10).exclusive?(2..12).should eq false
    (1..10).exclusive?(0..5).should eq false
    (1..10).exclusive?(0..20).should eq false
    (1..10).exclusive?(20..30).should eq true

  end

  it "sum 2 ranges" do
    ra = Ranger.new(1..2)
    rb = Ranger.new(1..2)

    sum = Ranger.include(ra, rb)

    puts sum.inspect
  end


end
