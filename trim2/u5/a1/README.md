___

# **Vagrant Y VirtualBox.**

---

# **1. Introducción.**

Vagrant es una herramienta para la creación y configuración de entornos de desarrollo virtualizados.

Originalmente se desarrolló para VirtualBox y sistemas de configuración tales como Chef, Salt y Puppet. Sin embargo desde la versión 1.1. Vagrant es capaz de trabajar con múltiples proveedores, como VMware, Amazon EC2, LXC, DigitalOcean, etc.

Aunque Vagrant se ha desarrollado en Ruby se puede usar en multitud de proyectos escritos en otros lenguajes.

---

# **2. Primeros Pasos.**

## **2.1. Instalar.**

La instalación debemos hacerla en una máquina real. En nuestra máquina real ya tenemos instalado Vagrant.

Comprobamos la versión actual de Vagrant con el comando vagrant version.

![imagen01](./images/01.png)

Comprobamos la versión actual de VirtualBox con el comando VBoxManage -v.

![imagen02](./images/02.png)

Para trabajar con Vagrant con MV de VirtualBox se tiene que comprobar que las versiones de ambos son compatibles entre sí.

## **2.2. Proyecto.**

Creamos un directorio para nuestro proyecto vagrant.

~~~
* mkdir mivagrant20.
* cd mivagrant20.
* vagrant init.
~~~

![imagen03](./images/03.png)

## **2.3. Imagen, Caja O Box.**

Ahora necesitamos obtener una imagen de un sistema operativo. Vamos a conseguir una imagen de un Ubuntu Precise de 32 bits.

Utilizamos el comando vagrant box list para listar las cajas/imágenes disponibles actualmente en nuestra máquina y podemos comprobar que no hay ninguna. Utilizamos el comando vagrant box add micaja20_ubuntu_precise32 http://files.vagrantup.com/precise32.box para crear una nueva caja. Utilizamos denuevo el comando vagrant box list.

![imagen04](./images/04.png)

Para usar una caja determinada en nuestro proyecto, modificamos el fichero Vagrantfile, dentro de la carpeta de nuestro proyecto.

![imagen05](./images/05.png)

Cambiamos la línea config.vm.box = "base" por config.vm.box = "micaja20_ubuntu_precise32".

![imagen06](./images/06.png)

## **2.4. Iniciar Una Nueva Máquina.**

Vamos a iniciar una máquina virtual nueva usando Vagrant.

~~~
* cd mivagrant20.
* vagrant up, comando para iniciar una nueva instancia de la máquina.
~~~

![imagen07](./images/07.png)

Podemos ver en VirtualBox que nuestra máquina esta en ejecución.

![imagen08](./images/08.png)

---

# **3. Configuración Del Entorno Virtual.**

## **3.1. Carpetas Sincronizadas.**

La carpeta del proyecto que contiene el Vagrantfile es visible para el sistema el virtualizado, esto nos permite compartir archivos fácilmente entre los dos entornos.

Para identificar las carpetas compartidas dentro del entorno virtual hacemos lo siguiente.

~~~
* vagrant up.
* vagrant ssh.
* ls /vagrant.
~~~

![imagen09](./images/09.png)

Esto nos mostrará que efectivamente el directorio /vagrant dentro del entorno virtual posee el mismo Vagrantfile que se encuentra en nuestro sistema anfitrión.

![imagen10](./images/10.png)

## **3.2 Redireccionamiento De Los Puertos.**

Cuando trabajamos con máquinas virtuales, es frecuente usarlas para proyectos enfocados a la web, y para acceder a las páginas es necesario configurar el enrutamiento de puertos.

Entramos en la MV e instalamos apache.

~~~
* vagrant ssh.
* apt-get install apache2.
~~~

![imagen11](./images/11.png)

Modificamos el fichero Vagrantfile, de modo que el puerto 4567 del sistema anfitrión sea enrutado al puerto 80 del ambiente virtualizado.

![imagen12](./images/12.png)

Añadimos config.vm.network :forwarded_port, host: 4567, guest: 80

![imagen13](./images/13.png)

Luego recargamos la MV ya se encuentra en ejecución con vagrant reload.

![imagen14](./images/14.png)

Para confirmar que hay un servicio a la escucha en 4567, desde la máquina real podemos ejecutar los siguientes comandos.

* nmap -p 4500-4600 localhost.

![imagen15](./images/15.png)

* netstat -ntap.

![imagen16](./images/16.png)

En la máquina real, abrimos el navegador web con el URL http://127.0.0.1:4567. En realidad estamos accediendo al puerto 80 de nuestro sistema virtualizado.

![imagen17](./images/17.png)

También podemos abrir el navegador web con el URL http://172.18.20.0:4567 y nos saldra el mismo resultado.

![imagen18](./images/18.png)

---

# **4. Suministro.**

Una de los mejores aspectos de Vagrant es el uso de herramientas de suministro. Esto es, ejecutar una serie de scripts durante el proceso de arranque del entorno virtual para instalar, configurar y personalizar un sin fin de aspectos del SO del sistema anfitrión.

* Apagamos la MV con el comando vagrant halt.

![imagen19](./images/19.png)

* Destruimos la MV para volver a empezar con el comando vagrant destroy.

![imagen20](./images/20.png)

## **4.1. Suministro Mediante Shell Script.**

Ahora vamos a suministrar a la MV un pequeño script para instalar Apache.

Creamos el script install_apache.sh, dentro del proyecto con el siguiente contenido.

![imagen21](./images/21.png)

~~~
#!/usr/bin/env bash

apt-get update
apt-get install -y apache2
rm -rf /var/www
ln -fs /vagrant /var/www
echo "<h1>Actividad de Vagrant</h1>" > /var/www/index.html
echo "<p>Curso201718</p>" >> /var/www/index.html
echo "<p>Noelia</p>" >> /var/www/index.html
~~~

![imagen22](./images/22.png)

Ponemos permisos de ejecución al script.

![imagen23](./images/23.png)

Vamos a indicar a Vagrant que debe ejecutar dentro del entorno virtual un archivo install_apache.sh.

![imagen24](./images/24.png)

Modificamos Vagrantfile y agregamos la siguiente línea a la configuración: `config.vm.provision :shell, :path => "install_apache.sh"`.

![imagen25](./images/25.png)

Volvemos a crear la MV para ello usamos el comando vagrant up.

![imagen26](./images/26.png)

Podremos notar, al iniciar la máquina, que en los mensajes de salida se muestran mensajes que indican cómo se va instalando el paquete de Apache que indicamos.

![imagen27](./images/27.png)

Para verificar que efectivamente el servidor Apache ha sido instalado e iniciado, abrimos un navegador web en la máquina real con URL http://127.0.0.1:4567.

![imagen28](./images/28.png)

## **4.2. Suministro Mediante Puppet.**

Modificamos el archivo el archivo Vagrantfile de la siguiente forma.

![imagen29](./images/29.png)

~~~
Vagrant.configure(2) do |config|
  ...
  config.vm.provision "puppet" do |puppet|
    puppet.manifest_file = "default.pp"
  end
 end
~~~

![imagen30](./images/30.png)

Creamos un fichero manifests/default.pp, con las órdenes/instrucciones puppet para instalar el programa nmap.

![imagen31](./images/31.png)

~~~
package { 'nmap':
  ensure => 'present',
}
~~~

![imagen32](./images/32.png)

Para que se apliquen los cambios de configuración con la MV encendida recargamos la configuración y volvemos a ejecutar la provisión para esto utilizamos los comandos vagrant reload y vagrant provision.

![imagen33](./images/33.png)

![imagen34](./images/34.png)

Probamos el comando nmap dentro de la máquina para ver que se instalo correctamente.

![imagen35](./images/35.png)

---

# **5. Nuestra Caja Personalizada.**

En este apartado vamos a crear nuestra propia caja/box personalizada a partir de una MV de VirtualBox.

## **5.1 Preparar La MV VirtualBox.**

Lo primero que tenemos que hacer es preparar nuestra máquina virtual con una configuración por defecto, por si queremos publicar nuestro Box, ésto se realiza para seguir un estándar y que todo el mundo pueda usar dicho Box.

Creamos una MV VirtualBox nueva.

Instalamos OpenSSH Server en la MV.

![imagen36](./images/36.png)

Creamos el usuario Vagrant, para poder acceder a la máquina virtual por SSH. A este usuario le agregamos una clave pública para autorizar el acceso sin clave desde Vagrant.

~~~
* useradd -m vagrant
* su vagrant
* mkdir .ssh
* wget https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -O .ssh/authorized_keys
* chmod 700 .ssh
* chmod 600 .ssh/authorized_keys
~~~

![imagen37](./images/37.png)

Poner clave vagrant al usuario vagrant y al usuario root.

![imagen38](./images/38.png)

![imagen39](./images/39.png)

Tenemos que conceder permisos al usuario vagrant para que pueda configurar la red, instalar software, montar carpetas compartidas, etc. para ello debemos configurar `/etc/sudoers` para que no nos solicite la password de root, cuando realicemos estas operación con el usuario vagrant.

![imagen40](./images/40.png)

Añadimos vagrant ALL=(ALL) NOPASSWD: ALL a `/etc/sudoers`.

![imagen41](./images/41.png)

Debemos asegurarnos que tenemos instalado las VirtualBox Guest Additions con una versión compatible con el host anfitrion. Para ello actualizamos las VirtualBox Guest Additions y vemos la información de las VirtualBox Guest Additions con el comando modinfo vboxguest.

![imagen42](./images/42.png)

![imagen43](./images/43.png)

## **5.2. Crear La Caja Vagrant.**

Una vez hemos preparado la máquina virtual ya podemos crear el box.

Vamos a crear una nueva carpeta mivagrant20conmicaja, para este nuevo proyecto vagrant. Ejecutamos vagrant init para crear el fichero de configuración nuevo.

![imagen44](./images/44.png)

Localizamos el nombre de nuestra máquina VirtualBox. El comando que utilizamos es VBoxManage list vms el cual nos lista las MV que tenemos.

![imagen45](./images/45.png)

Creamos la caja package.box a partir de la MV. Comprobamos que se ha creado la caja package.box en el directorio donde hemos ejecutado el comando.

![imagen46](./images/46.png)

Muestro la lista de cajas disponibles, pero sólo tengo 1 porque todavía no he incluido la que acabo de crear. Finalmente, añado la nueva caja creada por mí al repositorio de vagrant.

![imagen47](./images/47.png)

Modificamos el fichero de Vagrantfile para utilizar la caja que hemos creado.

![imagen48](./images/48.png)

Utilizo el comando vagrant up para iniciar una nueva instancia de la máquina.

![imagen49](./images/49.png)

Podemos ver en VirtualBox que nuestra máquina esta en ejecución.

![imagen50](./images/50.png)

Haciendo vagrant ssh nos conectamos sin problemas con la máquina.

![imagen51](./images/51.png)

---
