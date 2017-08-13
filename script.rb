require "pry"
require 'fileutils'

class SubtitleFormatter
  attr_accessor :file_paths

  def initialize
    get_files
    process_files
  end


  def get_files
    @file_paths = Dir["input/*/*"]
  end

  def process_files
    @file_paths.each do |file_path|
      convert_subtitle_file_to_text(file_path)
    end 
  end


  def convert_subtitle_file_to_text(file_path)
    original_file = File.open(file_path)
    file_name = file_path.split("/").last.split(".").first
    file_name += "-script.txt"

    output_contents = ""

    original_file.each_line do |line|
      first_letter = line[0]
      next if !!(first_letter =~ /\A[-+]?[0-9]+\z/) || first_letter == "0"
      next if line == "\r\n"
      output_contents += line
    end
    new_folder_path = file_path.split("/")[1] + "/"
    full_dir_path = "output/" + new_folder_path
    Dir.mkdir(full_dir_path) unless File.directory?(full_dir_path)
    output_file = File.new(full_dir_path + file_name, "w:UTF-8")
    output_file.puts(output_contents)
    output_file.close
    output_file
  end

end

SubtitleFormatter.new
