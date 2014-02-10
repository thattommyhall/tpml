class Evaluator
  def initialize(program)
    @sexps = program.sexps
  end

  def evaluate(env={})
    final_env = @sexps[0..-2].reduce(env) do |old_env, sexp|
      old_env.merge(sexp.evaluate(old_env)[1])
    end
    # p final_env
    @sexps.last.evaluate(final_env)[0]
  end
end
