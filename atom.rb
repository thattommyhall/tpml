class Atom
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol.to_sym
  end

  def ==(other)
    symbol == other.symbol
  end

  def evaluate(env={})
    int? ? to_int : env[symbol]
  end

  def int?
    !!(symbol =~ /^[-+]?[0-9]+$/)
  end

  def to_int
    symbol.to_s.to_i
  end
end
