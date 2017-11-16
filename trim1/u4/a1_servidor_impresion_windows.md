___

# **Servidor De Impresión En Windows.**

---

Necesitaremos 2 MV:

* 1 Windows Server.
* 1 Windows Cliente.

---

# **1. Impresora Compartida.**

## **1.1. Rol Impresión.**

Vamos al Servidor.

Instalamos rol/función de servidor de impresión. Incluimos impresión por internet.

## **1.2 Instalar Impresora.**

Vamos a conectarnos e instalar localmente una impresora al Servidor Windows Server, de modo que estén disponibles para ser accedidas por los Clientes del dominio.

En nuestro caso, dado que es posible de que no tengan una impresora física en casa y no es de mucho interés forzar la instalación de una impresora que no se tiene, vamos a instalar un programa que simule una impresora de PDF.

~~~
Impresoras virtuales PDF
PDF Creator: Para activar el modo AUTOSAVE vamos a Ajustes -> Autosave. Ahí configuramos carpeta destino.
~~~

Vamos a instalar PDFCreator. Vamos a la página oficial de [PDFCreator](http://pdfcreator.es/) para descargarlo.

PDFCreator es una utilidad completamente gratuita con la que podrás crear archivos PDF desde cualquier aplicación, desde el Bloc de notas hasta Word, Excel, etc. Este programa funciona simulando ser una impresora, de esta forma, instalando PDFCreator todas tus aplicaciones con opción para imprimir te permitirán crear archivos PDF en cuestión de segundos.

Para crear un archivo PDF no hará falta que cambies la aplicación que estés usando, simplemente ve a la opción de "imprimir" y selecciona "PDFCreator", en segundos tendrás creado tu archivo PDF. Rápido y fácil. La instalación de este programa no tiene dificultad simplemente elegir la opción "Instalación estándar".

Mientras se va instalando nos sale que PDFCreator requiere NET FrameWork v4.

## **1.3. Probar La Impresora En Local.**

Podemos probar la nueva impresora abriendo el Bloc de notas y creando un fichero, luego seleccionamos imprimir y como impresora predeterminada el PDFCreator. Cuando finalice el proceso se abrirá un fichero PDF en el PDFCreator con el resultado de la impresión.

## **1.4. Compartir Por Red.**

Compartimos la impresora del servidor. Como nombre del recurso compartido he utilizado PDFnoelia20.

Los recursos compartidos en el servidor incluye la impresora.

Ir a un Cliente Windows y probamos la impresora remota.

---

# **2. Acceso Web.**

Realizaremos una configuración para habilitar el acceso web a las impresoras del dominio.
2.1 Instalar característica impresión WEB

    Vamos al servidor.
    Si no lo hubiéramos instalado antes hay que instalar el servicio "Impresión de Internet".

2.1 Configurar impresión WEB

    Vamos al cliente.
    Debemos acceder a la dirección http://<nombre-del-servidor>/printers para que aparezca en nuestro navegador un entorno que permite gestionar las impresoras de dicho equipo, previa autenticación como uno de los usuarios del habilitados para dicho fin (por ejemplo el "Administrador"). Pincha en la opción propiedades y se muestra la siguiente pantalla:

Captura de pantalla 3 conectarimpresora

    Configuramos ahora la posibilidad de imprimir desde la red en esa impresora compartida utilizando la URL conocida, como se muestra en la siguiente pantalla:

Captura de pantalla 4: imred3
2.3 Comprobar desde el navegador

Vamos a realizar seguidamente una prueba sencilla en tu impresora de red a través del navegador pausa todos los trabajos en la impresora. Luego envía a imprimir en tu impresora compartida un documento del Bloc de notas. La siguiente pantalla muestra que la impresora esta en pausa y con el trabajo en cola de impresión.

Captura de pantalla 5: otraimp4

Finalmente pulsa en reanudar el trabajo para que tu documento se convierta a PDF. Comprobar que se puede imprimir desde un cliente Windows.

    Si tenemos problemas para acceder a la impresora de red desde el cliente Windows:

        Revisar la configuración de red de la máquina (Incluido la puerta de enlace)
        Reiniciar el servidor Windows Server que contiene la impresora compartida de red.

[EN CONSTRUCCIÓN]
3. Servidor de impresión en el servidor

    Configurar colas/prioridades
