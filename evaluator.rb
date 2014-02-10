class Evaluator
  def initialize(program)
    @sexps = program.sexps
  end

  def evaluate(env={})
    @sexps.last.evaluate(env)
  end
end
