___

# **Recursos SMB/CIFS (OpenSUSE).**

Samba con OpenSUSE y Windows 10.

---

# **1. Introducción.**

Vamos a necesitar las siguientes 3 MVs.

* MV1: Un Servidor GNU/Linux OpenSUSE con IP estática, 172.18.20.31.
* MV2: Un Cliente GNU/Linux OpenSUSE con IP estática, 172.18.20.32.
* MV3: Un Cliente Windows 10 con IP estática, 172.18.20.11.

---

# **2. Servidor Samba (MV1).**

## **2.1. Preparativos.**

Configuramos el Servidor GNU/Linux. Usamos los siguientes valores.

* Nombre de equipo: smb-server20.
* Añadimos en /etc/hosts los equipos smb-cli20a y smb-cli20b.

![imagen](./images/a1_recursos_smb_cifs_opensuse/01.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/02.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/03.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/04.png)

Capturamos la salida de los comandos siguientes en el Servidor.

~~~
hostname -f.
ip a.
lsblk.
sudo blkid.
~~~

![imagen](./images/a1_recursos_smb_cifs_opensuse/05.png)

---

## **2.2. Usuarios Locales.**

En este caso utilizare entorno gráfico Yast.

Vamos a GNU/Linux, y creamos los siguientes grupos y usuarios.

Creamos el usuario supersamba.

![imagen](./images/a1_recursos_smb_cifs_opensuse/06.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/07.png)

Creamos los usuarios pirata1, pirata2, luego creamos el grupo piratas y incluimos estos dos usuarios y también supersamba dentro del grupo.

![imagen](./images/a1_recursos_smb_cifs_opensuse/08.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/09.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/10.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/11.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/12.png)

Creamos los usuarios soldado1 y soldado2, luego creamos el grupo soldados y incluimos estos dos usuarios y también supersamba dentro del grupo.

![imagen](./images/a1_recursos_smb_cifs_opensuse/13.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/14.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/15.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/16.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/17.png)

Creamos el usuario smbguest. Para asegurarnos que nadie puede usar smbguest para entrar en nuestra máquina mediante login, vamos a modificar este usuario y le ponemos como shell /bin/false.

![imagen](./images/a1_recursos_smb_cifs_opensuse/18.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/19.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/20.png)

Creamos el grupo todos y dentro de este grupo ponemos a todos los usuarios soldados, pitatas, supersamba y a smbguest.

![imagen](./images/a1_recursos_smb_cifs_opensuse/21.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/22.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/23.png)

## **2.3. Crear Las Carpetas Para Los Futuros Recursos Compartidos.**

Vamos a crear las carpetas de los recursos compartidos con los permisos siguientes.

![imagen](./images/a1_recursos_smb_cifs_opensuse/24.png)

* /srv/samba20/public.d
 Usuario propietario supersamba.
 Grupo propietario todos.
 Poner permisos 775.

 ![imagen](./images/a1_recursos_smb_cifs_opensuse/25.png)

 ![imagen](./images/a1_recursos_smb_cifs_opensuse/26.png)

* /srv/samba20/castillo.d
  Usuario propietario supersamba.
  Grupo propietario soldados.
  Poner permisos 770.

  ![imagen](./images/a1_recursos_smb_cifs_opensuse/27.png)

* /srv/samba20/barco.d
  Usuario propietario supersamba.
  Grupo propietario piratas.
  Poner permisos 770.

  ![imagen](./images/a1_recursos_smb_cifs_opensuse/28.png)

## **2.4. Instalar Samba Server.**

Vamos a hacer una copia de seguridad del fichero de configuración existente cp /etc/samba/smb.conf /etc/samba/smb.conf.000.

![imagen](./images/a1_recursos_smb_cifs_opensuse/29.png)

Podemos usar comandos o el entorno gráfico para instalar y configurar el servicio Samba. Como estamos en OpenSUSE vamos a usar Yast.

    Yast -> Samba Server
        Workgroup: mar1718
        Sin controlador de dominio.

![imagen](./images/a1_recursos_smb_cifs_opensuse/30.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/31.png)


    En la pestaña de Inicio definimos
        Iniciar el servicio durante el arranque de la máquina.
        Ajustes del cortafuegos -> Abrir puertos

![imagen](./images/a1_recursos_smb_cifs_opensuse/32.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/33.png)


## **2.5. Configurar El Servidor Samba.**

Vamos a configurar los recursos compartido del servidor Samba. Podemos hacerlo modificando el fichero de configuración o por entorno gráfico con Yast. Para ellos vamos a Yast -> Samba Server -> Recursos Compartidos.

![imagen](.images/a1_recursos_smb_cifs_opensuse/34.png)

~~~
[global]
  netbios name = smb-serverXX
  workgroup = mar1617
  server string = Servidor de nombre-alumno-XX
  security = user
  map to guest = bad user
  guest account = smbguest

[cdrom]
  path = /dev/cdrom
  guest ok = yes
  read only = yes

[public]
  comment = public de nombre-alumno-XX
  path = /srv/sambaXX/public.d
  guest ok = yes
  read only = yes

[castillo]
  comment = castillo de nombre-alumno-XX
  path = /srv/sambaXX/castillo.d
  read only = no
  valid users = @soldados

[barco]
  comment = barco de nombre-alumno-XX
  path = /srv/sambaXX/barco.d
  read only = no
  valid users = pirata1, pirata2
~~~

![imagen](.images/a1_recursos_smb_cifs_opensuse/35.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/36.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/37.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/38.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/39.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/40.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/41.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/42.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/43.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/44.png)

Abrimos una consola para comprobar los resultados.

* cat /etc/samba/smb.conf

* testparm

![imagen](.images/a1_recursos_smb_cifs_opensuse/45.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/46.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/47.png)


## **2.6. Usuarios Samba.**

Después de crear los usuarios en el sistema, hay que añadirlos a Samba.

    smbpasswd -a nombreusuario, para crear clave de Samba para un usuario del sistema.

![imagen](.images/a1_recursos_smb_cifs_opensuse/48.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/49.png)

    pdbedit -L, para comprobar la lista de usuarios Samba.

![imagen](.images/a1_recursos_smb_cifs_opensuse/50.png)

## **2.7. Reiniciar.**

Ahora que hemos terminado con el servidor, hay que reiniciar el servicio para que se lean los cambios de configuración.

Usamos los comandos.
        Servicio smb
            systemctl stop smb
            systemctl start smb
            systemctl status smb

![imagen](.images/a1_recursos_smb_cifs_opensuse/51.png)

        Servicio nmb
            systemctl stop nmb
            systemctl start nmb
            systemctl status nmb

![imagen](.images/a1_recursos_smb_cifs_opensuse/52.png)


    Capturar imagen de los siguientes comando de comprobación:

    sudo testparm     # Verifica la sintaxis del fichero de configuración del servidor Samba

![imagen](.images/a1_recursos_smb_cifs_opensuse/53.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/54.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/55.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/56.png)

    sudo netstat -tap # Vemos que el servicio SMB/CIF está a la escucha

![imagen](.images/a1_recursos_smb_cifs_opensuse/57.png)


    Comprobar CORTAFUEGOS

    Para descartar un problema con el cortafuegos del servidor Samba. Probamos el comando nmap -Pn smb-serverXX desde la máquina real, u otra máquina GNU/Linux. Deberían verse los puertos SMB/CIFS(139 y 445) abiertos.

![imagen](.images/a1_recursos_smb_cifs_opensuse/58.png)

---

# **3. Windows (MV3 smb-cli20b).**

Configurar el cliente Windows.

![imagen](.images/a1_recursos_smb_cifs_opensuse/59.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/60.png)

Usar nombre smb-cli20b y la IP que hemos establecido.
C:\Windows\System32\drivers\etc\hosts
Configurar el fichero ...\etc\hosts de Windows.

![imagen](.images/a1_recursos_smb_cifs_opensuse/61.png)

En los clientes Windows el software necesario viene preinstalado.

## **3.1. Cliente Windows GUI.**

Desde un cliente Windows vamos a acceder a los recursos compartidos del servidor Samba.

samba-win7-cliente-gui

![imagen](.images/a1_recursos_smb_cifs_opensuse/62.png)

Comprobar los accesos de todas las formas posibles. Como si fuéramos:

* un soldado

![imagen](.images/a1_recursos_smb_cifs_opensuse/63.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/64.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/65.png)

* un pirata

![imagen](.images/a1_recursos_smb_cifs_opensuse/66.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/67.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/68.png)

* y/o un invitado.

![imagen](.images/a1_recursos_smb_cifs_opensuse/69.png)

Después de cada conexión se quedan guardada la información en el cliente Windows. net use * /d /y, para cerrar las conexión SMB/CIFS que se ha realizado desde el cliente al servidor.

![imagen](.images/a1_recursos_smb_cifs_opensuse/70.png)

Capturar imagen de los siguientes comandos para comprobar los resultados:

smbstatus, desde el servidor Samba.

![imagen](.images/a1_recursos_smb_cifs_opensuse/71.png)

netstat -ntap, desde el servidor Samba.

![imagen](.images/a1_recursos_smb_cifs_opensuse/72.png)

netstat -n, desde el cliente Windows.

![imagen](.images/a1_recursos_smb_cifs_opensuse/73.png)

## **3.2. Cliente Windows Comandos.**

En el cliente Windows, para consultar todas las conexiones/recursos conectados hacemos C:>net use.

![imagen](.images/a1_recursos_smb_cifs_opensuse/74.png)

Si hubiera alguna conexión abierta la cerramos.
        net use * /d /y, para cerrar las conexiones SMB.
        net use ahora vemos que NO hay conexiones establecidas.

![imagen](.images/a1_recursos_smb_cifs_opensuse/75.png)

Abrir una shell de windows. Usar el comando net use /?, para consultar la ayuda del comando.

![imagen](.images/a1_recursos_smb_cifs_opensuse/76.png)

Vamos a conectarnos desde la máquina Windows al servidor Samba usando el comando net.

![imagen](.images/a1_recursos_smb_cifs_opensuse/77.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/78.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/79.png)

Con el comando net view, vemos las máquinas (con recursos CIFS) accesibles por la red.

![imagen](.images/a1_recursos_smb_cifs_opensuse/80.png)

## **3.3. Montaje Automático.**

El comando net use S: \\ip-servidor-samba\recurso /USER:clave establece una conexión del rescurso panaderos y lo monta en la unidad S.

![imagen](.images/a1_recursos_smb_cifs_opensuse/81.png)

Ahora podemos entrar en la unidad S ("s:") y crear carpetas, etc.

Capturar imagen de los siguientes comandos para comprobar los resultados:
smbstatus, desde el servidor Samba.
netstat -ntap, desde el servidor Samba.
netstat -n, desde el cliente Windows.

![imagen](.images/a1_recursos_smb_cifs_opensuse/82.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/83.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/84.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/85.png)

~~~

2.2 Cliente Windows comandos

    En el cliente Windows, para consultar todas las conexiones/recursos conectados hacemos C:>net use.
    Si hubiera alguna conexión abierta la cerramos.
        net use * /d /y, para cerrar las conexiones SMB.
        net use ahora vemos que NO hay conexiones establecidas.

Capturar imagen de los comandos siguientes:

    Con el comando net view, vemos las máquinas (con recursos CIFS) accesibles por la red.
    Abrir una shell de windows. Usar el comando net use /?, para consultar la ayuda del comando.
    El comando net use S: \\ip-servidor-samba\recurso clave /USER:usuario /p:yes establece una conexión con el recurso compartido y lo monta en la unidad S. Probemos a montar el recurso barco.

    Con la opción /p:yes hacemos el montaje persistente. De modo que se mantiene en cada reinicio de mñaquina.

    net use, comprobamos.

    Ahora podemos entrar en la unidad S ("s:") y crear carpetas, etc.

    Capturar imagen de los siguientes comandos para comprobar los resultados:
        smbstatus, desde el servidor Samba.
        netstat -ntap, desde el servidor Samba.
        netstat -n, desde el cliente Windows.

~~~
---

# **4. Cliente GNU/Linux (MV2 smb-cli20a).**

Configurar el cliente GNU/Linux.
Usar nombre smb-cli20a y la IP que hemos establecido.
Configurar el fichero /etc/hosts de la máquina.

![imagen](.images/a1_recursos_smb_cifs_opensuse/86.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/87.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/88.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/89.png)


## **4.1. Cliente GNU/Linux GUI.**

Desde en entorno gráfico, podemos comprobar el acceso a recursos compartidos SMB/CIFS.

Estas son algunas herramientas:

Yast en OpenSUSE

Ejemplo accediendo al recurso prueba del servidor Samba, pulsamos CTRL+L y escribimos smb://ip-del-servidor-samba:

![imagen](.images/a1_recursos_smb_cifs_opensuse/90.png)

En el momento de autenticarse para acceder al recurso remoto, poner en Dominio el nombre-netbios-del-servidor-samba.

Capturar imagen de lo siguiente:

Probar a crear carpetas/archivos en castillo y en barco.

![imagen](.images/a1_recursos_smb_cifs_opensuse/91.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/92.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/93.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/94.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/95.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/96.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/97.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/98.png)


    Comprobar que el recurso public es de sólo lectura.

![imagen](.images/a1_recursos_smb_cifs_opensuse/99.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/100.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/101.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/102.png)

Capturar imagen de los siguientes comandos para comprobar los resultados:
smbstatus, desde el servidor Samba.
netstat -ntap, desde el servidor Samba.
netstat -n, desde el cliente.

![imagen](.images/a1_recursos_smb_cifs_opensuse/103.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/104.png)

![imagen](.images/a1_recursos_smb_cifs_opensuse/105.png)

## **4.2. Cliente GNU/Linux Comandos.**

Existen comandos (smbclient, mount , smbmount, etc.) para ayudarnos a acceder vía comandos al servidor Samba desde el cliente. Puede ser que con las nuevas actualizaciones y cambios de las distribuciones alguno haya cambiado de nombre. ¡Ya lo veremos!

Vamos a un equipo GNU/Linux que será nuestro cliente Samba. Desde este equipo usaremos comandos para acceder a la carpeta compartida.

Primero comprobar el uso de las siguientes herramientas:

sudo smbtree                       # Muestra todos los equipos/recursos de la red SMB/CIFS
                                   # Hay que abrir el cortafuegos para que funcione.
smbclient --list ip-servidor-samba # Muestra los recursos SMB/CIFS de un equipo concreto

Ahora crearemos en local la carpeta /mnt/sambaXX-remoto/corusant.
MONTAJE: Con el usuario root, usamos el siguiente comando para montar un recurso compartido de Samba Server, como si fuera una carpeta más de nuestro sistema: mount -t cifs //172.18.XX.55/castillo /mnt/sambaXX-remoto/castillo -o username=soldado1

En versiones anteriores de GNU/Linux se usaba el comando smbmount //smb-serverXX/public /mnt/remotoXX/public/ -o -username=smbguest.

COMPROBAR: Ejecutar el comando df -hT. Veremos que el recurso ha sido montado.

samba-linux-mount-cifs

        Si montamos la carpeta de castillo, lo que escribamos en /mnt/remotoXX/castillo debe aparecer en la máquina del servidor Samba. ¡Comprobarlo!
        Para desmontar el recurso remoto usamos el comando umount.

    Capturar imagen de los siguientes comandos para comprobar los resultados:
        smbstatus, desde el servidor Samba.
        netstat -ntap, desde el servidor Samba.
        netstat -n, desde el cliente Windows.

## **4.3. Montaje Automático.**


Acabamos de acceder a los recursos remotos, realizando un montaje de forma manual (comandos mount/umount). Si reiniciamos el equipo cliente, podremos ver que los montajes realizados de forma manual ya no están (df -hT). Si queremos volver a acceder a los recursos remotos debemos repetir el proceso de montaje manual, a no ser que hagamos una configuración de montaje permanente o automática.

    Para configurar acciones de montaje automáticos cada vez que se inicie el equipo, debemos configurar el fichero /etc/fstab. Veamos un ejemplo:

----------------------------------------------------------------------------------------


//smb-serverXX/public /mnt/remotoXX/public cifs username=soldado1,password=clave 0 0

    Reiniciar el equipo y comprobar que se realiza el montaje automático al inicio.
    Incluir contenido del fichero /etc/fstab en la entrega.

---

# **5. Preguntas Para Resolver.**

* ¿Las claves de los usuarios en GNU/Linux deben ser las mismas que las que usa Samba?.



* ¿Puedo definir un usuario en Samba llamado soldado3, y que no exista como usuario del sistema?.



* ¿Cómo podemos hacer que los usuarios soldado1 y soldado2 no puedan acceder al sistema pero sí al samba? (Consultar /etc/passwd).



* Añadir el recurso [homes] al fichero smb.conf según los apuntes. ¿Qué efecto tiene?



---
