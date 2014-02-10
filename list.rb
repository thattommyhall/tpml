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
    # puts "Called eval on #{@array}"
    function = car.symbol
    arguments = @array[1..-1]
    case function
    when :quote
      [arguments[0], env]
    when :car
      [arguments[0].evaluate(env)[0].car, env]
    when :cdr
      [arguments[0].evaluate(env)[0].cdr, env]
    when :define
      [nil, env.merge(arguments[0].symbol => arguments[1].evaluate[0])]
    else
      fail
    end
  end
  attr_reader :array
end
