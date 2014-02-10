class List
  def initialize(*array)
    @array = array
  end

  def car
    @array.first
  end

  def cdr
    self.class.new(*@array[1..-1])
  end

  def ==(other)
    array == other.array
  end

  def evaluate(env = {})
    function = car.symbol
    arguments = @array[1..-1]
    case function
    when :quote
      arguments[0]
    when :car
      arguments[0].evaluate(env).car
    when :cdr
      arguments[0].evaluate(env).cdr
    end
  end
  attr_reader :array
end
