require_relative 'instruction_factory'

class ALIInterpreter
  MEMORY_SIZE = 256
  PROGRAM_MEMORY_SIZE = 128
  DATA_MEMORY_START = 128
  MAX_16_BIT = 32_767
  MIN_16_BIT = -32_768

  attr_accessor :memory, :pc, :a, :b, :zero_bit, :describe_instruction

  def initialize
    @pc = 0
    @a = 0
    @b = 0
    @zero_bit = false
    @describe_instruction = false
    @memory = Array.new(MEMORY_SIZE, 0)
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
      puts "Enter command (s: step-execution, a: execute-all, q: quit): "
      command = gets.chomp

      case command
      when 's'
        execute_single_step
      when 'a'
        execute_all
      when 'q'
        puts "Exiting ALI interpreter. Kinda hate Ruby. Bye Bye!!"
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
      break if @memory[@pc - 1].start_with?('HLT')
      if instruction_count >= max_instructions
        puts "Instruction limit reached. Continue execution? (y/n)"
        break if gets.chomp.downcase != 'y'
        instruction_count = 0
        # puts "insta:" + instruction_count.to_s
      end

      break if @memory[@pc - 1].start_with?('HLT')
    end
    print_state
  end

  def execute_instruction(instruction)
    @last_command = instruction
    command, *args = instruction.split
    instruction_instance = InstructionFactory.create_instruction(command, args, self)
    # Used Factory design pattern instead of Switch case to make it follow Seperation of concerns.
    # As explained by Prof Ugo in https://piazza.com/class/m014gwxce653wr/post/54
    # Now to incorporate any additional command we dont have to make changes to this file at all.

    raise "Unknown instruction: #{command}" unless instruction_instance
    instruction_instance.execute
  end

  def print_state
    puts "PC: #{@pc}"
    puts "Register A: #{@a}"
    puts "Register B: #{@b}"
    puts "Zero bit: #{@zero_bit}"
    puts "Last Command: #{@last_command}"
    puts "Memory:"
    @memory.each_with_index do |cell, index|
      if index < MEMORY_SIZE && cell != 0
        if index < PROGRAM_MEMORY_SIZE
          puts "[#{index}] Program Memory: #{cell}"
        else
          puts "[#{index}] Data Memory: #{cell}"
        end
      end
    end
  end

end
