require "pry"
require 'fileutils'

class Subtitle


  def self.convert_subtitle_file_to_text(file)

    file_name = file.path.split("/").last.split(".").first
    output_contents = ""

    file.each_line do |line|
      first_letter = line[0]
      next if !!(first_letter =~ /\A[-+]?[0-9]+\z/) || first_letter == "0"
      next if line == "\r\n"
      binding.pry
      output_contents += line
    end
    output_file = File.new(file_name + ".txt", "w:UTF-16LE")
    output_file.puts(output_contents)
    output_file.close
    output_file
  end

  def self.get_new_file_name(file)
    file.path.split("/").last.split(".").first + ".txt"
  end


end

binding.pry