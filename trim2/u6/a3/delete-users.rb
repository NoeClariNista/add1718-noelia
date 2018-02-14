#!/usr/bin/ruby

if ARGV.size != 1
  puts "Te Faltan o Te Sobran Argumentos."
  exit
end

filename = ARGV[0]
filecontent = `cat #{filename}`
lines = filecontent.split("\n")
lines.each do |user|
  if system("id #{user} &> /dev/null") == true
    system("userdel -rf #{user} &> /dev/null")
    puts("El Usuario #{user} Ha Sido Borrado.")
  else
    puts("El Usuario #{user} No Existe.")
  end
end
