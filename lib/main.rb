# main.rb
require_relative 'ali_interpreter'

interpreter = ALIInterpreter.new
puts "Enter the file name of the SAL program: "
file_name = "lib/input/program.sal"
interpreter.load_program(file_name)
interpreter.command_loop


# lib/input/program.sal