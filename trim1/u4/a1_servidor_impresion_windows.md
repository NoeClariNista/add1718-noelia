___

# **Servidor De Impresión En Windows.**

---

Necesitaremos 2 MV.

* 1 Windows Server.

  * Nombre de equipo:

![imagen01](./images/a1_servidor_impresion_windows/01.png)

* 1 Windows Cliente.

  * Nombre de equipo:

![imagen02](./images/a1_servidor_impresion_windows/02.png)

---

# **1. Impresora Compartida.**

## **1.1. Rol Impresión.**

Vamos al Servidor.

![imagen03](./images/a1_servidor_impresion_windows/03.png)

Instalamos rol/función de servidor de impresión. Incluimos impresión por internet.

![imagen04](./images/a1_servidor_impresion_windows/04.png)

![imagen05](./images/a1_servidor_impresion_windows/05.png)

![imagen06](./images/a1_servidor_impresion_windows/06.png)

![imagen07](./images/a1_servidor_impresion_windows/07.png)

![imagen08](./images/a1_servidor_impresion_windows/08.png)

## **1.2 Instalar Impresora PDF.**

Vamos a conectarnos e instalar localmente una impresora al Servidor Windows Server, de modo que estén disponibles para ser accedidas por los Clientes del dominio.

En nuestro caso, dado que es posible de que no tengan una impresora física en casa y no es de mucho interés forzar la instalación de una impresora que no se tiene, vamos a instalar un programa que simule una impresora de PDF.

~~~
PDF Creator: Para activar el modo AUTOSAVE vamos a Ajustes -> Autosave. Ahí configuramos carpeta destino.
~~~

Vamos a instalar PDFCreator. Vamos a la página oficial de [PDFCreator](http://pdfcreator.es/) para descargarlo.

En PDFCreator, activar el modo AUTOSAVE vamos a Ajustes -> Autosave. Ahí configuramos carpeta destino.

PDFCreator es una utilidad completamente gratuita con la que podrás crear archivos PDF desde cualquier aplicación, desde el Bloc de notas hasta Word, Excel, etc. Este programa funciona simulando ser una impresora, de esta forma, instalando PDFCreator todas tus aplicaciones con opción para imprimir te permitirán crear archivos PDF en cuestión de segundos.

La instalación de este programa no tiene dificultad simplemente elegir la opción "Instalación estándar".

// Para crear un archivo PDF no hará falta que cambies la aplicación que estés usando, simplemente ve a la opción de "imprimir" y selecciona "PDFCreator", en segundos tendrás creado tu archivo PDF. Rápido y fácil. La instalación de este programa no tiene dificultad simplemente elegir la opción "Instalación estándar".

Mientras se va instalando nos sale que PDFCreator requiere NET FrameWork v4.

## **1.3. Probar La Impresora En Local.**

Podemos probar la nueva impresora abriendo el Bloc de notas y creando un fichero, luego seleccionamos imprimir y como impresora predeterminada el PDFCreator. Cuando finalice el proceso se abrirá un fichero PDF en el PDFCreator con el resultado de la impresión.

## **1.4. Compartir Por Red.**

Compartimos la impresora del servidor. Como nombre del recurso compartido he utilizado PDFnoelia20.

Los recursos compartidos en el servidor incluye la impresora.

Ir a un Cliente Windows y probamos la impresora remota.

--- (REVISAR PUNTO 1.)

# **2. Acceso Web.**

Realizaremos una configuración para habilitar el acceso web a las impresoras del dominio.

## **2.1. Instalar Característica Impresión WEB.**

Vamos al Servidor.

![imagen]

Nos aseguramos de tener instalado el servicio "Impresión de Internet".

![imagen]

## **2.2. Configurar Impresión WEB.**

Vamos al Cliente.

![imagen]

Debemos acceder a la dirección `http://hernandez20s/printers` para que aparezca en nuestro navegador un entorno que permite gestionar las impresoras de dicho equipo, previa autenticación como uno de los usuarios del habilitados para dicho fin (por ejemplo el "Administrador"). Pincha en la opción propiedades y se muestra la siguiente pantalla.

![imagen]

![imagen]

Configuramos ahora la posibilidad de imprimir desde la red en esa impresora compartida utilizando la URL conocida, como se muestra en la siguiente pantalla.

![imagen]

## **2.3. Comprobar Desde El Navegador.**

Vamos a realizar seguidamente una prueba sencilla en tu impresora de red a través del navegador pausa todos los trabajos en la impresora. Luego envía a imprimir en tu impresora compartida un documento del Bloc de notas. La siguiente pantalla muestra que la impresora esta en pausa y con el trabajo en cola de impresión.

![imagen]

Finalmente pulsa en reanudar el trabajo para que tu documento se convierta a PDF. Comprobar que se puede imprimir desde un cliente Windows.

![imagen]

---

# **3. Servidor De Impresión En El Servidor.**

Configurar cola de impresión con dos impresoras iguales.

Configurar colas/usuarios/prioridades.

---
