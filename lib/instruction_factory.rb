require_relative 'instruction'
require_relative 'instructions/add_instruction'
require_relative 'instructions/sub_instruction'
require_relative 'instructions/lda_instruction'
require_relative 'instructions/ldi_instruction'
require_relative 'instructions/str_instruction'
require_relative 'instructions/jmp_instruction'
require_relative 'instructions/jzs_instruction'
require_relative 'instructions/hlt_instruction'
require_relative 'instructions/dec_instruction'
require_relative 'instructions/xch_instruction'
require_relative 'instructions/print_instruction'
class InstructionFactory
  COMMAND_MAP = {
    "DEC" => DecInstruction,
    "LDA" => LdaInstruction,
    "LDI" => LdiInstruction,
    "STR" => StrInstruction,
    "XCH" => XchInstruction,
    "JMP" => JmpInstruction,
    "JZS" => JzsInstruction,
    "ADD" => AddInstruction,
    "SUB" => SubInstruction,
    "HLT" => HltInstruction,
    "PS" => PrintInstruction
  }

  def self.create_instruction(command, args, interpreter)
    instruction_class = COMMAND_MAP[command]
    return nil unless instruction_class
    instruction_class.new(args, interpreter)
  end
end
