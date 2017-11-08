___

# **Servidor LDAP - OpenSUSE.**

---

# **1. Servidor LDAP.**

Hay varias herramientas que implementan el protocolo LDAP, por ejemplo, OpenLDAP, 389-DC, Active Directory, etc.

En esta práctica vamos a instalar y configurar el Servidor LDAP con OpenLDAP.

## **1.1. Preparar La Máquina.**

Vamos a usar una MV OpenSUSE para montar nuestro servidor LDAP con la siguiente configuración.

* Nombre equipo: ldap-server20.
* Además en /etc/hosts añadiremos lo siguiente.

~~~
127.0.0.2   ldap-server20.curso1617   ldap-server20
127.0.0.3   noelia20.curso1617  noelia20
~~~

## **1.2. Instalación Del Servidor LDAP.**

Procedemos a la instalación del módulo Yast que sirve para gestionar el servidor LDAP (yast2-auth-server).

Hacemos lo siguiente:

    Ir a Yast -> Servidor de autenticación. Aparecerá como Authentication Server.
    Se requiere, además, instalar los paquetes: openldap2, krb5-server y krb5-client.
    Iniciar servidor LDAP -> Sí    
    Registrar dameon SLP -> No
    Puerto abierto en el cortafuegos -> Sí -> Siguiente
    Tipo de servidor -> autónomo -> Siguiente
    Configuración TLS -> NO habilitar -> Siguiente
    Tipo de BD -> hdb
    DN base -> dc=noelia20,dc=curso1617.
    DN administrador -> dn=Administrator
    Añadir DN base -> Sí
    Contraseña del administrador
    Directorio de BD -> /var/lib/ldap
    Usar esta BD predeterminada para clientes LDAP -> Sí -> Siguiente

No Habilitar kerberos.

Ahora haremos una serie de comprobaciones con los siguientes comandos.

* slaptest -f /etc/openldap/slapd.conf para comprobar la sintaxis del fichero do configuración.

* systemctl status slapd, para comprobar el estado del servicio.

* nmap localhost | grep -P '389|636', para comprobar que el servidor LDAP es accesible desde la red.

* slapcat para comprobar que la base de datos está bien configurada.

---

Podemos comprobar el contenido de la base de datos LDAP usando la herramienta gq. Esta herramienta es un browser LDAP.

Comprobar que tenemos creadas las unidades organizativas: groups y people.

## **1.3. Crear Usuarios Y Grupos LDAP.**

    Yast -> Usuarios Grupos -> Filtro -> LDAP.
    Crear los grupos piratas (Estos se crearán dentro de la ou=groups).
    Crear los usuarios pirata21, pirata21 (Estos se crearán dentro de la ou=people).

---

# **2. Autenticación.**

En este punto vamos a escribir información en el servidor LDAP.

## **2.1. Preparativos.**

Vamos a otra MV OpenSUSE. Cliente LDAP con OpenSUSE con la siguiente configuración.

* Nombre equipo: ldap-clientXX
* Dominio: curso1617
* Asegurarse que tenemos definido en el fichero /etc/hosts del cliente, el nombre DNS con su IP correspondiente.

~~~
127.0.0.2         ldap-clientXX.curso1617   ldap-clientXX
ip-del-servidor   ldap-serverXX.curso1617   ldap-serverXX   nombredealumnoXX.curso1617   nombrealumnoXX
~~~

Comprobamos el resultado con los siguientes comandos.

* nmap ldap-serverXX | grep -P '389|636', para comprobar que el servidor LDAP es accesible desde el cliente.

* Usar gq en el cliente para comprobar que se han creado bien los usuarios.
        File -> Preferencias -> Servidor -> Nuevo
        URI = ldap://ldap-serverXX
        Base DN = dc=davidXX,dc=curso1617

2.2 Instalar cliente LDAP

    Debemos instalar el paquete yast2-auth-client, que nos ayudará a configurar la máquina para autenticación. En Yast aparecerá como Authentication Client.

Configuración de la conexión

    Información extraída de https://forums.opensuse.org/showthread.php/502305-Setting-up-LDAP-on-13-2

    Yast -> Authentication client
    Hacemos click sobre el botón sssd.
        Aparece una ventana de configuración.
            config_file_version = 2
            services = nss, pam
            domains = LDAP, nombre-de-alumnoXX
        Escribir LDAP en la sección dominio.
        Pulsamos OK y cerramos la ventana.
    Creamos un nuevo dominios.
        domains = nombre-de-alumnoXX
        id_provider = ldap
        auth_provider = ldap
        chpass_provider = ldap
        ldap_schema = rfc2307bis
        ldap_uri = ldap://ldap-serverXX
        ldap_search base = dc=davidXX, dc=curso1617

Ver imagen de ejemplo:

opensuse-ldap-client-conf.png

Consultar el fichero /etc/sssd/sssd.conf para confirmar el valor de ldap_schema.

# A native LDAP domain
[domain/LDAP]
enumerate = true
cache_credentials = TRUE

id_provider = ldap
auth_provider = ldap
chpass_provider = ldap

ldap_uri = ldap://ldap-serverXX
ldap_search_base = dc=davidXX,dc=curso1617

    Vamos a la consola y probamos con

$ systemctl status sssd | grep domain
$ getent passwd pirata21
$ getent group piratas
$ id pirata21
$ finger pirata21
$ cat /etc/passwd | grep pirata21
$ su pirata21

HASTA AQUÍ ES LA ENTREGA DEL INFORME

Para el curso 2016-2017

    Default Re: Setting up LDAP on 13.2

    Did you ever resolve your secondary group issues? I'm seeing the same problem and have already changed ldap_schema to rfc2307bis.

    sorry for my late replay. Yes. I have resolved this issue. My solution was in /etc/sssd/sssd.conf

    comment out the lines

    # ldap_user_uuid = entryuuid
    # ldap_group_uuid = entryuuid

2.3 Crear usuarios y grupos en LDAP

Vamos a crear los usuarios y grupos en LDAP.

    Enlace de interés:

        Introducir datos de usuarios y grupos

    Yast -> Usuarios Grupos -> Filtro -> LDAP.
    Crear los grupos aldeanos y soldados (Estos se crearán dentro de la ou=groups).
    Crear los usuarios aldeano21, aldeano21, soldado21, soldado22 (Estos se crearán dentro de la ou=people).

2.4 Comprobación desde el servidor

    Vamos al servidor y comprobamos que se han creado los usuarios.

    Vemos un ejemplo de un árbol de datos en LDAP:

    gq-browser-users.png

    Comprobar mediante un browser LDAP (gq) la información que tenemos en la base de datos LDAP.

    Imagen de ejemplo:

    userPassword_empty-gq

    ldapsearch -x -L -u -t "(uid=nombre-del-usuario)", comando para consultar en la base de datos LDAP la información del usuario con uid concreto.

    Veamos imagen de ejemplo:

    userPassword_empty-ldapsearch

2.5 Autenticación desde el cliente

Con autenticacion LDAP prentendemos usar la máquina servidor LDAP, como repositorio centralizado de la información de grupos, usuarios, claves, etc. Desde otras máquinas conseguiremos autenticarnos (entrar al sistema) con los usuarios definidos no en la máquina local, sino en la máquina remota con LDAP. Una especie de Domain Controller.

    Comprobar que podemos entrar (Inicio de sesión) en la MV ldap-slaveXX usando los usuarios definidos en el LDAP.
    Capturar imagen de la salida de los siguientes comandos:

hostname -f                          # Muestra nombre de la MV actual
ip a                                 # Muestra datos de red de la MV actual
date                                 # Fecha actual
cat /etc/passwd |grep nombre-usuario # No debe existir este usuario en la MV local
finger nombre-usuario                # Consulta info del usuario
id nombre-usuario
su nombre-usuario

A. ANEXO

Podemos tener un problema con las claves si el método de encriptación de las claves del sistema operativo es diferente al utilizado en el servidor LDAP.
A.1 Cambiar el método de encriptación en el SO

Veamos ejemplo donde se establece el método de encriptación durante la instalación del SO.

opensuse-password-encryption-method.png

Veamos otro ejemplo donde podemos cambiar el método de encriptación de claves con el SO ya instalado, usando Yast.

opensuse-yast-password-encryption-method.png
A.2 Cambiar el método de encriptación en la base de datos LDAP

(Pendiente)
A.3 Configuración

    Seguir las instrucciones del siguiente enlace para crear el grupo LDAP aldeanos y dentro de éste los usuarios aldeano21 y aldeano22.
    Usar la herramienta gq para comprobar los datos del servidor LDAP.
    Comprobar que podemos entrar (Inicio de sesión) en la MV ldap-slaveXX usando los usuarios definidos en el LDAP remoto.
    Capturar imagen de la salida de los siguientes comandos:

hostname -f                          # Muestra nombre de la MV actual
ip a                                 # Muestra datos de red de la MV actual
date                                 # Fecha actual
cat /etc/passwd |grep nombre-usuario # No debe existir este usuario en la MV local
finger nombre-usuario                # Consulta info del usuario
id nombre-usuario
su nombre-usuario
