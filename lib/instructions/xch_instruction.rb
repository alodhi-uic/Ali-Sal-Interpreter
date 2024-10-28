require_relative '../instruction'
class XchInstruction < Instruction
  def initialize(args, interpreter)
    super("XCH", args, interpreter)
  end

  def execute
    temp = interpreter.a
    interpreter.a = interpreter.b
    interpreter.b = temp
    if interpreter.describe_instruction
      puts describe
    end
  end

  private
  def describe
    puts "Exchanges the content registers A and B."
  end
end
