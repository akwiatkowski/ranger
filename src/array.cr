class Array
  def sort_ranges
    self.sort do |a, b|
      begin_sort = a.begin <=> b.begin
      end_sort = a.end <=> b.end

      begin_sort == 0 ? end_sort : begin_sort
    end
  end
end
