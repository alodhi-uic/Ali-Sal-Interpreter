# # lib/method_impl.rb
# class MethodImpl
#   def initialize(interpreter)
#     @interpreter = interpreter
#   end
#
#   # Declare a variable in data memory
#   def dec(symbol)
#     data_address = find_available_data_address
#     @interpreter.memory[data_address] = { name: symbol, value: 0 }
#   end
#
#   # Load the value of a variable into register A
#   def lda(symbol)
#     data_address = find_symbol(symbol)
#     @interpreter.a = @interpreter.memory[data_address][:value]
#   end
#
#   # Load an immediate value into register A
#   def ldi(value)
#     if value.between?(@interpreter::MIN_16_BIT, @interpreter::MAX_16_BIT)
#       @interpreter.a = value
#     else
#       raise "Value out of range for 16-bit integer."
#     end
#   end
#
#   # Store the value in register A into a memory location (symbol)
#   def str(symbol)
#     data_address = find_symbol(symbol)
#     @interpreter.memory[data_address][:value] = @interpreter.a
#   end
#
#   # Exchange the contents of registers A and B
#   def xch
#     @interpreter.a, @interpreter.b = @interpreter.b, @interpreter.a
#   end
#
#   # Jump to a specific instruction in program memory
#   def jmp(address)
#     if address.between?(0, @interpreter::PROGRAM_MEMORY_SIZE - 1)
#       @interpreter.pc = address - 1 # -1 because pc will increment after instruction
#     else
#       raise "Jump address out of bounds."
#     end
#   end
#
#   # Jump if zero_bit is set
#   def jzs(address)
#     if @interpreter.zero_bit
#       jmp(address)
#     end
#   end
#
#   # Halt the program
#   def hlt
#     puts "Program halted."
#     exit(0)
#   end
#
#   # Add the contents of registers A and B
#   def add
#     result = @interpreter.a + @interpreter.b
#     if result.between?(@interpreter::MIN_16_BIT, @interpreter::MAX_16_BIT)
#       @interpreter.a = result
#       @interpreter.zero_bit = (@interpreter.a == 0)
#     else
#       raise "Overflow: result out of 16-bit range."
#     end
#   end
#
#   # Subtract the contents of register B from A
#   def sub
#     result = @interpreter.a - @interpreter.b
#     if result.between?(@interpreter::MIN_16_BIT, @interpreter::MAX_16_BIT)
#       @interpreter.a = result
#       @interpreter.zero_bit = (@interpreter.a == 0)
#     else
#       raise "Overflow: result out of 16-bit range."
#     end
#   end
#
#   # Print the state of the registers, zero bit, and memory
#   def print_state
#     puts "PC: #{@interpreter.pc}"
#     puts "Register A: #{@interpreter.a}"
#     puts "Register B: #{@interpreter.b}"
#     puts "Zero bit: #{@interpreter.zero_bit}"
#   end
#
#   private
#
#   # Find an available location in data memory to store a declared variable
#   def find_available_data_address
#     @interpreter::DATA_MEMORY_START.upto(@interpreter::MEMORY_SIZE - 1) do |address|
#       return address if @interpreter.memory[address] == 0
#     end
#     raise "No available memory for data."
#   end
#
#   # Find the memory address of a declared variable (symbol)
#   def find_symbol(symbol)
#     @interpreter::DATA_MEMORY_START.upto(@interpreter::MEMORY_SIZE - 1) do |address|
#       if @interpreter.memory[address].is_a?(Hash) && @interpreter.memory[address][:name] == symbol
#         return address
#       end
#     end
#     raise "Undefined symbol: #{symbol}"
#   end
# end
