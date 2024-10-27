require_relative '../instruction'
class LdaInstruction < Instruction
  def initialize(args, interpreter)
    super("LDA", args, interpreter)
  end

  def execute
    symbol = args.first
    interpreter.lda(symbol)
  end
end
