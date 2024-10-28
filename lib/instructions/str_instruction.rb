require_relative '../instruction'
class StrInstruction < Instruction
  def initialize(args, interpreter)
    super("STR", args, interpreter)
  end

  def execute
    symbol = args.first
    data_address = find_symbol(symbol)
    interpreter.memory[data_address][:value] = interpreter.a
    if interpreter.describe_instruction
      puts describe(data_address)
    end
  end

  private

  def describe(data_address)
    "Stored content of accumulator into data memory at address #{data_address} of symbol '#{args.first}'."
  end
  def find_symbol(symbol)
    ALIInterpreter::DATA_MEMORY_START.upto(ALIInterpreter::MEMORY_SIZE - 1) do |address|
      if interpreter.memory[address].is_a?(Hash) && interpreter.memory[address][:name] == symbol
        return address
      end
    end
    raise "Undefined symbol: #{symbol}"
  end
end
