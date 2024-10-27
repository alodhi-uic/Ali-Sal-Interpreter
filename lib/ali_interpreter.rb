require_relative 'instruction_factory'

class ALIInterpreter
  MEMORY_SIZE = 256
  PROGRAM_MEMORY_SIZE = 128
  DATA_MEMORY_START = 128
  MAX_16_BIT = 32_767
  MIN_16_BIT = -32_768

  attr_accessor :memory, :pc, :a, :b, :zero_bit

  def initialize
    @memory = Array.new(MEMORY_SIZE, 0)
    @pc = 0
    @a = 0
    @b = 0
    @zero_bit = false
    # @method_impl = MethodImpl.new(self)
  end

  def load_program(file_name)
    begin
      instructions = File.readlines(file_name).map(&:chomp)
      instructions.each_with_index do |instruction, index|
        raise "Program exceeds memory limits." if index >= PROGRAM_MEMORY_SIZE
        @memory[index] = instruction
      end
      puts "Program loaded successfully."
    rescue Errno::ENOENT
      puts "File not found: #{file_name}"
      exit
    rescue => e
      puts "An error occurred while loading the program: #{e.message}"
      exit
    end
  end

  def command_loop
    loop do
      puts "Enter command (s: step, a: all, q: quit): "
      command = gets.chomp

      case command
      when 's'
        execute_single_step
      when 'a'
        execute_all
      when 'q'
        puts "Exiting ALI interpreter."
        break
      else
        puts "Invalid command. Please enter 's', 'a', or 'q'."
      end
    end
  end

  def execute_single_step
    if @pc < PROGRAM_MEMORY_SIZE
      execute_instruction(@memory[@pc])
      @pc += 1
      # print_state
    else
      puts "No more instructions to execute."
    end
  end

  def execute_all
    instruction_count = 0
    max_instructions = 1000

    while @pc < PROGRAM_MEMORY_SIZE
      execute_instruction(@memory[@pc])
      @pc += 1
      instruction_count += 1

      if instruction_count >= max_instructions
        puts "Instruction limit reached. Continue execution? (y/n)"
        break if gets.chomp.downcase != 'y'
        instruction_count = 0
      end

      break if @memory[@pc - 1].start_with?('HLT')
    end
    print_state
  end

  def execute_instruction(instruction)
    command, *args = instruction.split
    instruction_instance = InstructionFactory.create_instruction(command, args, self)
    raise "Unknown instruction: #{command}" unless instruction_instance
    instruction_instance.execute
  end

  # def dec(symbol)
  #   data_address = find_available_data_address
  #   @memory[data_address] = { name: symbol, value: 0 }
  # end
  #
  # def find_available_data_address
  #   DATA_MEMORY_START.upto(MEMORY_SIZE - 1) do |address|
  #     return address if @memory[address] == 0
  #   end
  #   raise "No available memory for data."
  # end
  # def ldi(value)
  #   if value.between?(MIN_16_BIT, MAX_16_BIT)
  #     @a = value
  #   else
  #     raise "Value out of range for 16-bit integer."
  #   end
  # end

  def print_state
    puts "PC: #{@pc}"
    puts "Register A: #{@a}"
    puts "Register B: #{@b}"
    puts "Zero bit: #{@zero_bit}"
  end



  # Load an immediate value into register A
  def ldi(value)
    if value.between?(MIN_16_BIT, MAX_16_BIT)
      @a = value
    else
      raise "Value out of range for 16-bit integer."
    end
  end

  # Add the contents of registers A and B
  def add
    result = @a + @b
    if result.between?(MIN_16_BIT, MAX_16_BIT)
      @a = result
      @zero_bit = (@a == 0)
    else
      raise "Overflow: result out of 16-bit range."
    end
  end

  # Subtract the contents of register B from A
  def sub
    result = @a - @b
    if result.between?(MIN_16_BIT, MAX_16_BIT)
      @a = result
      @zero_bit = (@a == 0)
    else
      raise "Overflow: result out of 16-bit range."
    end
  end

  # Halt the program
  def hlt
    print_state
    puts "Program halted."
    exit(0)
  end

  # Additional methods for the other instructions should be defined here...

  # Example for DEC instruction
  def dec(symbol)
    data_address = find_available_data_address
    @memory[data_address] = { name: symbol, value: 0 }
  end

  # Additional instruction methods (e.g., LDA, STR, XCH, JMP, JZS) should be added here...

  # Find an available location in data memory to store a declared variable
  def find_available_data_address
    DATA_MEMORY_START.upto(MEMORY_SIZE - 1) do |address|
      return address if @memory[address] == 0
    end
    raise "No available memory for data."
  end

  # Find the memory address of a declared variable (symbol)
  def find_symbol(symbol)
    DATA_MEMORY_START.upto(MEMORY_SIZE - 1) do |address|
      if @memory[address].is_a?(Hash) && @memory[address][:name] == symbol
        return address
      end
    end
    raise "Undefined symbol: #{symbol}"
  end

  def str(symbol)
    data_address = find_symbol(symbol)
    @memory[data_address][:value] = @a
  end
  # Load the value of a variable into register A
  def lda(symbol)
    data_address = find_symbol(symbol)
    @a = @memory[data_address][:value]
  end
  # Exchange the contents of registers A and B
  def xch
    @a, @b = @b, @a
  end






end
