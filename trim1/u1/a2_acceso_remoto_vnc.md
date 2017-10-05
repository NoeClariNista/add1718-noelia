# **Acceso Remoto VNC.**

## **1. Introducción.**

VNC es un programa de software libre basado en una estructura cliente-servidor que permite tomar el control del ordenador servidor remotamente a través de un ordenador cliente. VNC no impone restricciones en el sistema operativo del ordenador servidor con respecto al del cliente: es posible compartir la pantalla de una máquina con cualquier sistema operativo que admita VNC conectándose desde otro ordenador o dispositivo que disponga de un cliente VNC portado.

## **2. Conexiones remotas con VNC.**

En esta práctica haremos la instalación y configuración VNC para poder acceder a una máquina remota.

Vamos a realizar las siguientes conexiones remotas VNC:

* Acceder a Windows 10 Server desde Windows 10 Cliente.

* Acceder a GNU/Linux OpenSUSE Leap 42.2 Server desde Windows 10 Cliente.

* Aceder a GNU/Linux OpenSUSE Leap 42.2 Server desde GNU/Linux OpenSUSE Leap 42.2 Cliente.

* Acceder a Windows 10 Server desde GNU/Linux OpenSUSE Leap 42.2 Cliente.

~~~
Para esta práctica usaremos conexiones sin cifrar.
~~~

## **3. Instalación en Windows.**

Configuramos las máquinas virtuales de Windows 10 como se ve a continuación:

![]()

![]()
~~~
El comando netstat -n solo se utiliza en las máquinas virtuales de Windows.
~~~

TightVNC es una herramienta libre disponible para Windows. En el servidor VNC usaremos TightVNC server.

![]()

Revisar la configuración del cortafuegos del servidor VNC Windows para permitir VNC.

![]()

En el cliente usaremos TightVNC viewer.

![]()

### **3.1. Windows Cliente - Windows Server.**

Introducimos la dirección IP del Windows Server y nos hara la conexión y podremos ver lo que pasa en la otra maquina simultaneamente.

![]()

Ejecutamos el comando netstat -n desde la máquina del cliente para ver que se conectan entre ambas máquinas virtuales estableciendo conexiones remotas VNC.

![]()

### **3.2. Windows Cliente - OpenSUSE Server.**

En OpenSUSE tenemos el servidor VNC en el Yast, solo tenemos que activarlo.

![]()

Dentro del servidor VNC tenemos que  permitir conexión remota y también abrimos los puertos VNC en el cortafuegos.

![]()

En el cliente usaremos TightVNC viewer.

![]()

Ponemos en la máquina del cliente vncviewer 172.18.20.11:5901.

![]()

Ejecutamos el comando netstat -n desde la máquina del cliente para ver que se conectan entre ambas máquinas virtuales estableciendo conexiones remotas VNC.

![]()


## **4. Instalación en OpenSUSE.**

Configuramos las máquinas virtuales de OpenSUSE Leap 42.2 como se ve a continuación:

![imagen01o](./images/a2_acceso_remoto_vnc/01o.png)

![imagen02o](./images/a2_acceso_remoto_vnc/02o.png)

![imagen03o](./images/a2_acceso_remoto_vnc/03o.png)

![imagen04o](./images/a2_acceso_remoto_vnc/04o.png)

![imagen05o](./images/a2_acceso_remoto_vnc/05o.png)

![imagen06o](./images/a2_acceso_remoto_vnc/06o.png)

![imagen07o](./images/a2_acceso_remoto_vnc/07o.png)

![imagen08o](./images/a2_acceso_remoto_vnc/08o.png)

![imagen09o](./images/a2_acceso_remoto_vnc/09o.png)

![imagen10o](./images/a2_acceso_remoto_vnc/10o.png)

![imagen11o](./images/a2_acceso_remoto_vnc/11o.png)

![imagen12o](./images/a2_acceso_remoto_vnc/12o.png)

![imagen13o](./images/a2_acceso_remoto_vnc/13o.png)

~~~
Hay varias formas de usar vncviewer:
- vncviewer IP-vnc-server:590N
- vncviewer IP-vnc-server:N
- vncviewer IP-vnc-server::590N
~~~

~~~
El comando netstat -ntap solo se utiliza en las máquinas virtuales de OpenSUSE.
~~~

### **4.1. OpenSUSE Cliente - OpenSUSE Server.**

En OpenSUSE tenemos el servidor VNC en el Yast y solo tenemos que activarlo.

![imagen14o](./images/a2_acceso_remoto_vnc/14o.png)

Dentro del servidor VNC tenemos que permitir conexión remota y también abrimos los puertos VNC en el cortafuegos.

![imagen15o](./images/a2_acceso_remoto_vnc/15o.png)

![imagen16o](./images/a2_acceso_remoto_vnc/16o.png)

![imagen17o](./images/a2_acceso_remoto_vnc/17o.png)

![imagen18o](./images/a2_acceso_remoto_vnc/18o.png)

![imagen19o](./images/a2_acceso_remoto_vnc/19o.png)

vncviewer es un cliente VNC que viene con OpenSUSE. En la conexion remota, hay que especificar la IP, en mi caso la IP es 5901, para ello utilice el comando nmap -Pn 172.18.20.31, y ahí me sale el número de mi IP.

![imagen20o](./images/a2_acceso_remoto_vnc/20o.png)

Ponemos en la máquina del cliente vncviewer 172.18.20.11:5901.

![imagen21o](./images/a2_acceso_remoto_vnc/21o.png)

![imagen22o](./images/a2_acceso_remoto_vnc/22o.png)

Ejecutamos el comando netstat -ntap desde la máquina del cliente para ver que se conectan entre ambas máquinas virtuales estableciendo conexiones remotas VNC.

![]()

### **4.2. OpenSUSE Cliente - Windows Server.**

TightVNC es una herramienta libre disponible para Windows. En el servidor VNC usaremos TightVNC server.

![]()

Revisar la configuración del cortafuegos del servidor VNC Windows para permitir VNC.

![]()

vncviewer es un cliente VNC que viene con OpenSUSE.

![]()

Introducimos la dirección IP del Windows Server.

![]()

Ejecutamos el comando netstat -ntap desde la máquina del cliente para ver que se conectan entre ambas máquinas virtuales estableciendo conexiones remotas VNC.

![]()
