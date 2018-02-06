#!/usr/bin/ruby

fichero = ARGV[0]

if ARGV.size < 3
  puts "Te falta algún valor en los argumentos."
else

end

contenido = `cat operaciones.txt`
lineas = contenido.split("\n")
lineas.each do |linea|
	campos = linea.split(" ")
