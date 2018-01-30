___

# **Tareas Programadas.**

---

# **1. Windows.**

Vamos a hacer una tarea diferida y una tarea periódica con Windows.

En Windows 10 para abrir el programador de tareas iremos a Panel de control -> Herramientas administrativas -> Programador de tareas.

![imagen01](./images/01.png)

![imagen02](./images/02.png)

## **1.1. Tarea Diferida.**

La tarea diferida se define para ejecutarse una sola vez en una fecha futura.

Vamos a programar una tarea diferida para que nos permita abrir un fichero de texto en pantalla.

Realizamos una tarea básica. Le Ponemos el nombre a la tarea, como por ejemplo, Tarea Hola Mundo.

![imagen03](./images/03.png)

Queremos que se realice una vez.

![imagen04](./images/04.png)

Añadimos la fecha y hora de cuando queremos que se realice la tarea.

![imagen05](./images/05.png)

Queremos que se inicie un programa.

![imagen06](./images/06.png)

Dicho programa es un mensaje que saldrá en un documento TXT con el siguiente contenido.

![imagen07](./images/07.png)

Ese documento TXT lo ponemos en nuestra tarea.

![imagen08](./images/08.png)

![imagen09](./images/09.png)

Finalmente tenemos nuestra tarea hecha.

![imagen10](./images/10.png)

![imagen11](./images/11.png)

## **1.2. Tarea Periódica.**

La tarea programada se define para ejecutarse periódicamente cada intervalo de tiempo.

Vamos a programar una tarea periódica para apagar el equipo.

Realizamos una tarea básica. Le Ponemos el nombre a la tarea, como por ejemplo, Tarea Shutdown.

![imagen12](./images/12.png)

Queremos que se realice diariamente.

![imagen13](./images/13.png)

Añadimos la fecha y hora de cuando queremos que se realice la tarea.

![imagen14](./images/14.png)

Queremos que se inicie un programa.

![imagen15](./images/15.png)

Dicho programa es un scrip con el siguiente contenido.

![imagen16](./images/16.png)

Ese scrip lo ponemos en nuestra tarea.

![imagen17](./images/17.png)

![imagen18](./images/18.png)

Finalmente tenemos nuestra tarea hecha.

![imagen19](./images/19.png)

![imagen20](./images/20.png)

---

# **2. SO GNU/Linux.**

Vamos a hacer una tarea diferida y una tarea periódica con GNU/Linux.

## **2.1. Tarea Diferida.**

El servicio atd es el responsable de la ejecución de los comandos at. Para asegurarnos de que esté en ejecución hacemos lo siguiente.

~~~
Yast -> Servicios.
systemctl status atd.
~~~

![imagen21](./images/21.png)

![imagen22](./images/22.png)

![imagen23](./images/23.png)

![imagen24](./images/24.png)

Configuramos nuestro usuario para que pueda ejecutar el comando at.

![imagen25](./images/25.png)

![imagen26](./images/26.png)

![imagen27](./images/27.png)

Si el usuario no tuviera permisos para ejecutar at, consultamos los ficheros: `/etc/at.deny` y `/etc/at.allow`.

![imagen28](./images/28.png)

![imagen29](./images/29.png)

Vamos a programar una tarea diferida, comando at, que nos muestre un mensaje en pantalla.

Creamos un script que muestra un mensaje de aviso.

![imagen30](./images/30.png)

El contenido del script es el siguiente.

![imagen31](./images/31.png)

Instalamos zenity con el comando zypper install zenity.

![imagen32](./images/32.png)

Utilizamos el comando atq para comprobar que no hay ningún trabajo. Usamos el comando at 11:26 Jan 25 < scriptname.sh para programar una tarea diferida. Volvemos a utilizar el comando atq y vemos que hay una tarea diferida.

![imagen33](./images/33.png)

Vemos que nos sale el mensaje por pantalla.

![imagen34](./images/34.png)

Volvemos a utilizar el comando atq para que nos muestre que no hay trabajos en cola.

![imagen35](./images/35.png)

## **2.2. Tarea Periódica.**

Programamos una tarea periódica (crontab) que nos almacenara las fechas en un documento.

Definir una tarea periódica (crontab) para apagar el equipo todos los días a una hora/minuto determinada.

Para programar una tarea periódica tenemos estas formas.

Los usuarios usan el comando crontab para programar sus tareas.

El usuario root usa el fichero `/etc/crontab` para programar las tareas del sistema.

crontab -l, para consultar que no hay tareas programadas.

![imagen36](./images/36.png)

crontab -e, abre el editor para crear una nueva tarea periódica.

![imagen37](./images/37.png)

El contenido es el siguiente.

![imagen38](./images/38.png)

crontab -l, para consultar la tarea que tenemos programada.

![imagen39](./images/39.png)

Lo que se realizo se guarda en el siguiente fichero.

![imagen40](./images/40.png)

---
