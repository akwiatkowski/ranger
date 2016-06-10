require "./range"

struct Ranger(B, E)
  def initialize(r : Range(B, E))
    @ranges = Array(Range(B, E)).new
    @ranges << r
  end

  getter :ranges

  def initialize(@ranges : Array(Range(B, E)))
  end

  def +(other)
    self_rangers = @ranges
  end

  def self.include(ra : Ranger(B, E), rb : Ranger(B, E))
    ranges = Array(Range(B, E)).new

    # if self.includes_range?(other)
    #   # self contains whole other
    #   return Ranger.new(self)
    #
    # elsif other.includes_range?(self)
    #   # other contains whole self
    #   return Ranger.new(other)
    #
    # elsif self.includes_begin_of?(self)
    # end
  end

  def self.include_pair(ra : Range(B, E), rb : Range(B, E))

  end

end
