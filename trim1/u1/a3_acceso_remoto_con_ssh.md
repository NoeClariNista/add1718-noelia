___

# **Acceso Remoto SSH.**

---

![imagen](./images/.png)

# **1. Introducción.**

Vamos a necesitar las siguientes 3 MVs para esta práctica:

* Un servidor GNU/Linux OpenSUSE.
* Un cliente GNU/Linux OpenSUSE.
* Un cliente Windows 7.

___

# **2. Preparativos.**

## **2.1. Servidor SSH.**

Configuramos el servidor GNU/Linux con siguientes valores.

* SO GNU/Linux: OpenSUSE.
* IP estática: 172.18.20.31.
* Nombre de equipo: ssh-server20.

![imagen01](./images/01.png)

![imagen02](./images/02.png)

Añadimos en /etc/hosts los equipos ssh-client20a y ssh-client20b.

![imagen03](./images/03.png)

![imagen04](./images/04.png)

Para comprobar los cambios ejecutamos varios comandos.

~~~

ip a, comprobamos la IP y la máscara.
route -n, comprobamos la puerta de enlace.
ping 8.8.4.4 -i 2, comprobamos la conectividad externa.
host www.google.es, comprobamos el servidor DNS.
ping ssh-client20a, comprobamos la conectividad con el cliente A.
ping ssh-client20b, comprobamos conectividad con el cliente B.
lsblk, consultamos las particiones.
blkid, consultamos UUID de la instalación.

~~~

![imagen05](./images/05.png)

![imagen06](./images/06.png)

![imagen07](./images/07.png)

Creamos los siguientes usuarios en ssh-server20.

* hernandez1.
* hernandez2.
* hernandez3.
* hernandez4.

![imagen08](./images/08.png)

## **2.2. Cliente GNU/Linux.**

Configuramos el cliente1 GNU/Linux con los siguientes valores.

* SO OpenSUSE.
* IP estática 172.18.20.32.
* Nombre de equipo: ssh-client20a.

![imagen09](./images/09.png)

![imagen10](./images/10.png)

Añadimos en /etc/hosts el equipo ssh-server20, y ssh-client20b.

![imagen11](./images/11.png)

![imagen12](./images/12.png)

Comprobamos haciendo ping a ambos equipos.

![imagen13](./images/13.png)

![imagen14](./images/14.png)

## **2.3 Cliente Windows.**

Instalamos el software cliente SSH en Windows. Para este ejemplo usaremos PuTTY.

![imagen15](./images/15.png)

![imagen16](./images/16.png)

![imagen17](./images/17.png)

![imagen18](./images/18.png)

![imagen19](./images/19.png)

![imagen20](./images/20.png)

Configuramos el cliente2 Windows con los siguientes valores:

* SO Windows 7.
* IP estática 172.18.20.11.
* Nombre de equipo: ssh-client20b.

![imagen21](./images/21.png)

![imagen22](./images/22.png)

Añadimos en C:\Windows\System32\drivers\etc\hosts el equipo ssh-server20 y ssh-client20a.

![imagen23](./images/23.png)

Comprobamos haciendo ping a ambos equipos.

![imagen24](./images/24.png)

---

# **3. Instalación Del Servicio SSH.**

Instalamos el servicio SSH en la máquina ssh-server.

Desde terminal zypper search openssh muestra los paquetes instalados o no con nombre openssh*.

![imagen25](./images/25.png)

Desde terminal zypper install openssh, instala el paquete OpenSSH.

![imagen26](./images/26.png)

## **3.1 Comprobación.**

Desde el propio ssh-server, verificamos que el servicio está en ejecución. Para ello utilizamos el comando systemctl status sshd, esta es la forma de comprobarlo en systemd.

![imagen27](./images/27.png)

ps -ef|grep sshd, esta es la forma de comprobarlo mirando los procesos del sistema.

![imagen28](./images/28.png)

netstat -ntap: Comprobar que el servicio está escuchando por el puerto 22.

![imagen29](./images/29.png)

## **3.2. Primera Conexión SSH Desde ssh-client20a.**

Comprobamos la conectividad con el servidor desde el cliente con ping ssh-server.

![imagen30](./images/30.png)

Desde el cliente comprobamos que el servicio SSH es visible con nmap ssh-server. Debe mostrarnos que el puerto 22 está abierto. Primero instalamos el nmap.

![imagen31](./images/31.png)

![imagen32](./images/32.png)

Si esto falla debemos comprobar en el servidor la configuración del cortafuegos.

![imagen33](./images/33.png)

![imagen34](./images/34.png)

Vamos a comprobar el funcionamiento de la conexión SSH desde cada cliente usando el usuario hernandez1.


Desde el ssh-client1 nos conectamos mediante ssh hernandez1@ssh-server.

![imagen35](./images/35.png)

![imagen36](./images/36.png) > revisar la imagenes. mirar desde windows cliente.

Si nos volvemos a conectar tendremos.

![imagen37](./images/37.png)

Comprobamos contenido del fichero $HOME/.ssh/known_hosts en el equipo ssh-client1. OJO si el prompt pone ssh-server están el el servidor, y si pone ssh-client1 están el el cliente1.

![imagen38](./images/38.png)

¿Te suena la clave que aparece? Es la clave de identificación de la máquina ssh-server.

Una vez llegados a este punto deben de funcionar correctamente las conexiones SSH desde los dos clientes.

---

# **4. ¿Y Si Cambiamos Las Claves Del Servidor?.**

Confirmamos que existen los siguientes ficheros en /etc/ssh, Los ficheros ssh_host*key y ssh_host*key.pub, son ficheros de clave pública/privada que identifican a nuestro servidor frente a nuestros clientes:

![imagen39](./images/39.png)

Modificamos el fichero de configuración SSH (/etc/ssh/sshd_config) para dejar una única línea: HostKey /etc/ssh/ssh_host_rsa_key. Comentar el resto de líneas con configuración HostKey. Este parámetro define los ficheros de clave publica/privada que van a identificar a nuestro servidor. Con este cambio decimos que sólo vamos a usar las claves del tipo RSA.

![imagen40](./images/40.png)

![imagen41](./images/41.png)

## **4.1. Regenerar Certificados.**

Vamos a cambiar o volver a generar nuevas claves públicas/privadas para la identificación de nuestro servidor.

En ssh-server, como usuario root ejecutamos: ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key.

![imagen42](./images/42.png)

No ponemos password al certificado de la máquina.

Reiniciamos el servicio SSH: systemctl restart sshd.

Comprobamos que el servicio está en ejecución correctamente: systemctl status sshd.

![imagen43](./images/43.png)

## **4.2. Comprobamos.**

Comprobamos qué sucede al volver a conectarnos desde los dos clientes, usando los usuarios hernandez2 y hernandez1. ¿Qué sucede?

![imagen44](./images/44.png)

---

# **5. Personalización Del Prompt Bash.**

Podemos añadir las siguientes líneas al fichero de configuración del usuario1 en la máquina servidor (Fichero /home/hernandez1/.bashrc).

![imagen45](./images/45.png)

~~~
#Se cambia el prompt al conectarse vía SSH

if [ -n "$SSH_CLIENT" ]; then
   PS1="AccesoRemoto_\e[32m\u@\h:\e[0m \w\a\$ "
else
   PS1="\[$(pwd)\]\u@\h:\w>"
fi
~~~

![imagen46](./images/46.png)

Además, creamos el fichero /home/hernandez1/.alias con el siguiente contenido:

![imagen47](./images/47.png)

~~~
alias c='clear'
alias g='geany'
alias p='ping'
alias v='vdir -cFl'
alias s='ssh'
~~~

![imagen48](./images/48.png)

Comprobamos funcionamiento de la conexión SSH desde cada cliente.

![imagen49](./images/49.png)

![imagen50](./images/50.png)

---

# **6. Autenticación Mediante Claves Públicas.**

El objetivo de este apartado es el de configurar SSH para poder acceder desde el cliente1, usando el hernandez4 sin poner password, pero usando claves pública/privada.

Para ello, vamos a configurar la autenticación mediante clave pública para acceder con nuestro usuario personal desde el equipo cliente al servidor con el usuario 1er-apellido-alumno4.

Vamos a la máquina ss-client20a.

Iniciamos sesión con nuestro usuario nombre-alumno de la máquina ssh-client20a.

Ejecutamos ssh-keygen -t rsa para generar un nuevo par de claves para el usuario en /home/nuestro-usuario/.ssh/id_rsa y /home/nuestro-usuario/.ssh/id_rsa.pub.

![imagen51](./images/51.png)

![imagen52](./images/52.png)

Ahora vamos a copiar la clave pública (id_rsa.pub) del usuario (nombre-de-alumno) de la máquina cliente, al fichero "authorized_keys" del usuario remoto hernandez4 (que está definido en el servidor.

Usamos el comando ssh-copy-id. Ejemplo para copiar la clave pública del usuario actual al usuario remoto en la máquina remota: ssh-copy-id usuario-remoto@hostname-remoto.

![imagen53](./images/53.png)

Comprobar que ahora al acceder remotamente vía SSH
Desde ssh-clientXXa, NO se pide password.
Desde ssh-clientXXb, SI se pide el password.

![imagen54](./images/54.png)

![imagen55](./images/55.png)

![imagen56](./images/56.png)

---

# **7. Uso De SSH Como Túnel Para X.**

Instalamos en el servidor una aplicación de entorno gráfico (APP1) que no esté en los clientes. Por ejemplo Geany. Si estuviera en el cliente entonces buscar otra aplicación o desinstalarla en el cliente.

![imagen57](./images/57.png)

![imagen58](./images/58.png)

![imagen59](./images/59.png)

Modificamps servidor SSH para permitir la ejecución de aplicaciones gráficas, desde los clientes. Consultar fichero de configuración /etc/ssh/sshd_config (Opción X11Forwarding yes),

![imagen60](./images/60.png)

![imagen61](./images/61.png)

Vamos al cliente20a.

Comprobamos que no está instalada APP1: zypper se APP1.

![imagen62](./images/62.png)

Comprobamos desde el cliente20a, que funciona APP1(del servidor).

Con el comando ssh -X remoteuser1@ssh-server, podemos conectarnos de forma remota al servidor, y ahora ejecutamos APP1 de forma remota.

![imagen63](./images/63.png)

---

# **8. Aplicaciones Windows Nativas.**

Podemos tener aplicaciones Windows nativas instaladas en ssh-server mediante el emulador WINE.

Instalamos el emulador Wine en el ssh-server.

![imagen64](./images/64.png)

Ahora podríamos instalar alguna aplicación (APP2) de Windows en el servidor SSH usando el emulador Wine. O podemos usar el Block de Notas que viene con Wine: wine notepad.

![imagen65](./images/65.png)

![imagen66](./images/66.png)

Comprobamos el funcionamiento de APP2 en ssh-server.

![imagen67](./images/67.png)

Comprobamos funcionamiento de APP2, accediendo desde ssh-client1.

![imagen68](./images/68.png)

![imagen69](./images/69.png)

___

# **9. Restricciones De Uso.**

Vamos a modificar los usuarios del servidor SSH para añadir algunas restricciones de uso del servicio.
Restricción sobre un usuario

Vamos a crear una restricción de uso del SSH para un usuario:

En el servidor tenemos el usuario remoteuser2. Desde local en el servidor podemos usar sin problemas el usuario.

Vamos a modificar SSH de modo que al usar el usuario por ssh desde los clientes tendremos permiso denegado.

Capturar imagen de los siguientes pasos:

    Consultar/modificar fichero de configuración del servidor SSH (/etc/ssh/sshd_config) para restringir el acceso a determinados usuarios. Consultar las opciones AllowUsers, DenyUsers. Más información en: man sshd_config y en el Anexo de este enunciado.
    Comprobarlo la restricción al acceder desde los clientes.

Restricción sobre una aplicación

Vamos a crear una restricción de permisos sobre determinadas aplicaciones.

    Crear grupo remoteapps
    Incluir al usuario remoteuser4 en el grupo remoteapps.
    Localizar el programa APP1. Posiblemente tenga permisos 755.
    Poner al programa APP1 el grupo propietario a remoteapps.
    Poner los permisos del ejecutable de APP1 a 750. Para impedir que los usurios que no pertenezcan al grupo puedan ejecutar el programa.
    Comprobamos el funcionamiento en el servidor.
    Comprobamos el funcionamiento desde el cliente.

---
