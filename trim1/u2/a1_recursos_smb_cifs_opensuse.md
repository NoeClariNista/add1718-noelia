___

# **Samba.**

Samba con OpenSUSE y Windows 10.

---

# **1. Introducción.**

Vamos a necesitar las siguientes 3 MVs.

* MV1: Un Servidor GNU/Linux OpenSUSE con IP estática, 172.18.20.31.
* MV2: Un Cliente GNU/Linux OpenSUSE con IP estática, 172.18.20.32.
* MV3: Un Cliente Windows con IP estática, 172.18.20.11.

---

# **2. Servidor Samba (MV1).**

## **2.1. Preparativos.**

Configuramos el Servidor GNU/Linux usando los siguientes valores.

* Nombre de equipo: smb-server20.

![imagen01](./images/a1_recursos_smb_cifs_opensuse/01.png)

![imagen02](./images/a1_recursos_smb_cifs_opensuse/02.png)

* Añadimos en `/etc/hosts` los equipos smb-cli20a y smb-cli20b.

![imagen03](./images/a1_recursos_smb_cifs_opensuse/03.png)

![imagen04](./images/a1_recursos_smb_cifs_opensuse/04.png)

Capturamos la salida de los siguientes comandos en el Servidor.

~~~
hostname -f.
ip a.
lsblk.
sudo blkid.
~~~

![imagen05](./images/a1_recursos_smb_cifs_opensuse/05.png)

## **2.2. Usuarios Locales.**

Podemos usar comandos o entorno gráfico Yast, en mi caso utilizare entorno gráfico Yast.

Vamos a GNU/Linux, y creamos los siguientes grupos y usuarios.

Creamos el usuario supersamba.

![imagen06](./images/a1_recursos_smb_cifs_opensuse/06.png)

Creamos los usuarios pirata1, pirata2, luego creamos el grupo piratas e incluimos estos dos usuarios y también al usuario supersamba dentro del grupo.

![imagen07](./images/a1_recursos_smb_cifs_opensuse/07.png)

![imagen08](./images/a1_recursos_smb_cifs_opensuse/08.png)

![imagen09](./images/a1_recursos_smb_cifs_opensuse/09.png)

Creamos los usuarios soldado1 y soldado2, luego creamos el grupo soldados e incluimos estos dos usuarios y también al usuario supersamba dentro del grupo.

![imagen10](./images/a1_recursos_smb_cifs_opensuse/10.png)

![imagen11](./images/a1_recursos_smb_cifs_opensuse/11.png)

![imagen12](./images/a1_recursos_smb_cifs_opensuse/12.png)

Creamos el usuario smbguest. Para asegurarnos que nadie puede usar smbguest para entrar en nuestra máquina mediante login, vamos a modificar este usuario y le ponemos como shell `/bin/false`.

![imagen13](./images/a1_recursos_smb_cifs_opensuse/13.png)

![imagen14](./images/a1_recursos_smb_cifs_opensuse/14.png)

Creamos el grupo Todos y dentro de este grupo ponemos a todos los usuarios soldados, piratas, supersamba y smbguest.

![imagen15](./images/a1_recursos_smb_cifs_opensuse/15.png)

## **2.3. Crear Las Carpetas Para Los Futuros Recursos Compartidos.**

Vamos a crear las carpetas de los recursos compartidos con los permisos siguientes.

![imagen16](./images/a1_recursos_smb_cifs_opensuse/16.png)

* `/srv/samba20/public.d`.
  Usuario propietario: supersamba.
  Grupo propietario: Todos.
  Permisos: 775.

![imagen17](./images/a1_recursos_smb_cifs_opensuse/17.png)

* `/srv/samba20/castillo.d`.
  Usuario propietario: supersamba.
  Grupo propietario: soldados.
  Permisos: 770.

![imagen18](./images/a1_recursos_smb_cifs_opensuse/18.png)

* `/srv/samba20/barco.d`.
  Usuario propietario: supersamba.
  Grupo propietario: piratas.
  Permisos: 770.

![imagen19](./images/a1_recursos_smb_cifs_opensuse/19.png)

## **2.4. Instalar Samba Server.**

Vamos a hacer una copia de seguridad del fichero de configuración existente para ello utilizamos el comando siguiente cp `/etc/samba/smb.conf` `/etc/samba/smb.conf.000`.

![imagen20](./images/a1_recursos_smb_cifs_opensuse/20.png)

Podemos usar comandos o el entorno gráfico para instalar y configurar el Servicio Samba. En mi caso utilizare Yast. Dentro de Yast vamos a Samba Server y le añadimos la siguiente configuración.

~~~
Workgroup: mar1718
Sin controlador de dominio.
~~~

![imagen21](./images/a1_recursos_smb_cifs_opensuse/21.png)

![imagen22](./images/a1_recursos_smb_cifs_opensuse/22.png)

En la pestaña de Inicio definimos lo siguiente.

~~~
Iniciar el servicio durante el arranque de la máquina.
Ajustes del cortafuegos, Abrir los puertos.
~~~

![imagen23](./images/a1_recursos_smb_cifs_opensuse/23.png)

## **2.5. Configurar El Servidor Samba.**

Vamos a configurar los recursos compartido del Servidor Samba. Podemos hacerlo modificando el fichero de configuración o por entorno gráfico con Yast. Para ellos vamos a Yast, Samba Server y Recursos Compartidos.

![imagen24](./images/a1_recursos_smb_cifs_opensuse/24.png)

~~~
* [cdrom]
  path = /dev/cdrom
  guest ok = yes
  read only = yes
~~~

![imagen](./images/a1_recursos_smb_cifs_opensuse/25.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/26.png)

~~~
* [public]
  comment = public de noelia20
  path = /srv/samba20/public.d
  guest ok = yes
  read only = yes
~~~

![imagen](./images/a1_recursos_smb_cifs_opensuse/27.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/28.png)

~~~
* [castillo]
  comment = castillo de noelia20
  path = /srv/samba20/castillo.d
  read only = no
  valid users = @soldados
~~~

![imagen](./images/a1_recursos_smb_cifs_opensuse/29.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/30.png)

~~~
* [barco]
  comment = barco de noelia20
  path = /srv/samba20/barco.d
  read only = no
  valid users = pirata1, pirata2
~~~

![imagen](./images/a1_recursos_smb_cifs_opensuse/31.png)

![imagen](./images/a1_recursos_smb_cifs_opensuse/32.png)

Vamos a configurar uno de los recursos compartidos del Servidor Samba por linea de comandos, para ello vamos a cambiar el archivo que se encuentra en `/etc/samba/smb.conf`

~~~
* [global]
  netbios name = smb-server20
  workgroup = mar1718
  server string = Servidor de noelia20
  security = user
  map to guest = bad user
  guest account = smbguest
~~~

![imagen33](./images/a1_recursos_smb_cifs_opensuse/33.png)

![imagen34](./images/a1_recursos_smb_cifs_opensuse/34.png)

Abrimos una consola para comprobar los resultados con los siguientes comandos.

* cat `/etc/samba/smb.conf`.

![imagen35](./images/a1_recursos_smb_cifs_opensuse/35.png)

* testparm.

![imagen36](./images/a1_recursos_smb_cifs_opensuse/36.png)

## **2.6. Usuarios Samba.**

Después de crear los usuarios en el sistema, hay que añadirlos a Samba. Para ello utilizamos el comando smbpasswd -a "nombreusuario", para crear clave de Samba para un usuario del sistema.

![imagen37](./images/a1_recursos_smb_cifs_opensuse/37.png)

Para comprobar la lista de usuarios Samba utilizamos el comando pdbedit -L.

![imagen38](./images/a1_recursos_smb_cifs_opensuse/38.png)

## **2.7. Reiniciar.**

Ahora que hemos terminado con el Servidor, hay que reiniciar el Servicio para que se lean los cambios de configuración.

Usamos los siguientes comandos.

* Servicio smb (systemctl stop smb, systemctl start smb y systemctl status smb).

![imagen39](./images/a1_recursos_smb_cifs_opensuse/39.png)

* Servicio nmb (systemctl stop nmb, systemctl start nmb y systemctl status nmb).

![imagen40](./images/a1_recursos_smb_cifs_opensuse/40.png)

Utilizamos los siguientes comandos para la comprobación.

* sudo testparm, verifica la sintaxis del fichero de configuración del Servidor Samba.

![imagen41](./images/a1_recursos_smb_cifs_opensuse/41.png)

* sudo netstat -tap, vemos que el Servicio SMB/CIF está a la escucha.

![imagen42](./images/a1_recursos_smb_cifs_opensuse/42.png)

Para descartar un problema con el cortafuegos del Servidor Samba. Probamos el comando nmap -Pn smb-server20 desde la máquina real, u otra máquina GNU/Linux. Veremos los puertos SMB/CIFS (139 y 445) abiertos.

![imagen43](./images/a1_recursos_smb_cifs_opensuse/43.png)

---

# **3. Windows (MV3 smb-cli20b).**

Configuramos el Cliente Windows usando los siguientes valores.

* Nombre de equipo: smb-cli20b.

![imagen44](./images/a1_recursos_smb_cifs_opensuse/44.png)

![imagen45](./images/a1_recursos_smb_cifs_opensuse/45.png)

* Añadimos en `C:\Windows\System32\drivers\etc\hosts` los equipos smb-server20 y smb-cli20a.

![imagen46](./images/a1_recursos_smb_cifs_opensuse/46.png)

En los clientes Windows el software necesario viene preinstalado.

## **3.1. Cliente Windows GUI.**

Desde un Cliente Windows vamos a acceder a los recursos compartidos del servidor Samba. Escribimos \\\172.18.20.31 y nos conectaremos a los recursos compartidos del Servidor OpenSUSE.

![imagen47](./images/a1_recursos_smb_cifs_opensuse/47.png)

Comprobamos los accesos de todas las formas posibles. Como si fuéramos.

* Un soldado.

![imagen48](./images/a1_recursos_smb_cifs_opensuse/48.png)

![imagen49](./images/a1_recursos_smb_cifs_opensuse/49.png)

![imagen50](./images/a1_recursos_smb_cifs_opensuse/50.png)

* Un pirata.

![imagen51](./images/a1_recursos_smb_cifs_opensuse/51.png)

![imagen52](./images/a1_recursos_smb_cifs_opensuse/52.png)

![imagen53](./images/a1_recursos_smb_cifs_opensuse/53.png)

* Y un invitado.

![imagen54](./images/a1_recursos_smb_cifs_opensuse/54.png)

Después de cada conexión se quedan guardada la información en el Cliente Windows. Utilizamos el comando net use * /d /y para cerrar las conexión SMB/CIFS que se ha realizado desde el Cliente al Servidor.

![imagen55](./images/a1_recursos_smb_cifs_opensuse/55.png)

Utilizamos los siguientes comandos para comprobar los resultados.

* smbstatus, desde el Servidor Samba.

![imagen56](./images/a1_recursos_smb_cifs_opensuse/56.png)

* netstat -ntap, desde el Servidor Samba.

![imagen57](./images/a1_recursos_smb_cifs_opensuse/57.png)

* netstat -n, desde el Cliente Windows.

![imagen58](./images/a1_recursos_smb_cifs_opensuse/58.png)

## **3.2. Cliente Windows Comandos.**

En el Cliente Windows, para consultar todas las conexiones/recursos conectados utilizamos el comando net use.

![imagen59](./images/a1_recursos_smb_cifs_opensuse/59.png)

Si hubiera alguna conexión abierta la cerramos con el comando net use * /d /y y utilizamos net use para ver que no hay conexiones establecidas.

![imagen60](./images/a1_recursos_smb_cifs_opensuse/60.png)

Abrimos una shell de Windows. Usamos el comando net use /?, para consultar la ayuda del comando.

![imagen61](./images/a1_recursos_smb_cifs_opensuse/61.png)

Vamos a conectarnos desde la máquina Windows al Servidor Samba usando el comando net.

![imagen62](./images/a1_recursos_smb_cifs_opensuse/62.png)

Con el comando net view, vemos las máquinas (con recursos CIFS) accesibles por la red.

![imagen63](./images/a1_recursos_smb_cifs_opensuse/63.png)

## **3.3. Montaje Automático.**

El comando net use S: \\172.18.20.31\barco * /USER:pirata1 establece una conexión de barcos y pirata1 y lo monta en la unidad S.

![imagen64](./images/a1_recursos_smb_cifs_opensuse/64.png)

![imagen65](./images/a1_recursos_smb_cifs_opensuse/65.png)

Ahora podemos entrar en la unidad S ("s:") y crear carpetas, etc.

Comprobamos los resultados con los siguientes comandos.

* smbstatus, desde el Servidor Samba.

![imagen66](./images/a1_recursos_smb_cifs_opensuse/66.png)

* netstat -ntap, desde el Servidor Samba.

![imagen67](./images/a1_recursos_smb_cifs_opensuse/67.png)

* netstat -n, desde el Cliente Windows.

![imagen68](./images/a1_recursos_smb_cifs_opensuse/68.png)

---

# **4. Cliente GNU/Linux (MV2 smb-cli20a).**

Configuramos el Cliente GNU/Linux usando los siguientes valores.

* Nombre de equipo: smb-cli20a.

![imagen60](./images/a1_recursos_smb_cifs_opensuse/69.png)

![imagen70](./images/a1_recursos_smb_cifs_opensuse/70.png)

* Añadimos en `/etc/hosts` los equipos smb-server20 y smb-cli20b.

![imagen71](./images/a1_recursos_smb_cifs_opensuse/71.png)

![imagen72](./images/a1_recursos_smb_cifs_opensuse/72.png)

## **4.1. Cliente GNU/Linux GUI.**

Desde en entorno gráfico, podemos comprobar el acceso a recursos compartidos SMB/CIFS.

Accediendo al recurso prueba del Servidor Samba, pulsamos CTRL+L y escribimos `smb://172.18.20.31`.

![imagen73](./images/a1_recursos_smb_cifs_opensuse/73.png)

Probamos a crear carpetas/archivos en castillo y en barco.

* Castillo.

![imagen74](./images/a1_recursos_smb_cifs_opensuse/74.png)

![imagen75](./images/a1_recursos_smb_cifs_opensuse/75.png)

![imagen76](./images/a1_recursos_smb_cifs_opensuse/76.png)

![imagen77](./images/a1_recursos_smb_cifs_opensuse/77.png)

* Barco.

![imagen78](./images/a1_recursos_smb_cifs_opensuse/78.png)

![imagen79](./images/a1_recursos_smb_cifs_opensuse/79.png)

![imagen80](./images/a1_recursos_smb_cifs_opensuse/80.png)

![imagen81](./images/a1_recursos_smb_cifs_opensuse/81.png)

Comprobamos que el recurso public es de sólo lectura.

![imagen82](./images/a1_recursos_smb_cifs_opensuse/82.png)

![imagen83](./images/a1_recursos_smb_cifs_opensuse/83.png)

![imagen84](./images/a1_recursos_smb_cifs_opensuse/84.png)

![imagen85](./images/a1_recursos_smb_cifs_opensuse/85.png)

Comprobamos los resultados con los siguientes comandos.

* smbstatus, desde el Servidor Samba.

![imagen86](./images/a1_recursos_smb_cifs_opensuse/86.png)

* netstat -ntap, desde el Servidor Samba.

![imagen87](./images/a1_recursos_smb_cifs_opensuse/87.png)

* netstat -n, desde el Cliente.

![imagen88](./images/a1_recursos_smb_cifs_opensuse/88.png)

## **4.2. Cliente GNU/Linux Comandos.**

Existen comandos para ayudarnos a acceder vía comandos al servidor Samba desde el Cliente.

Vamos a un equipo GNU/Linux que será nuestro Cliente Samba. Desde este equipo usaremos comandos para acceder a la carpeta compartida.

Primero comprobamos el uso de las siguientes herramientas.

* sudo smbtree, muestra todos los equipos/recursos de la red SMB/CIFS. Hay que abrir el cortafuegos para que funcione.

![imagen89](./images/a1_recursos_smb_cifs_opensuse/89.png)

* smbclient --list 172.18.20.31, muestra los recursos SMB/CIFS de un equipo concreto.

![imagen90](./images/a1_recursos_smb_cifs_opensuse/90.png)

Ahora crearemos en local la carpeta `/mnt/samba20-remoto/castillo.`

![imagen91](./images/a1_recursos_smb_cifs_opensuse/91.png)

Con el usuario root, usamos el siguiente comando para montar un recurso compartido de Samba Server, como si fuera una carpeta más de nuestro sistema: mount -t cifs `//172.18.20.31/castillo` `/mnt/samba20-remoto/castillo` -o username=soldado1.

![imagen92](./images/a1_recursos_smb_cifs_opensuse/92.png)

Ejecutamos el comando df -hT y comprobaremos que el recurso ha sido montado.

![imagen93](./images/a1_recursos_smb_cifs_opensuse/93.png)

Comprobamos los resultados con los siguientes comandos.

* smbstatus, desde el Servidor Samba.

![imagen94](./images/a1_recursos_smb_cifs_opensuse/94.png)

* netstat -ntap, desde el Servidor Samba.

![imagen95](./images/a1_recursos_smb_cifs_opensuse/95.png)

* netstat -ntap, desde el Cliente.

![imagen96](./images/a1_recursos_smb_cifs_opensuse/96.png)

## **4.3. Montaje Automático.**

Acabamos de acceder a los recursos remotos, realizando un montaje de forma manual. Si reiniciamos el equipo cliente, podremos ver que los montajes realizados de forma manual ya no están. Si queremos volver a acceder a los recursos remotos debemos repetir el proceso de montaje manual, a no ser que hagamos una configuración de montaje permanente o automática.

![imagen97](./images/a1_recursos_smb_cifs_opensuse/97.png)

Para configurar acciones de montaje automáticos cada vez que se inicie el equipo, debemos configurar el fichero `/etc/fstab`.

~~~
//smb-server20/public /mnt/remoto20/public cifs username=soldado1,password=78646393d 0 0
~~~~

![imagen98](./images/a1_recursos_smb_cifs_opensuse/98.png)

![imagen99](./images/a1_recursos_smb_cifs_opensuse/99.png)

Reiniciamos el equipo y comprobamos que se realiza el montaje automático al inicio.

![imagen100](./images/a1_recursos_smb_cifs_opensuse/100.png)

A continuación incluimos el contenido del fichero `/etc/fstab` en la entrega.

[Fichero `/etc/fstab`.](./archivos/fstab.pdf)

---

# **5. Preguntas Para Resolver.**

* ¿Las claves de los usuarios en GNU/Linux deben ser las mismas que las que usa Samba?.

No, los usuarios pueden tener distintas contraseñas en GNU/Linux y en Samba.

* ¿Puedo definir un usuario en Samba llamado soldado3, y que no exista como usuario del sistema?.

No, todos los usuarios que queramos que estén en Samba deben estar también en el sistema.

* ¿Cómo podemos hacer que los usuarios soldado1 y soldado2 no puedan acceder al sistema pero sí al samba?.

Para que los usuarios soldado1 y soldado2 no puedan acceder al sistema pero sí al Samba tenemos que ir al Yast y en cada usuario ponemos en shell de inicio de sesión `/bin/false`.

* Añadir el recurso [homes] al fichero smb.conf según los apuntes. ¿Qué efecto tiene?

La sección [homes] nos permitirá compartir las carpetas home de cada usuario, para que cada usuario pueda acceder a su carpeta home por la red.

---
