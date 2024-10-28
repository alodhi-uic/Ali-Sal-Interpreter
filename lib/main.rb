require_relative 'ali_interpreter'

interpreter = ALIInterpreter.new
puts "Enter the file name of the SAL program: "
file_name = gets.chomp
# file_name = "lib/input/ugo.sal"
interpreter.load_program(file_name)
interpreter.command_loop


# File name input format: lib/input/program.sal