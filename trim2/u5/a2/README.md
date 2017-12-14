___

# **Docker.**

---

# **1. Introducción.**

Es muy común que nos encontremos desarrollando una aplicación y llegue el momento que decidamos tomar todos sus archivos y migrarlos ya sea al ambiente de producción, de prueba o simplemente probar su comportamiento en diferentes plataformas y servicios. Para situaciones de este estilo existen herramientas que, entre otras cosas, nos facilitan el embalaje y despliegue de la aplicación, es aquí donde entra en juego Docker.

Esta herramienta nos permite crear lo que ellos denominan contenedores, lo cual son aplicaciones empaquetadas auto-suficientes, muy livianas que son capaces de funcionar en prácticamente cualquier ambiente, ya que tiene su propio sistema de archivos, librerías, terminal, etc.

Docker es una tecnología contenedor de aplicaciones construida sobre LXC.

---

# **2. Requisitos.**

Vamos a usar en esta práctica una MV OpenSUSE. Nos aseguramos que tiene una versión del Kernel 3.10 o superior, para ello utilizamos el comando uname -a.

![imagen01](./images/01.png)

---

# **3. Instalación Y Primeras Pruebas.**

Ejecutamos como superusuario.

~~~
zypper in docker              # Instala docker
systemctl start docker, Inicia el servicio "docker daemon" hace el mismo efecto
docker version, Debe mostrar información del cliente y del servidor
usermod -a -G docker USERNAME # Añade permisos a nuestro usuario
~~~

![imagen02](./images/02.png)

![imagen03](./images/03.png)

Salimos de la sesión y volvemos a entrar con nuestro usuario.

Ejecutar con nuestro usuario para comprobar que todo funciona.

~~~
docker images           # Muestra las imágenes descargadas hasta ahora
docker ps -a            # Muestra todos los contenedores creados
docker run hello-world  # Descarga y ejecuta un contenedor con la imagen hello-world
docker images
docker ps -a
~~~

![imagen04](./images/04.png)

---

# **4. Configuración De La Red.**

Habilitamos el acceso a la red externa a los contenedores

Si queremos que nuestro contenedor tenga acceso a la red exterior, debemos activar la opción IP_FORWARD (net.ipv4.ip_forward). Lo podemos hacer en YAST.

Para openSUSE13.2 (cuando el método de configuracion de red es Wicked). Yast -> Dispositivos de red -> Encaminamiento -> Habilitar reenvío IPv4

![imagen05](./images/05.png)

Reiniciamos el equipo para que se apliquen los cambios.

---

# **5. Crear Un Contenedor Manualmente.**

Nuestro SO base es OpenSUSE, vamos a crear un contenedor Debian8, y dentro instalaremos Nginx.

## **5.1. Crear Una Imagen.**

~~~
docker images, vemos las imágenes disponibles localmente.
docker search debian, buscamos en los repositorios de Docker Hub contenedores con la etiqueta `debian`.
docker pull debian:8, descargamos contenedor `debian:8` en local.
docker images.
docker ps -a, vemos todos los contenedores.
docker ps, vemos sólo los contenedores en ejecución.
~~~

![imagen06](./images/06.png)

![imagen07](./images/07.png)

Vamos a crear un contenedor con el nombre `mv_debian` a partir de la imagen debian:8, y ejecutaremos el siguiente comando.

docker run --name=mv_debian -i -t debian:8 /bin/bash.

![imagen08](./images/08.png)

Dentro del contenedor hacemos lo siguiente.

~~~
cat /etc/motd, comprobamos que estamos en Debian.
apt-get update.
apt-get install -y nginx,instalamos nginx en el contenedor.
apt-get install -y nano, instalamos editor nano en el contenedor.
/usr/sbin/nginx, iniciamos el servicio nginx.
ps -ef.
~~~

![imagen09](./images/09.png)

![imagen10](./images/10.png)

![imagen11](./images/11.png)

Creamos un fichero HTML (holamundo.html). Para ello utilizamos el comando echo "<p>Hola nombre-del-alumno</p>" > /var/www/html/holamundo.html.

![imagen12](./images/12.png)

Creamos tambien un script /root/server.sh con el contenido que vemos a continuación.

![imagen13](./images/13.png)

~~~
#!/bin/bash

echo "Booting Nginx!"
/usr/sbin/nginx &

echo "Waiting..."
while(true) do
  sleep 60
done
~~~

Hay que poner permisos de ejecución al script para que se pueda ejecutar.

Este script inicia el programa/servicio y entra en un bucle, para permanecer activo y que no se cierre el contenedor.

-----------------------------------------------------------------------------------------------

Ya tenemos nuestro contenedor auto-suficiente de Nginx, ahora debemos crear una nueva imagen con los cambios que hemos hecho, para esto abrimos otra ventana de terminal y busquemos el IDContenedor:

* docker ps.

Ahora con esto podemos crear la nueva imagen a partir de los cambios que realizamos sobre la imagen base.

* docker commit 7d193d728925 dvarrui/nginx. //names
* docker images.

Los estándares de Docker estipulan que los nombres de las imagenes deben seguir el formato nombreusuario/nombreimagen. Todo cambio que se haga en la imagen y no se le haga commit se perderá en cuanto se cierre el contenedor.

~~~
docker ps.
docker stop mv_debian, paramos el contenedor.
docker ps.
docker ps -a, vemos el contenedor parado.
docker rm IDcontenedor, eliminamos el contenedor.
docker ps -a.
~~~

## **5.2. Crear Contenedor.**

Tenemos una imagen con Nginx instalado, probraremos ahora Docker.

Iniciemos el contenedor de la siguiente manera.

~~~
docker ps
docker ps -a
docker run --name=mv_nginx -p 80 -t dvarrui/nginx /root/server.sh

~~~

Los mensajes muestran que el script server.sh está en ejecución. No paramos el programa.

Abrimos una nueva terminal.

docker ps, nos muestra los contenedores en ejecución.

Abrir navegador web y poner URL 0.0.0.0.:NNNNNN. De esta forma nos conectaremos con el servidor Nginx que se está ejecutando dentro del contenedor. También ponemos 0.0.0.0/holamundo.html y vemos que nos muestra el html que creamos anteriormente.

Paramos el contenedor y lo eliminamos.

~~~
docker ps.
docker stop mv_nginx.
docker ps.
docker ps -a.
docker rm mv_nginx.
docker ps -a.
~~~

Como ya tenemos una imagen docker, podemos crear nuevos contenedores cuando lo necesitemos.

---

-----------------------------------------------------------------------------------------------

# **6. Crear Un Contenedor Con Dockerfile.**

Ahora vamos a conseguir el mismo resultado del apartado anterior, pero usando un fichero de configuración, llamado Dockerfile.

## **6.1. Comprobaciones Iniciales.**

~~~
docker images
docker ps
docker ps -a
~~~

![imagen20](./images/20.png)

## **6.2. Preparar Ficheros.**

Creamos el directorio /home/nombre-alumno/docker20, ponemos dentro los siguientes ficheros.

![imagen21](./images/21.png)

Creamos el fichero Dockerfile con el siguiente contenido.

![imagen22](./images/22.png)

~~~
FROM debian:8

MAINTAINER noelia 1.0

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y nginx
RUN apt-get install -y vim

COPY holamundo.html /var/www/html
RUN chmod 666 /var/www/html/holamundo.html

COPY server.sh /root
RUN chmod +x /root/server.sh

EXPOSE 80

CMD ["/root/server.sh"]
~~~

![imagen23](./images/23.png)

Los ficheros server.sh y holamundo.html que vimos en el apartado anterior, tienen que estar en el mismo directorio del fichero Dockerfile.

## **6.3. Crear Imagen.**

El fichero Dockerfile contiene la información necesaria para contruir el contenedor, veamos:

~~~
cd /home/alumno/docker, entramos al directorio del Dockerfile
docker images, consultamos las imágenes disponibles
docker build -t dvarrui/nginx2 .  # Construye imagen a partir del Dockefile
                                  # OJO el punto es necesario
docker images                     # Debe aparecer nuestra nueva imagen
~~~

## **6.4. Crear Contenedor Y Comprobar.**

    A continuación vamos a crear un contenedor con el nombre mv_nginx2, a partir de la imagen dvarrui/nginx, y queremos que este contenedor ejecute el programa /root/server.sh.

docker run --name mv_nginx2 -p 80 -t dvarrui/nginx2 /root/server.sh

    Desde otra terminal hacer docker..., para averiguar el puerto de escucha del servidor Nginx.
    Comprobar en el navegador URL: http://localhost:PORTNUMBER
    Comprobar en el navegador URL: http://localhost:PORTNUMBER/holamundo.html

---

# **7. Migrar Las Imágenes De Docker A Otro Servidor.**

¿Cómo puedo llevar los contenedores docker a un nuevo servidor?

    Enlaces de interés

        https://www.odooargentina.com/forum/ayuda-1/question/migrar-todo-a-otro-servidor-imagenes-docker-397
        http://linoxide.com/linux-how-to/backup-restore-migrate-containers-docker/

Crear un imagen de contenedor:

    docker ps, muestra los contenedores que tengo en ejecución.
    docker commit -p 30b8f18f20b4 container-backup, grabar una imagen de nombre "container-backup" a partir del contenedor 30b8f18f20b4.
    docker imagescomprobar que se ha creado la imagen "container-backup".

Exportar imagen docker a fichero:

    docker save -o ~/container-backup.tar container-backup, guardamos la imagen "container-backup" en un fichero tar.

Importar imagen docker desde fichero:

    Nos llevamos el tar a otra máquina con docker instalado, y restauramos.
    docker load -i ~/container-backup.tar, cargamos la imagen docker a partir del fichero tar.
    docker images, comprobamos que la nueva imagen está disponible.

---

# **8. Limpiar.**

Cuando terminamos con los contedores y ya no lo necesitamos, es buena idea pararlos y/o destruirlos.

---