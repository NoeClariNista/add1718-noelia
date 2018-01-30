___

# **Tareas Programadas.**

---

# **1. Windows.**

Vamos a hacer una tarea programada y una tarea diferida con Windows.

En Windows 10 para abrir el programador de tareas hacemos Panel de control -> Herramientas administrativas -> Programador de tareas.

![imagen01](./images/01.png)

![imagen02](./images/02.png)

## **1.1. Tarea Diferida.**

La tarea diferida se define para ejecutarse una sola vez en una fecha futura.

Vamos a programar una tarea diferida para que nos muestre un mensaje en pantalla.

![imagen03](./images/03.png)

![imagen04](./images/04.png)

![imagen05](./images/05.png)

![imagen06](./images/06.png)

![imagen07](./images/07.png)

![imagen08](./images/08.png)

![imagen09](./images/09.png)

![imagen10](./images/10.png)

![imagen11](./images/11.png)

## **1.2. Tarea Periódica.**

La tarea programada se define para ejecutarse periódicamente cada intervalo de tiempo.

Vamos a programar una tarea periódica para que nos muestre un mensaje en pantalla.

![imagen12](./images/12.png)

![imagen13](./images/13.png)

![imagen14](./images/14.png)

![imagen15](./images/15.png)

![imagen16](./images/16.png)

![imagen17](./images/17.png)

![imagen18](./images/18.png)

![imagen19](./images/19.png)

---

# **2. SO GNU/Linux.**

Vamos a hacer una tarea programada y una tarea diferida con GNU/Linux.

## **2.1. Tarea Diferida.**

Configurarmos nuestro usuario para que pueda ejecutar el comando at.

![imagen20](./images/20.png)

![imagen21](./images/21.png)

![imagen22](./images/22.png)

El servicio atd es el responsable de la ejecución de los comandos at. Para asegurarnos de que esté en ejecución.

~~~
Yast -> Servicios.
systemctl status atd.
~~~

![imagen23](./images/23.png)

![imagen24](./images/24.png)

![imagen25](./images/25.png)

![imagen26](./images/26.png)

Si el usuario no tuviera permisos para ejecutar at, consultamos los ficheros: `/etc/at.deny` y `/etc/at.allow`.

![imagen27](./images/27.png)

![imagen28](./images/28.png)

Vamos a programar una tarea diferida (comando at) que nos mostrará un mensaje en pantalla.

~~~
at, crea una tarea diferida.
atq, muestra los trabajos en cola.
at -c 1, muestra la configuración del trabajo ID=1.
atrm 1, elimina el trabajo con ID=1.
~~~

![imagen29](./images/29.png)

![imagen30](./images/30.png)

![imagen31](./images/31.png)

![imagen32](./images/32.png)

![imagen33](./images/33.png)

![imagen34](./images/34.png)

![imagen35](./images/35.png)

## **2.2. Tarea Periódica.**

Programamos una tarea periódica (crontab) que nos almacenara las fechas en un documento.

Para programar una tarea periódica tenemos estas formas.

Los usuarios usan el comando crontab para programar sus tareas.

El usuario root usa el fichero `/etc/crontab` para programar las tareas del sistema.

![imagen36](./images/36.png)

![imagen37](./images/37.png)

![imagen38](./images/38.png)

![imagen39](./images/39.png)

![imagen40](./images/40.png)

![imagen41](./images/41.png)

![imagen42](./images/42.png)

---
