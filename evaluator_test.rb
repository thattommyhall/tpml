require 'minitest/autorun'

require_relative 'atom'
require_relative 'list'
require_relative 'number'
require_relative 'program'
require_relative 'evaluator'
require_relative 'parser'

class ParserTest < Minitest::Test
  def test_atom
    assert_equal Program.new(Atom.new('a')), to_ast('a')
  end

  def test_number
    assert_equal Program.new(Atom.new('1')), to_ast('1')
  end

  def test_list
    assert_equal Program.new(ab), to_ast('(a b)')
  end

  def test_program
    assert_equal Program.new(ab, cd), to_ast('(a b)(c d)')
  end

  def test_nested
    assert_equal Program.new(List.new(Atom.new('a'),List.new(Atom.new('b'),Atom.new('c')))), to_ast('(a (b c))')
  end

  def ab
    List.new(Atom.new('a'), Atom.new('b'))
  end

  def cd
    List.new(Atom.new('c'), Atom.new('d'))
  end

  def to_ast(expression)
    Parser.parse(expression).to_ast
  end
end

class EvalParseTest < Minitest::Test
  def test_number
    assert_equal 1, eval_expression('1')
  end

  def test_lookup
    assert_equal 5, eval_expression('a', 'a' => 5)
  end

  def eval_expression(expression, env={})
    evaluate(to_ast(expression), env)
  end

  def to_ast(expression)
    Parser.parse(expression).to_ast
  end

  def evaluate(program, env = {})
    Evaluator.new(program).evaluate(env)
  end
end

class EvaluatorTest < Minitest::Test
  def test_car
    assert_equal Atom.new(:a), evaluate(
      Program.new(List.new(Atom.new(:car), Atom.new(:l))),
      l: List.new(Atom.new(:a), Atom.new(:b), Atom.new(:c))
    )
  end

  def test_car_car
    assert_equal Atom.new(:hotdogs), evaluate(
      Program.new(List.new(Atom.new(:car), List.new(Atom.new(:car), Atom.new(:l)))),
      l: List.new(List.new(Atom.new(:hotdogs), Atom.new(:and)))
    )
  end

  def test_cdr
    assert_equal List.new(Atom.new(:b), Atom.new(:c)), evaluate(
      Program.new(List.new(Atom.new(:cdr), Atom.new(:l))),
      l: List.new(Atom.new(:a), Atom.new(:b), Atom.new(:c))
    )
  end

  private

  def evaluate(program, env = {})
    Evaluator.new(program).evaluate(env)
  end
end
