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
        new_ranges = Array(Range(B, E)).new
        temp_ranges.each do |r|
          result = r - range
          if result
            new_ranges += result
          end
        end

        temp_ranges = new_ranges
      end
    end

    return Range.glue(temp_ranges)
  end

end
