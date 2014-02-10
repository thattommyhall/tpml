require 'treetop'

Treetop.load('scheme.treetop')

class Parser
  @parser = SchemeParser.new
  def self.parse(expression)
    @parser.parse(expression)
  end
end
