#!/usr/bin/ruby

file = ARGV[0]

if ARGV.size != 1
  puts "Te Faltan O Te Sobran Argumentos."
else
  content = `cat #{file}`
  lines = content.split("\n")
  lines.each do |line|
    field = line.split()
 	num1 = field[0].to_i
    op = field[1]
    num2 = field[2].to_i
    if op == "+"
      puts "#{num1} #{op} #{num2} = #{num1 + num2}"
    elsif op == "-"
      puts "#{num1} #{op} #{num2} = #{num1 - num2}"
    elsif op == "x"
      puts "#{num1} #{op} #{num2} = #{num1 * num2}"  
    elsif op == "/"
      puts "#{num1} #{op} #{num2} = #{num1 / num2}"  
    else
      puts "ERROR."
    end
  end
end
.
