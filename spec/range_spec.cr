require "./spec_helper"

describe Range do
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

  it "include 2 simple Range" do
    result = (1..2) + (2..3)
    result[0].should eq 1..3
  end

  it "exclude 2 simple Range" do
    result = (1..10) - (5..6)
    result[0].should eq 1..5
    result[1].should eq 6..10
  end

  it "include 2 Time Range objects" do
    ra = (Time.new(2016, 1, 1))..(Time.new(2016, 2, 1))
    rb = (Time.new(2016, 2, 1))..(Time.new(2016, 3, 1))

    result = ra + rb

    result[0].begin.month.should eq 1
    result[0].end.month.should eq 3
  end

  it "divite Range into 2 objects" do
    result = (0..10) / 2
    result[0].should eq 0..5
    result[1].should eq 5..10
  end

  it "divite 1-month Range into 4 ranges" do
    ra = (Time.new(2016, 1, 1))..(Time.new(2016, 2, 1))

    result = ra / 4

    result.size.should eq 4
  end

  it "divite 1-month Range into 1-week ranges, allow partial" do
    ra = (Time.new(2016, 1, 1))..(Time.new(2016, 2, 1))
    j = Time.new(2016, 1, 8) - Time.new(2016, 1, 1)

    result = ra % j

    # last week is not full
    result[0..-2].each do |r|
      span = r.end - r.begin
      span.should eq j
    end
  end

  it "divite 1-month Range into 1-week ranges, allow partial" do
    ra = (Time.new(2016, 1, 1))..(Time.new(2016, 2, 1))
    j = Time.new(2016, 1, 8) - Time.new(2016, 1, 1)

    result = ra ^ j

    # last week is not full
    result.each do |r|
      span = r.end - r.begin
      span.should eq j
    end
  end

end
