require_relative '../instruction'
class LdaInstruction < Instruction
  def initialize(args, interpreter)
    super("LDA", args, interpreter)
  end

  def execute
    symbol = args.first
    data_address = find_symbol(symbol)
    interpreter.a = interpreter.memory[data_address][:value]
    if interpreter.describe_instruction
      puts describe(data_address, symbol)
    end
  end

  private
  def find_symbol(symbol)
    ALIInterpreter::DATA_MEMORY_START.upto(ALIInterpreter::MEMORY_SIZE - 1) do |address|
      if interpreter.memory[address].is_a?(Hash) && interpreter.memory[address][:name] == symbol
        return address
      end
    end
    raise "Undefined symbol: #{symbol}"
  end

  private

  def describe(data_address,symbol)
    "Loaded word at data memory address #{data_address} of symbol '#{symbol}' into the accumulator. So now, @A=#{symbol}"
  end
end
