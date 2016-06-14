require "./range"

struct Ranger(B, E)
  def initialize(r : Range(B, E))
    @operations = Array(Tuple(Symbol, Range(B, E))).new
    @operations << {:add, r}
  end

  getter :operations

  def initialize(ranges : Array(Range(B, E)))
    @operations = Array(Tuple(Symbol, Range(B, E))).new
    ranges.each do |r|
      @operations << {:add, r}
    end
  end

  def include(r : Range(B, E))
    @operations << {:add, r}
  end

  def exclude(r : Range(B, E))
    @operations << {:remove, r}
  end

  def render
    temp_ranges = Array(Range(B, E)).new
    return temp_ranges if @operations.size == 0

    @operations.each do |o|
      range = o[1] as Range(B, E)
      op_type = o[0]

      if op_type == :add
        temp_ranges << range
      elsif op_type == :remove
        temp_ranges = temp_ranges.map do |r|
          result = r - range
          result
          r
        end

        temp_ranges = temp_ranges.flatten
      end
    end

    return normalize(temp_ranges)
  end

  def normalize(temp_ranges)
    sorted_ranges = temp_ranges.sort
    i = 0

    while i < sorted_ranges.size
      if i < (sorted_ranges.size - 1) && sorted_ranges[i].mergable_with?(sorted_ranges[i+1])
        merged = (sorted_ranges[i].merge_with(sorted_ranges[i+1])) as Range(B, E)
        sorted_ranges[i] = merged
        sorted_ranges.delete_at(i+1)
      end

      i += 1
    end

    return sorted_ranges
  end

  # def self.include(ra : Ranger(B, E), rb : Ranger(B, E))
  #   ranges = Array(Range(B, E)).new
  #
  #   # if self.includes_range?(other)
  #   #   # self contains whole other
  #   #   return Ranger.new(self)
  #   #
  #   # elsif other.includes_range?(self)
  #   #   # other contains whole self
  #   #   return Ranger.new(other)
  #   #
  #   # elsif self.includes_begin_of?(self)
  #   # end
  # end
  #
  # def self.include_pair(ra : Range(B, E), rb : Range(B, E))
  #
  # end

end
