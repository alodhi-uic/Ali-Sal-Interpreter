require_relative '../instruction'
class JzsInstruction < Instruction
  def initialize(args, interpreter)
    super("JZS", args, interpreter)
  end

  def execute
    address = args.first.to_i
    interpreter.jzs(address)
  end
end
