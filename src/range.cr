struct Range(B, E)
  def +(other)
    return Ranger.new(self) + Ranger.new(other)
  end

  # normalized begin
  def n_begin
    [self.begin, self.end].min
  end

  # normalized end
  def n_end
    [self.begin, self.end].max
  end

  # (1..10).includes_range?(2..5)
  def includes_range?(other)
    return self.begin <= other.begin && self.end >= other.end
  end

  # (1..10).includes_begin_of?(2..12)
  def includes_begin_of?(other)
    return other.n_begin >= self.n_begin && other.n_begin <= self.n_end && other.n_end > self.n_end
  end

  # (1..10).includes_end_of?(0..5)
  def includes_end_of?(other)
    return other.n_end >= self.n_begin && other.n_end <= self.n_end && other.n_begin < self.n_begin
  end

  # (1..10).exclusive?(20..30)
  def exclusive?(other)
    return self.includes_range?(other) == false &&
      other.includes_range?(self) == false &&
      self.includes_begin_of?(other) == false &&
      self.includes_end_of?(other) == false
  end


  def +(ra, rb)
    ra
  end
end
