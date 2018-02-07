#!/usr/bin/ruby

fichero = ARGV[0]

if ARGV.size != 1
  puts "Te Faltan O Te Sobran Argumentos."
else
  contenido = `cat #{fichero}`
  lineas = contenido.split("\n")
  lineas.each do |linea|
    campos = linea.split()
 	num1 = campos[0].to_i
    op = campos[1]
    num2 = campos[2].to_i
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
