require_relative '../instruction'
class JmpInstruction < Instruction
  def initialize(args, interpreter)
    super("JMP", args, interpreter)
  end

  def execute
    address = args.first.to_i
    if address.between?(0, ALIInterpreter::PROGRAM_MEMORY_SIZE - 1)
      interpreter.pc = address - 1
      if interpreter.describe_instruction
        puts describe(address)
        end
    else
      raise "Jump address out of bounds."
    end
  end

  private
  def describe(address)
    "Transferring control to address #{address}"
  end
end