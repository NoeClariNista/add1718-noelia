#!/usr/bin/ruby

if `whoami`.rstrip != "root"
  puts "Tienes Que Ser Root."
  exit
end

if ARGV.size != 1
  puts "Te Faltan o Te Sobran Argumentos."
  exit
end

filename = ARGV[0]

if not File.exists?(filename)
  puts "El Fichero #{filename} No Existe."
  exit
end

filecontent = `cat #{filename}`
lines = filecontent.split("\n")
lines.each do |users|
  user = users.split(":")
  if user[2] == ""
    puts "El Usuario #{user[0]} No Tiene Email."
    next
  end
  puts "El Usuario #{user[0]} Tiene Email."
  var = "2> /dev/null 1> /dev/null"
  if user[4] == "add"
    if system("id #{user[0]} #{var}") == true
      puts "El Usuario #{user[0]} Ya Existe."
    else
      system("useradd -m #{user[0]} #{var}")
      puts "El Usuario #{user[0]} Ha Sido Creado."
    end
  elsif user[4] == "delete"
    if system("id #{user[0]} #{var}") == true
      system("userdel -rf #{user[0]} #{var}")
      puts "El Usuario #{user[0]} Ha Sido Borrado."
    else
      puts "El Usuario #{user[0]} No Existe."
    end
  else
    puts "La Accion Del Usuario #{user[0]} Es Erronea."
  end
end
