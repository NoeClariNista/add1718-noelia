# **Acceso Remoto VNC.**

## **1. Introducción.**

VNC es un programa de software libre basado en una estructura cliente-servidor que permite tomar el control del ordenador servidor remotamente a través de un ordenador cliente. VNC no impone restricciones en el sistema operativo del ordenador servidor con respecto al del cliente: es posible compartir la pantalla de una máquina con cualquier sistema operativo que admita VNC conectándose desde otro ordenador o dispositivo que disponga de un cliente VNC portado.

## **2. Conexiones remotas con VNC.**

En esta práctica haremos la instalación y configuración VNC para poder acceder a una máquina remota.

Vamos a realizar las siguientes conexiones remotas VNC:

* Acceder a Windows 10 Server - desde Windows 10 Cliente.

* Acceder a Windows 10 Server - desde GNU/Linux OpenSUSE Leap 42.2 Cliente.

* Aceder a GNU/Linux OpenSUSE Leap 42.2 Server - desde GNU/Linux OpenSUSE Leap 42.2 Cliente.

* Acceder a GNU/Linux OpenSUSE Leap 42.2 Server - desde Windows 10 Cliente.

~~~
Para esta práctica usaremos conexiones sin cifrar.
~~~

## **3. Instalación en Windows.**

~~~
El comando netstat -n solo se utiliza en las máquinas virtuales de Windows.
~~~

### **3.1. Windows Cliente - Windows Server.**

Configuramos las máquinas virtuales según este documento.

![]()

![]()

TightVNC es una herramienta libre disponible para Windows. En el servidor VNC usaremos TightVNC server.

![]()

Revisar la configuración del cortafuegos del servidor VNC Windows para permitir VNC.

![]()

En el cliente usaremos TightVNC viewer.

![]()

Ejecutamos el comando netstat -n desde la máquina del cliente para ver que se conectan entre ambas máquinas virtuales estableciendo conexiones remotas VNC.

![]()

### **3.2. Windows Cliente - OpenSUSE Server.**

Configuramos las máquinas virtuales según este documento.

![]()

![]()

TightVNC es una herramienta libre disponible para Windows. En el servidor VNC usaremos TightVNC server.

![]()

Revisar la configuración del cortafuegos del servidor VNC Windows para permitir VNC.

![]()

vncviewer es un cliente VNC que viene con OpenSUSE. En la conexion remota, hay que especificar IP:5901, IP:5902, etc. En mi caso IP:5901m, para ello utilice el comando nmap -Pn 172.18.20.31, y ahí me sale el número de mi IP.

![]()

Ponemos en la máquina del cliente vncviewer 172.18.20.11:5901.

![]()

Ejecutamos el comando netstat -ntap desde la máquina del cliente para ver que se conectan entre ambas máquinas virtuales estableciendo conexiones remotas VNC.

![]()


## **4. Instalación en OpenSUSE.**

~~~
Hay varias formas de usar vncviewer:
* vncviewer IP-vnc-server:590N
* vncviewer IP-vnc-server:N
* vncviewer IP-vnc-server::590N
~~~

~~~
El comando netstat -ntap solo se utiliza en las máquinas virtuales de OpenSUSE.
~~~

### **4.1. OpenSUSE Cliente - OpenSUSE Server.**

Configuramos las máquinas virtuales de OpenSUSE según este documento.

![]()

![]()

En OpenSUSE tenemos el servidor VNC en el Yast, solo tenemos que activarlo.

![]()

Dentro del servidor VNC tenemos que  permitir conexión remota y también abrimos los puertos VNC en el cortafuegos.

![]()

vncviewer es un cliente VNC que viene con OpenSUSE. En la conexion remota, hay que especificar IP:5901, IP:5902, etc. En mi caso IP:5901m, para ello utilice el comando nmap -Pn 172.18.20.31, y ahí me sale el número de mi IP.

![]()

Ponemos en la máquina del cliente vncviewer 172.18.20.11:5901.

![]()

Ejecutamos el comando netstat -ntap desde la máquina del cliente para ver que se conectan entre ambas máquinas virtuales estableciendo conexiones remotas VNC.

![]()

### **4.2. OpenSUSE Cliente - Windows Server.**

Configuramos las máquinas virtuales de OpenSUSE según este documento.

![]()

![]()

En OpenSUSE tenemos el servidor VNC en el Yast, solo tenemos que activarlo.

![]()

Dentro del servidor VNC tenemos que  permitir conexión remota y también abrimos los puertos VNC en el cortafuegos.

![]()

En el cliente usaremos TightVNC viewer.

![]()

Ejecutamos el comando netstat -n desde la máquina del cliente para ver que se conectan entre ambas máquinas virtuales estableciendo conexiones remotas VNC.

![]()
