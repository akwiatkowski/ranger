struct Range(B, E)
  def +(other)
    if self.includes_range?(other)
      # (1..10) + (2..5) => (1..10)
      return [self]

    elsif other.includes_range?(self)
      # (2..5) + (1..10) => (1..10)
      return [other]

    elsif self.includes_begin_of?(other)
      # (1..10) + (2..12) => (1..12)
      return [(self.n_begin)..(other.n_end)]

    elsif self.includes_end_of?(other)
      # (1..10) + (0..5) => (0..10)
      return [(other.n_begin)..(self.n_end)]

    elsif self.exclusive?(other)
      # (1..2) + (5..10) => (1..2) + (5..10)
      return [self, other]

    end
  end

  def -(other)
    if other.includes_range?(self)
      return Array(Range(B, E)).new

    elsif self.includes_range?(other)
      # (1..10) - (2..5) => (1..2) + (5..10)
      return [(self.n_begin)..(other.n_begin), (other.n_end)..(self.n_end)]

    elsif self.includes_begin_of?(other)
      # (1..10) - (2..12) => (1..2)
      return [(self.n_begin)..(other.n_begin)]

    elsif self.includes_end_of?(other)
      # (1..10) - (0..5) => (5..10)
      return [(other.n_end)..(self.n_end)]

    elsif self.exclusive?(other)
      return [self]

    end
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

  def <(other)
    self.n_begin < other.n_begin
  end

  def >(other)
    self.n_begin < other.n_begin
  end

  def mergable_with?(other)
    # TODO refactor it
    self.exclusive?(other) == false
  end

  def merge_with(other)
    # TODO refactor it
    result = self + other
    if result && result.size == 1
      return result[0]
    else
      return nil
    end
  end

end
