___

# **Puppet - OpenSUSE.**

---

# **1. Introducción.**

Existen varias herramientas para realizar instalaciones desde un punto central, como Chef, Ansible, CFEngine, etc. En este ejemplo, vamos a usar Puppet.

Según Wikipedia, Puppet es una herramienta diseñada para administrar la configuración de sistemas Unix-like y de Microsoft Windows de forma declarativa. El usuario describe los recursos del sistema y sus estados, ya sea utilizando el lenguaje declarativo de Puppet o un DSL (lenguaje específico del dominio) de Ruby.

## **1.1. Configuración.**

Vamos a usar 3 MV's con las siguientes configuraciones.

* MV1 - master: Dará las órdenes de instalación/configuración a los clientes.
  * IP estática: 172.18.20.100.
  * Nombre del equipo: master20.
  * Dominio: curso1718.

![imagen01](./images/01.png)

![imagen02](./images/02.png)

* MV2 - cliente 1: recibe órdenes del master.
  * IP estática 172.18.20.101.
  * Nombre del equipo: cli1alu20.
  * Dominio: curso1718.

![imagen03](./images/03.png)

![imagen04](./images/04.png)

* MV3 - client2: recibe órdenes del master.
  * IP estática 172.18.20.102.
  * Nombre Netbios: cli2alu20.
  * Nombre del equipo: cli2alu20.

![imagen05](./images/05.png)

![imagen06](./images/06.png)

Cada MV debe tener configurada en su `/etc/hosts` al resto de hosts, para poder hacer ping entre ellas usando los nombres largos y cortos. Con este fichero obtenemos resolución de nombres para nuestras propias MV's sin tener un servidor DNS.

* MV1.

  El fichero `/etc/hosts` debe tener el siguiente contenido.

  ![imagen07](./images/07.png)

  ![imagen08](./images/08.png)

* MV2.

  El fichero `/etc/hosts` debe tener el siguiente contenido.

  ![imagen09](./images/09.png)

  ![imagen10](./images/10.png)

* MV3.

  Para localizar el fichero hosts de Windows, vamos a la siguiente ruta.

  ![imagen11](./images/11.png)

  El contenido del fichero hosts de Windows tiene el siguiente aspecto.

  ![imagen12](./images/12.png)

## **1.2. Comprobar Las Configuraciones.**

En GNU/Linux, para comprobar que las configuraciones son correctas hacemos los siguientes comandos.

~~~
date.
ip a.
route -n.
host www.google.es.
hostname -a.
hostname -f.
hostname -d.
tail -n 5 `/etc/hosts`.
ping master20.
ping master20.curso1718.
ping cli1alu20.
ping cli1alu20.curso1718.
ping cli2alu20.
~~~

* MV1.

![imagen13](./images/13.png)

![imagen14](./images/14.png) <- unir 14.1 y 14.2.

* MV2.

![imagen15](./images/15.png)

![imagen16](./images/16.png) <- unir 16.1 y 16.2.

En Windows comprobamos con los siguientes comandos.

~~~
date.
ipconfig.
route PRINT.
nslookup www.google.es.
ping master20.
ping master20.curso1718.
ping cli1alu20.
ping cli1alu20.curso1718.
ping cli2alu20.
~~~

* MV3.

![imagen17](./images/17.png) <- unir todas las 17.

![imagen18](./images/18.png) <- cambiar números en las imagenes a partir de aqui.

---

# **2. Primera Versión Del Fichero pp.**

Instalamos Puppet Master en la MV master20.

![imagen19](./images/19.png)

Utilizamos los siguientes comandos.

~~~
systemctl status puppetmaster, consultamos el estado del Servicio.
systemctl enable puppetmaster, permitimos que el Servicio se inicie automáticamente en el inicio de la máquina.
systemctl start puppetmaster, iniciamos el Servicio.
systemctl status puppetmaster, consultamos el estado del Servicio.
~~~

![imagen20](./images/20.png)

En este momento se ha creado el directorio `/etc/puppet/manifests`.

![imagen21](./images/21.png)

Preparamos los ficheros/directorios en el Master.

~~~
mkdir `/etc/puppet/files`.
touch `/etc/puppet/files/readme.txt`.
mkdir `/etc/puppet/manifests`.
touch `/etc/puppet/manifests/site.pp`.
mkdir `/etc/puppet/manifests/classes`.
touch `/etc/puppet/manifests/classes/hostlinux1.pp`.
~~~

![imagen22](./images/22.png)

## **2.1. readme.txt.**

Los ficheros que se guardan en `/etc/puppet/files` se pueden descargar desde el resto de máquinas Cliente puppet.

![imagen23](./images/23.png)

El contenido para readme.txt es el siguiente.

![imagen24](./images/24.png)

## **2.2. site.pp.**

`/etc/puppet/manifests/site.pp` es el fichero principal de configuración de órdenes para los agentes/nodos puppet.

![imagen25](./images/25.png)

El contenido de nuestro site.pp es el siguiente.

![imagen26](./images/26.png)

## **2.3. hostlinux1.pp.**

Como podemos tener muchas configuraciones, vamos a separarlas en distintos ficheros para organizarnos mejor, y las vamos a guardar en la ruta `/etc/puppet/manifests/classes`.

Vamos a crear una primera configuración para máquina estándar GNU/Linux.

![imagen27](./images/27.png)

El contenido para `/etc/puppet/manifests/classes/hostlinux1.pp` es el siguiente.

![imagen28](./images/28.png)

Consultamos los ficheros/directorios que tenemos creado con el comando tree `/etc/puppet`.

![imagen29](./images/29.png)

Comprobamos que tenemos los permisos adecuados en la ruta `/var/lib/puppet`. Esto es, usuario puppet y grupo puppet.

![imagen30](./images/30.png)

Reiniciamos el Servicio con el comando systemctl restart puppetmaster.

![imagen31](./images/31.png)

Comprobamos que el Servicio está en ejecución de forma correcta con los siguientes comandos.

~~~
systemctl status puppetmaster.
netstat -ntap |grep ruby.
~~~

![imagen32](./images/32.png)

Consultamos log por si hay errores  con el comando tail `/var/log/puppet/*.log`

![imagen33](./images/33.png)

Abrimos el cortafuegos para el Servicio.

![imagen34](./images/34.png)

![imagen35](./images/35.png)

---

# **3. Instalación Y Configuración Del Cliente1.**

Vamos a instalar y configurar el Cliente 1.

Vamos a la MV Cliente 1.

Instalamos el Agente Puppet.

![imagen36](./images/36.png)

El Cliente puppet debe ser informado de quien será su master. Para ello, vamos a configurar `/etc/puppet/puppet.conf`.

![imagen37](./images/37.png)

![imagen38](./images/38.png)

Comprobamos que tenemos los permisos adecuados en la ruta `/var/lib/puppet`.

![imagen39](./images/39.png)

Utilizamos los siguientes comandos.

~~~
systemctl status puppet, vemos el estado del Servicio puppet.
systemctl enable puppet, activamos el Servicio en cada reinicio de la máquina.
systemctl start puppet, iniciamos el Servicio puppet.
systemctl status puppet, vemos el estado del Servicio puppet.
netstat -ntap |grep ruby, muestra los Servicios conectados a cada puerto.
~~~

![imagen40](./images/40.png)

Abrimos el cortafuegos para el Servicio.

![imagen41](./images/41.png)

![imagen42](./images/42.png)

---

# **4. Certificados.**

Antes de que el master acepte a Cliente 1 como Cliente, se deben intercambiar los certificados entre ambas máquinas. Esto sólo hay que hacerlo una vez.

## **4.1. Aceptar Certificado.**

Vamos a la MV master.

Consultamos las peticiones pendientes de unión al master con el comando puppet cert list.

![imagen43](./images/43.png)

Aceptamos al nuevo Cliente desde el master con el comando puppet cert sign cli1alu20.curso1718.

![imagen44](./images/44.png)

![imagen45](./images/45.png)

## **4.2. Comprobación.**

Vamos a comprobar que las órdenes (manifiesto) del master, llega bien al Cliente y éste las ejecuta.

Vamos a Cliente 1 y reiniciamos la máquina y el Servicio Puppet.

![imagen46](./images/46.png)

Comprobamos que los cambios configurados en Puppet se han realizado.

![imagen47](./images/47.png)

Nos aseguramos de que somos el usuario root y ejecutamos los siguientes comandos para comprobar posibles errores.

~~~
puppet agent --test.
puppet agent --server master20.curso1718 --test.
~~~

![imagen48](./images/48.png)

Para ver el detalle de los errores, podemos reiniciar el Servicio puppet en el Cliente, y consultamos el archivo de log del Cliente, para ello utilizamos el comando tail `/var/log/puppet/puppet.log`.

![imagen49](./images/49.png)

# **5. Segunda Versión Del Fichero pp.**

Ya hemos probado una configuración sencilla en PuppetMaster. Ahora vamos a pasar a configurar algo más complejo.

![imagen50](./images/50.png)

El contenido para `/etc/puppet/manifests/classes/hostlinux2.pp` es el siguiente.

![imagen51](./images/51.png)

Modificamos `/etc/puppet/manifests/site.pp` para que se use la configuración de hostlinux2 el lugar de la anterior.

![imagen52](./images/52.png)

El contenido para `/etc/puppet/manifests/site.pp` es el siguiente.

![imagen53](./images/53.png)

Ejecutamos tree `/etc/puppet` en el Servidor, para comprobar ficheros y directorios.

![imagen54](./images/54.png)

Vamos al Cliente 1 y comprobamos que se hayan aplicado los cambios solicitados.

![imagen55](./images/55.png)

--- OK.

# **6. Cliente Puppet Windows.**

Vamos a configurar Puppet para atender también a Clientes Windows.

## **6.1. Modificaciones En El Master.**

Vamos a la MV master.

Vamos a crear una configuración puppet para las máquinas Windows, dentro del fichero.

![imagen56](./images/56.png)

Creamos `/etc/puppet/manifests/classes/hostwindows3.pp` con el siguiente contenido.

![imagen57](./images/57.png)

De momento, esta configuración es muy básica. Al final la ampliaremos algo más.

Ahora vamos a modificar el fichero site.pp del master, para que tenga en cuenta la configuración de Clientes GNU/Linux y Clientes Windows, de modo diferenciado, con el siguiente contenido.

![imagen58](./images/58.png)

![imagen509](./images/59.png)

Ejecutamos tree `/etc/puppet` para confirmar que tenemos los nuevos archivos.

![imagen60](./images/60.png)

Reiniciamos el Servicio PuppetMaster.

![imagen61](./images/61.png)

Debemos instalar la misma versión de puppet en master y en los Clientes.

Ejecutamos el comando facter para ver la versión de Puppet que está usando el master.

![imagen62](./images/62.png)

## **6.2. Modificaciones En El Cliente2.**

Ahora vamos a instalar AgentePuppet en Windows. Recordar que debemos instalar la misma versión en ambos equipos. Podemos usar comando facter para ver la versión de puppet del Servidor.

![imagen63](./images/63.png)

Vamos al Cliente Windows.

Descargamos e instalamos la versión de Agente Puppet para Windows similar al Puppet Master.

![]

Reiniciamos la MV.

Debemos aceptar el certificado en el master para este nuevo cliente. Consultar apartado anterior y repetir los pasos para este nuevo cliente.

Si no aparece el cliente Windows en em master

Si en el master no nos aparece el certificado del cliente windows para ser aceptado, probar lo siguiente:

        Ir a cli2aluXX
        Ejecutar el "Agente Puppet"
        Abrir "Consola Puppet" -> Ejecutar puppet agent --server masterXX.curso1617 --test.
        Ir a masterXX -> puppet cert list
        Capturar pantallas de estos pasos.

    ¿Cómo desintalar Puppet en Windows?

    Consejos/sugerencias de Héctor Pedraza pars desinstalar Puppet en Windows:

    Si tenemos problemas con el certificado de la máquina windows cliente tenemos que seguir los siguientes pasos para eliminar cualquier rastro de los mismos y poder reintentar la comunicación:

        Borrar en el maestro el certificado correspondiente a esa máquina puppet cert clean nombre-netbios-cliente.
        Desinstalar el agente puppet en windows.
        Borrar las carpetas de datos del puppet, ya que no se borran en la desinstalación. Las carpetas son:
            C:\ProgramData\PuppetLabs y
            C:\Users\usuario\.puppet.
        Después reinstalamos y volvemos a probar.

    Si seguimos teniendo problemas para unir/conectar el cliente windows con el puppetmaster, porque no se realice el intercambio de certificados podemos:

        Repetir las recomendaciones anteriores para limpiar los datos, poner un nombre nuevo y diferente a la máquina Windows e intentarlo de nuevo.
        o usar una máquina Windows nueva (limpia de las acciones anteriores).

    Vamos al cliente2.

Con los comandos siguientes podremos hacernos una idea de como terminar de configurar el fichero puppet del master para la máquina Windows.

    Iniciar consola puppet como administrador y probar los comandos:
        puppet agent --configprint server, debe mostrar el nombre del servidor puppet. En nuestro ejemplo debe ser masterXX.curso1627.
        puppet agent --server masterXX.curso1617 --test: Comprobar el estado del agente puppet.
        puppet agent -t --debug --verbose: Comprobar el estado del agente puppet.
        facter: Para consultar datos de la máquina windows, como por ejemplo la versión de puppet del cliente.
        puppet resource user nombre-alumno1: Para ver la configuración puppet del usuario.
        puppet resource file c:\Users: Para var la configuración puppet de la carpeta.

Veamos imagen de ejemplo:

puppet-resource-windows

    Configuramos en el master el fichero /etc/puppet/manifests/classes/hostwindows4.pp para el cliente Windows:

class hostwindows4 {
  user { 'soldado1':
    ensure => 'present',
    groups => ['Administradores'],
  }

  user { 'aldeano1':
    ensure => 'present',
    groups => ['Usuarios'],
  }
}

    Crear un nuevo fichero de configuración para la máquina cliente Windows con el nombre /etc/puppet/manifests/classes/hostalumno5.pp.
    Incluir configuraciones elegidas por el alumno y probarlas.

## **6.3. Comprobamos Los Cambios.**

Vamos al Cliente 2.

Con los comandos siguientes podremos hacernos una idea de como terminar de configurar el fichero puppet del master para la máquina Windows.

Iniciamos la consola puppet como administrador y probamos los siguientes comandos.

~~~
puppet agent --configprint server, debe mostrar el nombre del servidor puppet. En nuestro ejemplo debe ser master20.curso1718.
puppet agent --server master20.curso1718 --test, comprobamos el estado del agente puppet.
puppet agent -t --debug --verbose, comprobamos el estado del agente puppet.
facter, para consultar datos de la máquina Windows, como por ejemplo la versión de puppet del Cliente.
puppet resource user noelia, para ver la configuración puppet del usuario.
puppet resource file c:\Users, para ver la configuración puppet de la carpeta.
~~~

---
