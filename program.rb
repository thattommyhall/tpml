class Program
  def initialize(*sexps)
    @sexps = sexps
  end

  attr_reader :sexps
  def ==(other)
    sexps == other.sexps
  end
end
