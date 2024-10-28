require_relative '../instruction'
class JzsInstruction < Instruction
  def initialize(args, interpreter)
    super("JZS", args, interpreter)
  end

  def execute
    address = args.first.to_i
    if interpreter.zero_bit
      if address.between?(0, ALIInterpreter::PROGRAM_MEMORY_SIZE - 1)
        interpreter.pc = address - 1 # -1 because PC will be incremented after execution
        if interpreter.describe_instruction
          puts describe(address)
        end
      else
        raise "Jump address out of bounds."
      end
      if interpreter.describe_instruction
        puts "Cannot transfer control because zero-bit is not set."
      end
    end
  end

  private
  def describe(address)
    "Transferring control to address #{address}"
  end
end

