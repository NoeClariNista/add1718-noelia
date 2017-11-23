___

# **Servidor De Impresión En Windows.**

---

Necesitaremos 2 MVs.

* 1 Windows Server.

* 1 Windows Cliente.

---

# **1. Impresora Compartida.**

## **1.1. Rol Impresión.**

Vamos al Servidor. Concretamente al Panel de Administrador del Servidor.

![imagen01](./images/a1_servidor_impresion_windows/01.png)

Instalamos rol/función de Servidor de impresión. Incluimos impresión por internet.

Tenemos que ir a Administrar y vamos a Agregar roles y características.

![imagen02](./images/a1_servidor_impresion_windows/02.png)

El resto de pasos los realizamos como se pueden ver en las imágenes.

![imagen03](./images/a1_servidor_impresion_windows/03.png)

![imagen04](./images/a1_servidor_impresion_windows/04.png)

![imagen05](./images/a1_servidor_impresion_windows/05.png)

![imagen06](./images/a1_servidor_impresion_windows/06.png)

![imagen07](./images/a1_servidor_impresion_windows/07.png)

![imagen08](./images/a1_servidor_impresion_windows/08.png)

![imagen09](./images/a1_servidor_impresion_windows/09.png)

![imagen10](./images/a1_servidor_impresion_windows/10.png)

![imagen11](./images/a1_servidor_impresion_windows/11.png)

![imagen12](./images/a1_servidor_impresion_windows/12.png)

Finalmente terminamos la instalación del Servidor de impresión en Windows 2012 Server.

![imagen13](./images/a1_servidor_impresion_windows/13.png)

## **1.2. Instalar Impresora PDF.**

Vamos a conectarnos e instalar localmente una impresora al Servidor Windows Server, de modo que estén disponibles para ser accedidas por los Clientes del dominio.

En nuestro caso, dado que es posible de que no tengan una impresora física en casa y no es de mucho interés forzar la instalación de una impresora que no se tiene, vamos a instalar un programa que simule una impresora de PDF.

PDFCreator es una utilidad completamente gratuita con la que podrás crear archivos PDF desde cualquier aplicación, desde el Bloc de notas hasta Word, Excel, etc. Este programa funciona simulando ser una impresora, de esta forma, instalando PDFCreator todas tus aplicaciones con opción para imprimir te permitirán crear archivos PDF en cuestión de segundos.

Vamos a instalar PDFCreator. Vamos a la página oficial de [PDFCreator](https://pdfcreator.es/) para descargarlo y lo instalamos.

![imagen14](./images/a1_servidor_impresion_windows/14.png)

![imagen15](./images/a1_servidor_impresion_windows/15.png)

![imagen16](./images/a1_servidor_impresion_windows/16.png)

Mientras se va instalando nos sale que PDFCreator requiere NET FrameWork v4.

![imagen17](./images/a1_servidor_impresion_windows/17.png)

Finalmente terminamos la instalación del PDFCreator en Windows 2012 Server.

![imagen18](./images/a1_servidor_impresion_windows/18.png)

![imagen19](./images/a1_servidor_impresion_windows/19.png)

## **1.3. Probar La Impresora En Local.**

Para crear un archivo PDF no hará falta que cambies la aplicación que estés usando, simplemente ve a la opción de "imprimir" y selecciona "Impresora PDF", en segundos tendrás creado tu archivo PDF.

Podemos probar la nueva impresora abriendo el Bloc de notas y creando un fichero luego seleccionamos imprimir. Cuando finalice el proceso se abrirá un fichero PDF con el resultado de la impresión.

![imagen20](./images/a1_servidor_impresion_windows/20.png)

![imagen21](./images/a1_servidor_impresion_windows/21.png)

![imagen22](./images/a1_servidor_impresion_windows/22.png)

## **1.4. Compartir Por Red.**

Vamos al servidor.

Concretamente a Administración de impresión.

![imagen23](./images/a1_servidor_impresion_windows/23.png)

Vamos al Botón derecho, Propiedades, Compartir.

![imagen24](./images/a1_servidor_impresion_windows/24.png)

Como nombre del recurso compartido utilizar PDFnoelia20.

![imagen25](./images/a1_servidor_impresion_windows/25.png)

La siguiente imagen muestra los recursos compartidos en el servidor incluido la impresora.

![imagen26](./images/a1_servidor_impresion_windows/26.png)

Vamos al cliente.

Buscar recursos de red del Servidor. Si tarda en aparecer ponemos \\172.18.20.21 en la barra de navegación.

![imagen27](./images/a1_servidor_impresion_windows/27.png)

Seleccionar impresora -> botón derecho -> conectar.

![imagen28](./images/a1_servidor_impresion_windows/28.png)

Ya tenemos la impresora remota configurada en el cliente.

Probar la impresora remota. Podemos probar abriendo el Bloc de notas y creando un fichero luego seleccionamos imprimir. Cuando finalice el proceso se creará un fichero PDF en el directorio donde se encuentran todos los archivos de PDFCreator.

![imagen29](./images/a1_servidor_impresion_windows/29.png)

![imagen30](./images/a1_servidor_impresion_windows/30.png)

![imagen31](./images/a1_servidor_impresion_windows/31.png)

---

# **2. Acceso Web.**

Realizaremos una configuración para habilitar el acceso web a las impresoras del dominio.

## **2.1. Instalar Característica Impresión WEB.**

Vamos al Servidor.

![imagen32](./images/a1_servidor_impresion_windows/32.png)

El Servicio "Impresión de Internet" ya lo tenemos instalado porque lo instalamos desde el principio.

![imagen33](./images/a1_servidor_impresion_windows/33.png)

## **2.2. Configurar Impresión WEB.**

Vamos al Cliente.

Abrimos un navegador Web. Ponemos URL http://172.18.20.21/printers para que aparezca en nuestro navegador un entorno que permite gestionar las impresoras de dicho equipo, previa autenticación como uno de los usuarios del habilitados para dicho fin,por ejemplo, el "Administrador".

![imagen34](./images/a1_servidor_impresion_windows/34.png)

![imagen35](./images/a1_servidor_impresion_windows/35.png)

Pincha en la opción propiedades y se muestra la siguiente pantalla.

![imagen36](./images/a1_servidor_impresion_windows/36.png)

Agregamos la impresora en el cliente utilizando la URL, como se muestra en la siguiente pantalla.

![imagen37](./images/a1_servidor_impresion_windows/37.png)

![imagen38](./images/a1_servidor_impresion_windows/38.png)

![imagen39](./images/a1_servidor_impresion_windows/39.png)

![imagen40](./images/a1_servidor_impresion_windows/40.png)

## **2.3. Comprobar Desde El Navegador.**

Vamos a realizar seguidamente una prueba sencilla en tu impresora de red.

A través del navegador pausa todos los trabajos en la impresora.

Envía a imprimir en tu impresora compartida un documento del Bloc de notas. La siguiente pantalla muestra que la impresora esta en pausa y con el trabajo en cola de impresión.

![imagen41](./images/a1_servidor_impresion_windows/41.png)

![imagen42](./images/a1_servidor_impresion_windows/42.png)

![imagen43](./images/a1_servidor_impresion_windows/43.png)

![imagen44](./images/a1_servidor_impresion_windows/44.png)

Finalmente pulsa en reanudar el trabajo para que tu documento se convierta a PDF. Comprobar que se puede imprimir desde un cliente Windows.

![imagen45](./images/a1_servidor_impresion_windows/45.png)

![imagen46](./images/a1_servidor_impresion_windows/46.png)

---
