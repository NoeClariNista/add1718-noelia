#!/usr/bin/ruby

num1 = ARGV[0].to_i
op = ARGV[1]
num2 = ARGV[2].to_i

if ARGV.size != 3 # revisar
  puts "Te Falta O Te Sobran Argumentos."
else
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
