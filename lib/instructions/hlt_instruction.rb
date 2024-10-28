require_relative '../instruction'
class HltInstruction < Instruction
  def initialize(args, interpreter)
    super("HLT", args, interpreter)
  end

  def execute
    puts "Program halted."
    exit(0) # Exit the program
  end
end