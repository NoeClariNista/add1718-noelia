___

# **Acceso Remoto VNC.**

---

# **1. Introducción.**

VNC es un programa de software libre basado en una estructura cliente-servidor que permite tomar el control del ordenador servidor remotamente a través de un ordenador cliente. VNC no impone restricciones en el sistema operativo del ordenador servidor con respecto al del cliente: es posible compartir la pantalla de una máquina con cualquier sistema operativo que admita VNC conectándose desde otro ordenador o dispositivo que disponga de un cliente VNC portado.

___

# **2. Conexiones Remotas Con VNC.**

En esta práctica haremos la instalación y configuración VNC para poder acceder a una máquina remota.

Vamos a realizar las siguientes conexiones remotas VNC:

* Acceder a Windows 10 Server desde Windows 10 Cliente.

* Acceder a GNU/Linux OpenSUSE Leap 42.2 Server desde Windows 10 Cliente.

* Acceder a GNU/Linux OpenSUSE Leap 42.2 Server desde GNU/Linux OpenSUSE Leap 42.2 Cliente.

* Acceder a Windows 10 Server desde GNU/Linux OpenSUSE Leap 42.2 Cliente.

~~~

Para esta práctica usamos conexiones sin cifrar.

~~~

---

# **3. Instalación En Windows.**

Configuramos las máquinas virtuales de Windows 10.

Primero configuramos la máquina virtual de Windows 10 Server.

![imagen01](./images/a2_acceso_remoto_vnc/01.png)

![imagen02](./images/a2_acceso_remoto_vnc/02.png)

![imagen03](./images/a2_acceso_remoto_vnc/03.png)

Ahora configuramos la máquina virtual de Windows 10 Cliente.

![imagen04](./images/a2_acceso_remoto_vnc/04.png)

![imagen05](./images/a2_acceso_remoto_vnc/05.png)

![imagen06](./images/a2_acceso_remoto_vnc/06.png)

TightVNC es una herramienta libre disponible para Windows. En el Servidor VNC usaremos TightVNC Server.

![imagen07](./images/a2_acceso_remoto_vnc/07.png)

![imagen08](./images/a2_acceso_remoto_vnc/08.png)

![imagen09](./images/a2_acceso_remoto_vnc/09.png)

![imagen10](./images/a2_acceso_remoto_vnc/10.png)

Dicha herramienta necesita una contraseña para luego cuando nos conectemos desde el Windows 10 Cliente poder ponerla y conectarnos de manera segura.

![imagen11](./images/a2_acceso_remoto_vnc/11.png)

Revisar la configuración del cortafuegos del Servidor VNC Windows para permitir VNC.

![imagen12](./images/a2_acceso_remoto_vnc/12.png)

En el Cliente usaremos TightVNC Viewer.

![imagen13](./images/a2_acceso_remoto_vnc/13.png)

![imagen14](./images/a2_acceso_remoto_vnc/14.png)

![imagen15](./images/a2_acceso_remoto_vnc/15.png)

## **3.1. Windows Cliente - Windows Server.**

Introducimos la dirección IP del Windows Server y su contraseña, nos hará la conexión y podremos ver lo que pasa en la otra maquina simultáneamente.

![imagen16](./images/a2_acceso_remoto_vnc/16.png)

![imagen17](./images/a2_acceso_remoto_vnc/17.png)

![imagen18](./images/a2_acceso_remoto_vnc/18.png)

![imagen19](./images/a2_acceso_remoto_vnc/19.png)

Ejecutamos el comando netstat -n desde la máquina del Cliente para ver que se conectan entre ambas máquinas virtuales estableciendo conexiones remotas VNC.

![imagen20](./images/a2_acceso_remoto_vnc/20.png)

## **3.2. Windows Cliente - OpenSUSE Server.**

Ponemos en la máquina del Cliente Vncviewer 172.18.20.11:5901.

![imagen21](./images/a2_acceso_remoto_vnc/21.png)

![imagen22](./images/a2_acceso_remoto_vnc/22.png)

![imagen23](./images/a2_acceso_remoto_vnc/23.png)

Ejecutamos el comando netstat -n desde la máquina del Cliente para ver que se conectan entre ambas máquinas virtuales estableciendo conexiones remotas VNC.

![imagen24](./images/a2_acceso_remoto_vnc/24.png)

___

~~~

El comando netstat -n solo se utiliza en las máquinas virtuales de Windows.

~~~

___

# **4. Instalación en OpenSUSE.**

Configuramos las máquinas virtuales de OpenSUSE Leap 42.2.

Primero configuramos la máquina virtual de OpenSUSE Leap 42.2 Server.

![imagen25](./images/a2_acceso_remoto_vnc/25.png)

![imagen26](./images/a2_acceso_remoto_vnc/26.png)

![imagen27](./images/a2_acceso_remoto_vnc/27.png)

![imagen28](./images/a2_acceso_remoto_vnc/28.png)

Ahora configuramos la máquina virtual de OpenSUSE Leap 42.2 Cliente.

![imagen29](./images/a2_acceso_remoto_vnc/29.png)

![imagen30](./images/a2_acceso_remoto_vnc/30.png)

![imagen31](./images/a2_acceso_remoto_vnc/31.png)

![imagen32](./images/a2_acceso_remoto_vnc/32.png)

Para ambas máquina ponemos el mismo nombre de usuario, activamos el cortafuegos y ponemos como servicio autorizado el SSH.

![imagen33](./images/a2_acceso_remoto_vnc/33.png)

![imagen34](./images/a2_acceso_remoto_vnc/34.png)

![imagen35](./images/a2_acceso_remoto_vnc/35.png)

En OpenSUSE tenemos el Servidor VNC en el Yast y solo tenemos que activarlo.

![imagen36](./images/a2_acceso_remoto_vnc/36.png)

Dentro del Servidor VNC tenemos que permitir conexión remota y también abrimos los puertos VNC en el cortafuegos.

![imagen37](./images/a2_acceso_remoto_vnc/37.png)

Comprobamos también que en el cortafuegos está autorizado el servicio de VNC.

![imagen38](./images/a2_acceso_remoto_vnc/38.png)

Empezamos la instalación de dicho servicio, instalando los paquetes xorg-x11 y vncmanager.

![imagen39](./images/a2_acceso_remoto_vnc/39.png)

![imagen40](./images/a2_acceso_remoto_vnc/40.png)

## **4.1. OpenSUSE Cliente - OpenSUSE Server.**

Vncviewer es un Cliente VNC que viene con OpenSUSE. En la conexión remota, hay que especificar la IP, en mi caso la IP es 5901, para ello utilice el comando nmap -Pn 172.18.20.31, y ahí me sale el número de mi IP.

![imagen41](./images/a2_acceso_remoto_vnc/41.png)

Ponemos en la máquina del Cliente vncviewer 172.18.20.11:5901.

![imagen42](./images/a2_acceso_remoto_vnc/42.png)

![imagen43](./images/a2_acceso_remoto_vnc/43.png)

Ejecutamos el comando netstat -ntap desde la máquina del Cliente para ver que se conectan entre ambas máquinas virtuales estableciendo conexiones remotas VNC.

![imagen44](./images/a2_acceso_remoto_vnc/44.png)

## **4.2. OpenSUSE Cliente - Windows Server.**

Introducimos la dirección IP del Windows Server.

![imagen45](./images/a2_acceso_remoto_vnc/45.png)

![imagen46](./images/a2_acceso_remoto_vnc/46.png)

![imagen47](./images/a2_acceso_remoto_vnc/47.png)

Ejecutamos el comando netstat -ntap desde la máquina del Cliente para ver que se conectan entre ambas máquinas virtuales estableciendo conexiones remotas VNC.

![imagen48](./images/a2_acceso_remoto_vnc/48.png)

---

~~~

Hay varias formas de usar Vncviewer:
- vncviewer IP-VNC-Server:590N
- vncviewer IP-VNC-Server:N
- vncviewer IP-VNC-Server::590N

~~~

~~~

El comando netstat -ntap solo se utiliza en las máquinas virtuales de OpenSUSE.

~~~

___
