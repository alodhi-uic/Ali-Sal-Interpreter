require_relative '../instruction'
require_relative '../trash/method_impl'
class DecInstruction < Instruction
  def initialize(args, interpreter)
    super("DEC", args, interpreter)
  end

  def execute
    symbol = args.first
    data_address = find_available_data_address
    @interpreter.memory[data_address] = { name: symbol, value: 0 }
    if interpreter.describe_instruction
      puts describe(symbol,data_address)
      end
  end

  private
  def find_available_data_address
    interpreter.memory[ALIInterpreter::DATA_MEMORY_START..-1].each_with_index do |cell, index|
      address = ALIInterpreter::DATA_MEMORY_START + index
      return address if interpreter.memory[address] == 0
    end
    raise "No available memory for data."
  end

  def describe(symbol,data_address)
    "Stored symbol '#{symbol}' at memory address #{data_address}."
  end
end
