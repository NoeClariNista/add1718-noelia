___

# **Acceso Remoto SSH.**

---

# **1. Introducción.**

Vamos a necesitar las siguientes 3 MVs para esta práctica.

* Un Servidor GNU/Linux OpenSUSE.
* Un Cliente GNU/Linux OpenSUSE.
* Un Cliente Windows 7.

___

# **2. Preparativos.**

## **2.1. Servidor SSH.**

Configuramos el Servidor GNU/Linux con siguientes valores.

* SO GNU/Linux: OpenSUSE.
* IP estática: 172.18.20.31.
* Nombre de equipo: ssh-server20.

![imagen01](./images/a3_acceso_remoto_con_ssh/01.png)

![imagen02](./images/a3_acceso_remoto_con_ssh/02.png)

Añadimos en `/etc/hosts` los equipos ssh-client20a y ssh-client20b.

![imagen03](./images/a3_acceso_remoto_con_ssh/03.png)

![imagen04](./images/a3_acceso_remoto_con_ssh/04.png)

Para comprobar los cambios ejecutamos varios comandos.

~~~
ip a, comprobamos la IP y la máscara.
route -n, comprobamos la puerta de enlace.
ping 8.8.4.4 -i 2, comprobamos la conectividad externa.
host www.google.es, comprobamos el servidor DNS.
ping ssh-client20a, comprobamos la conectividad con el cliente A.
ping ssh-client20b, comprobamos la conectividad con el cliente B.
lsblk, consultamos las particiones.
blkid, consultamos UUID de la instalación.
~~~

![imagen05](./images/a3_acceso_remoto_con_ssh/05.png)

Creamos los siguientes usuarios en ssh-server20.

* hernandez1.
* hernandez2.
* hernandez3.
* hernandez4.

![imagen06](./images/a3_acceso_remoto_con_ssh/06.png)

Comprobamos haciendo ping a ambos equipos.

![imagen07](./images/a3_acceso_remoto_con_ssh/07.png)

## **2.2. Cliente GNU/Linux.**

Configuramos el Cliente GNU/Linux con los siguientes valores.

* SO GNU/Linux: OpenSUSE.
* IP estática: 172.18.20.32.
* Nombre de equipo: ssh-client20a.

![imagen08](./images/a3_acceso_remoto_con_ssh/08.png)

![imagen09](./images/a3_acceso_remoto_con_ssh/09.png)

Añadimos en `/etc/hosts` los equipos ssh-server20 y ssh-client20b.

![imagen10](./images/a3_acceso_remoto_con_ssh/10.png)

![imagen11](./images/a3_acceso_remoto_con_ssh/11.png)

Comprobamos haciendo ping a ambos equipos.

![imagen12](./images/a3_acceso_remoto_con_ssh/12.png)

## **2.3 Cliente Windows.**

Instalamos el software Cliente SSH en Windows. Para este ejemplo usaremos PuTTY.

Vamos a la página web de [Putty](http://www.putty.org/)

![imagen13](./images/a3_acceso_remoto_con_ssh/13.png)

Nos descargamos la versión para Windows.

![imagen14](./images/a3_acceso_remoto_con_ssh/14.png)

Empezamos a instalar PuTTY siguiendo las siguientes imágenes.

![imagen15](./images/a3_acceso_remoto_con_ssh/15.png)

![imagen16](./images/a3_acceso_remoto_con_ssh/16.png)

![imagen17](./images/a3_acceso_remoto_con_ssh/17.png)

![imagen18](./images/a3_acceso_remoto_con_ssh/18.png)

Configuramos el Cliente Windows con los siguientes valores.

* SO Windows: Windows 7.
* IP estática: 172.18.20.11.
* Nombre de equipo: ssh-client20b.

![imagen19](./images/a3_acceso_remoto_con_ssh/19.png)

![imagen20](./images/a3_acceso_remoto_con_ssh/20.png)

Añadimos en `C:\Windows\System32\drivers\etc\hosts` los equipos ssh-server20 y ssh-client20a.

![imagen21](./images/a3_acceso_remoto_con_ssh/21.png)

Comprobamos haciendo ping a ambos equipos.

![imagen22](./images/a3_acceso_remoto_con_ssh/22.png)

---

# **3. Instalación Del Servicio SSH.**

Instalamos el servicio SSH en la máquina ssh-server.

Para ello vamos a a la terminal y ponemos el comando zypper search openssh y nos mostrara los paquetes instalados o los paquetes que no están instalados con nombre openssh*.

![imagen23](./images/a3_acceso_remoto_con_ssh/23.png)

Ahora utilizamos el comando zypper install openssh y nos instalara el paquete OpenSSH.

![imagen24](./images/a3_acceso_remoto_con_ssh/24.png)

## **3.1 Comprobación.**

Desde el propio ssh-server tenemos que verificar que el servicio está en ejecución. Para ello utilizamos el comando systemctl status sshd.

![imagen25](./images/a3_acceso_remoto_con_ssh/25.png)

Utilizamos el comando ps -ef | grep sshd para mirar los procesos del sistema.

![imagen26](./images/a3_acceso_remoto_con_ssh/26.png)

Ahora utilizamos el comando netstat -ntap para comprobar que el servicio está escuchando por el puerto 22.

![imagen27](./images/a3_acceso_remoto_con_ssh/27.png)

## **3.2. Primera Conexión SSH Desde ssh-client20a.**

Comprobamos la conectividad con el Servidor desde el Cliente con un ping ssh-server.

![imagen28](./images/a3_acceso_remoto_con_ssh/28.png)

Desde el Cliente comprobamos que el servicio SSH es visible con el comando nmap ssh-server, al utilizar este comando nos debe mostrar que el puerto 22 está abierto. Antes de realizar esto tenemos que instalar el nmap en el Cliente20a.

![imagen29](./images/a3_acceso_remoto_con_ssh/29.png)

![imagen30](./images/a3_acceso_remoto_con_ssh/30.png)

Vamos a comprobar el funcionamiento de la conexión SSH desde cada cliente usando el usuario hernandez1.

Desde el ssh-client20a nos conectamos mediante ssh hernandez1@ssh-server.

![imagen31](./images/a3_acceso_remoto_con_ssh/31.png)

Desde el ssh-client20b nos conectamos mediante el Putty.

![imagen32](./images/a3_acceso_remoto_con_ssh/32.png)

Si nos volvemos a conectar tendremos lo siguiente.

![imagen33](./images/a3_acceso_remoto_con_ssh/33.png)

![imagen34](./images/a3_acceso_remoto_con_ssh/34.png)

Comprobamos el contenido del fichero `$HOME/.ssh/known_hosts` en el equipo ssh-client20a.

![imagen35](./images/a3_acceso_remoto_con_ssh/35.png)

Lo que nos aparece es la clave de identificación de la máquina ssh-server.

Ya llegados a este punto podemos ver que funcionan correctamente las conexiones SSH desde los dos clientes.

---

# **4. ¿Y Si Cambiamos Las Claves Del Servidor?.**

Confirmamos que existen los siguientes ficheros en `/etc/ssh`, los ficheros ssh_host_key y ssh_host_key.pub, los cuales son ficheros de clave pública/privada que identifican a nuestro Servidor frente a nuestros Clientes.

![imagen36](./images/a3_acceso_remoto_con_ssh/36.png)

Modificamos el fichero de configuración SSH, es decir, `/etc/ssh/sshd_config`, para dejar una única línea: HostKey `/etc/ssh/ssh_host_rsa_key`. Comentamos el resto de líneas con configuración HostKey. Este parámetro define los ficheros de clave publica/privada que van a identificar a nuestro Servidor. Con este cambio decimos que sólo vamos a usar las claves del tipo RSA.

![imagen37](./images/a3_acceso_remoto_con_ssh/37.png)

![imagen38](./images/a3_acceso_remoto_con_ssh/38.png)

## **4.1. Regenerar Certificados.**

Vamos a cambiar o volver a generar nuevas claves públicas/privadas para la identificación de nuestro Servidor.

En ssh-server, como usuario root ejecutamos el comando ssh-keygen -t rsa -f `/etc/ssh/ssh_host_rsa_key`. No ponemos password al certificado de la máquina.

![imagen39](./images/a3_acceso_remoto_con_ssh/39.png)

Reiniciamos el servicio SSH con el comando systemctl restart sshd y también comprobamos que el servicio está en ejecución correctamente con el comando systemctl status sshd.

![imagen40](./images/a3_acceso_remoto_con_ssh/40.png)

## **4.2. Comprobamos.**

Comprobamos qué sucede al volver a conectarnos desde los dos Clientes, usando los usuarios hernandez2 y hernandez1.

![imagen41](./images/a3_acceso_remoto_con_ssh/41.png)

![imagen42](./images/a3_acceso_remoto_con_ssh/42.png)

---

# **5. Personalización Del Prompt Bash.**

Podemos añadir las siguientes líneas al fichero de configuración del usuario1 en la máquina Servidor, al fichero `/home/hernandez1/.bashrc`.

![imagen43](./images/a3_acceso_remoto_con_ssh/43.png)

~~~
#Se cambia el prompt al conectarse vía SSH

if [ -n "$SSH_CLIENT" ]; then
   PS1="AccesoRemoto_\e[32m\u@\h:\e[0m \w\a\$ "
else
   PS1="\[$(pwd)\]\u@\h:\w>"
fi
~~~

![imagen44](./images/a3_acceso_remoto_con_ssh/44.png)

Además, creamos el fichero `/home/hernandez1/.alias` con el siguiente contenido.

![imagen45](./images/a3_acceso_remoto_con_ssh/45.png)

~~~
alias c='clear'
alias g='geany'
alias p='ping'
alias v='vdir -cFl'
alias s='ssh'
~~~

![imagen46](./images/a3_acceso_remoto_con_ssh/46.png)

Comprobamos el funcionamiento de la conexión SSH desde cada Cliente.

![imagen47](./images/a3_acceso_remoto_con_ssh/47.png)

![imagen48](./images/a3_acceso_remoto_con_ssh/48.png)

---

# **6. Autenticación Mediante Claves Públicas.**

El objetivo de este apartado es el de configurar SSH para poder acceder desde el Cliente20a, usando el hernandez4 sin poner password, pero usando claves pública/privada.

Para ello, vamos a configurar la autenticación mediante clave pública para acceder con nuestro usuario personal desde el equipo Cliente al Servidor con el usuario hernandez4.

Vamos a la máquina ss-client20a.

Iniciamos sesión con nuestro usuario noelia de la máquina ssh-client20a.

Ejecutamos ssh-keygen -t rsa para generar un nuevo par de claves para el usuario en `/home/nuestro-usuario/.ssh/id_rsa` y `/home/nuestro-usuario/.ssh/id_rsa.pub`.

![imagen49](./images/a3_acceso_remoto_con_ssh/49.png)

![imagen50](./images/a3_acceso_remoto_con_ssh/50.png)

Ahora vamos a copiar la clave pública, id_rsa.pub, del usuario noelia de la máquina Cliente, al fichero "authorized_keys" del usuario remoto hernandez4, el cual está definido en el Servidor.

Usamos el comando ssh-copy-id hernandez4@ssh-server20, para copiar la clave pública del usuario actual al usuario remoto en la máquina remota.

![imagen51](./images/a3_acceso_remoto_con_ssh/51.png)

Comprobamos accediendo remotamente vía SSH.

Desde ssh-client20a, no se pide password.

![imagen52](./images/a3_acceso_remoto_con_ssh/52.png)

Desde ssh-client20b, si se pide el password.

![imagen53](./images/a3_acceso_remoto_con_ssh/53.png)

![imagen54](./images/a3_acceso_remoto_con_ssh/54.png)

---

# **7. Uso De SSH Como Túnel Para X.**

Instalamos en el servidor una aplicación de entorno gráfico que no esté en los Clientes, por ejemplo, geany.

![imagen55](./images/a3_acceso_remoto_con_ssh/55.png)

![imagen56](./images/a3_acceso_remoto_con_ssh/56.png)

Modificamos servidor SSH para permitir la ejecución de aplicaciones gráficas, desde los Clientes. Consultamos el fichero de configuración `/etc/ssh/sshd_config`, opción X11Forwarding yes.

![imagen57](./images/a3_acceso_remoto_con_ssh/57.png)

![imagen58](./images/a3_acceso_remoto_con_ssh/58.png)

Vamos al ssh-client20a.

Comprobamos que no este instalada geany con el comando zypper se geany.

![imagen59](./images/a3_acceso_remoto_con_ssh/59.png)

Comprobamos desde el ssh-client20a, que funciona geany.

Con el comando ssh -X hernandez1@ssh-server20, podemos conectarnos de forma remota al servidor, y ahora ejecutamos geany de forma remota.

![imagen60](./images/a3_acceso_remoto_con_ssh/60.png)

![imagen61](./images/a3_acceso_remoto_con_ssh/61.png)

![imagen62](./images/a3_acceso_remoto_con_ssh/62.png)

---

# **8. Aplicaciones Windows Nativas.**

Podemos tener aplicaciones Windows nativas instaladas en ssh-server20 mediante el emulador WINE.

Instalamos el emulador Wine en el ssh-server20.

![imagen63](./images/a3_acceso_remoto_con_ssh/63.png)

Ahora podríamos instalar alguna aplicación de Windows en el servidor SSH usando el emulador Wine, en mi caso voy a usar el Block de Notas que viene con Wine, wine notepad.

![imagen64](./images/a3_acceso_remoto_con_ssh/64.png)

![imagen65](./images/a3_acceso_remoto_con_ssh/65.png)

Comprobamos el funcionamiento de notepad en ssh-server20.

![imagen66](./images/a3_acceso_remoto_con_ssh/66.png)

Comprobamos funcionamiento de wine notepad, accediendo desde ssh-client20a.

![imagen67](./images/a3_acceso_remoto_con_ssh/67.png)

![imagen68](./images/a3_acceso_remoto_con_ssh/68.png)

___

# **9. Restricciones De Uso.**

Vamos a modificar los usuarios del Servidor SSH para añadir algunas restricciones de uso del servicio.

## **9.1. Restricción Sobre Un Usuario.**

Vamos a crear una restricción de uso del SSH para un usuario.

En el servidor tenemos el usuario hernandez2. Desde local en el Servidor podemos usar sin problemas el usuario.

Vamos a modificar SSH de modo que al usar el usuario por ssh desde los clientes tendremos permiso denegado.

Consultamos o modificamos el fichero de configuración del servidor SSH, `/etc/ssh/sshd_config`, para restringir el acceso a determinados usuarios.

![imagen69](./images/a3_acceso_remoto_con_ssh/69.png)

![imagen70](./images/a3_acceso_remoto_con_ssh/70.png)

Consultamos las opciones AllowUsers, DenyUsers, para ello vamos a la terminal y ponemos el comando man sshd_config y buscamos AllowUsers y DenyUsers.

![imagen71](./images/a3_acceso_remoto_con_ssh/71.png)

![imagen72](./images/a3_acceso_remoto_con_ssh/72.png)

Comprobamos la restricción al acceder desde los Clientes.

![imagen73](./images/a3_acceso_remoto_con_ssh/73.png)

![imagen74](./images/a3_acceso_remoto_con_ssh/74.png)

## **9.2. Restricción Sobre Una Aplicación.**

Vamos a crear una restricción de permisos sobre determinadas aplicaciones.

Creamos un grupo remoteapps e incluimos al usuario hernandez4 en el grupo remoteapps.

![imagen75](./images/a3_acceso_remoto_con_ssh/75.png)

Localizamos el programa geany. El cual tiene los permisos 755.

![imagen76](./images/a3_acceso_remoto_con_ssh/76.png)

Ponemos al programa geany el grupo propietario a remoteapps.

![imagen77](./images/a3_acceso_remoto_con_ssh/77.png)

Ponemos los permisos del ejecutable de geany a 750. Esto es para poder impedir que los usuarios que no pertenezcan al grupo puedan ejecutar el programa.

![imagen78](./images/a3_acceso_remoto_con_ssh/78.png)

Comprobamos el funcionamiento en el Servidor.

![imagen79](./images/a3_acceso_remoto_con_ssh/79.png)

Comprobamos el funcionamiento desde el Cliente.

![imagen80](./images/a3_acceso_remoto_con_ssh/80.png)

---
