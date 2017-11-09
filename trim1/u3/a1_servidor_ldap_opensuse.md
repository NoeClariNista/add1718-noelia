___

# **Servidor LDAP - OpenSUSE.**

---

# **1. Servidor LDAP.**

Hay varias herramientas que implementan el protocolo LDAP, por ejemplo, OpenLDAP, 389-DC, Active Directory, etc.

En esta práctica vamos a Instalar y Configurar el Servidor LDAP con OpenLDAP.

## **1.1. Preparar La Máquina.**

Vamos a usar una MV OpenSUSE para montar nuestro servidor LDAP con la siguiente configuración.

* Nombre equipo: ldap-server20.

![imagen01](./images/a1_servidor_ldap_opensuse/01.png)

![imagen02](./images/a1_servidor_ldap_opensuse/02.png)

* Además en /etc/hosts añadiremos lo siguiente.

![imagen03](./images/a1_servidor_ldap_opensuse/03.png)

~~~
127.0.0.2   ldap-server20.curso1617   ldap-server20
127.0.0.3   noelia20.curso1617  noelia20
~~~

![imagen04](./images/a1_servidor_ldap_opensuse/04.png)

## **1.2. Instalación Del Servidor LDAP.**

Procedemos a la instalación del módulo Yast que sirve para gestionar el servidor LDAP (yast2-auth-server).

![imagen05](./images/a1_servidor_ldap_opensuse/05.png)

Hacemos lo siguiente:

Ir a Yast -> Servidor de autenticación. Aparecerá como Authentication Server.

![imagen06](./images/a1_servidor_ldap_opensuse/06.png)

Se requiere, además, instalar los paquetes: openldap2, krb5-server y krb5-client.

![imagen07](./images/a1_servidor_ldap_opensuse/07.png)

Iniciar servidor LDAP -> Sí    

![imagen08](./images/a1_servidor_ldap_opensuse/08.png)

Registrar dameon SLP -> No

![imagen09](./images/a1_servidor_ldap_opensuse/09.png)

Puerto abierto en el cortafuegos -> Sí -> Siguiente

![imagen10](./images/a1_servidor_ldap_opensuse/10.png)

Tipo de servidor -> autónomo -> Siguiente

![imagen11](./images/a1_servidor_ldap_opensuse/11.png)

Configuración TLS -> NO habilitar -> Siguiente

![imagen12](./images/a1_servidor_ldap_opensuse/12.png)

Tipo de BD -> hdb

![imagen13](./images/a1_servidor_ldap_opensuse/13.png)

DN base -> dc=noelia20,dc=curso1617.

![imagen14](./images/a1_servidor_ldap_opensuse/14.png)

DN administrador -> dn=Administrator

![imagen15](./images/a1_servidor_ldap_opensuse/15.png)

Añadir DN base -> Sí

![imagen16](./images/a1_servidor_ldap_opensuse/16.png)

Contraseña del administrador

![imagen17](./images/a1_servidor_ldap_opensuse/17.png)

Directorio de BD -> /var/lib/ldap

![imagen18](./images/a1_servidor_ldap_opensuse/18.png)

Usar esta BD predeterminada para clientes LDAP -> Sí -> Siguiente

![imagen19](./images/a1_servidor_ldap_opensuse/19.png)

No Habilitar kerberos.

![imagen20](./images/a1_servidor_ldap_opensuse/20.png)

Ahora haremos una serie de comprobaciones con los siguientes comandos.

* slaptest -f /etc/openldap/slapd.conf para comprobar la sintaxis del fichero do configuración.

![imagen21](./images/a1_servidor_ldap_opensuse/21.png)

* systemctl status slapd, para comprobar el estado del servicio.

![imagen22](./images/a1_servidor_ldap_opensuse/22.png)

* nmap localhost | grep -P '389|636', para comprobar que el servidor LDAP es accesible desde la red.

![imagen23](./images/a1_servidor_ldap_opensuse/23.png)

* slapcat para comprobar que la base de datos está bien configurada.

![imagen24](./images/a1_servidor_ldap_opensuse/24.png)

Podemos comprobar el contenido de la base de datos LDAP usando la herramienta gq. Esta herramienta es un browser LDAP.

![imagen25](./images/a1_servidor_ldap_opensuse/25.png)

![imagen26](./images/a1_servidor_ldap_opensuse/26.png)

Comprobar que tenemos creadas las unidades organizativas: groups y people.

![imagen27](./images/a1_servidor_ldap_opensuse/27.png)

![imagen28](./images/a1_servidor_ldap_opensuse/28.png)

![imagen29](./images/a1_servidor_ldap_opensuse/29.png)

![imagen30](./images/a1_servidor_ldap_opensuse/30.png)

## **1.3. Crear Usuarios Y Grupos LDAP.**

Yast -> Usuarios Grupos -> Filtro -> LDAP.

![imagen31](./images/a1_servidor_ldap_opensuse/31.png)

Crear los grupos piratas (Estos se crearán dentro de la ou=groups).

![imagen32](./images/a1_servidor_ldap_opensuse/32.png)

Crear los usuarios pirata21, pirata21 (Estos se crearán dentro de la ou=people).

![imagen33](./images/a1_servidor_ldap_opensuse/33.png)

![imagen34](./images/a1_servidor_ldap_opensuse/34.png)

---

# **2. Autenticación.**

En este punto vamos a escribir información en el servidor LDAP.

## **2.1. Preparativos.**

Vamos a otra MV OpenSUSE. Cliente LDAP con OpenSUSE con la siguiente configuración.

* Nombre equipo: ldap-client20.

![imagen35](./images/a1_servidor_ldap_opensuse/35.png)

* Dominio: curso1718.

![imagen36](./images/a1_servidor_ldap_opensuse/36.png)

* Asegurarse que tenemos definido en el fichero `/etc/hosts del cliente`, el nombre DNS con su IP correspondiente.

![imagen37](./images/a1_servidor_ldap_opensuse/37.png)

~~~
127.0.0.2         ldap-client20.curso1718   ldap-client20
172.18.20.31      ldap-server20.curso1718   ldap-server20   noelia20.curso1718   noelia20
~~~

![imagen38](./images/a1_servidor_ldap_opensuse/38.png)

Comprobamos el resultado con los siguientes comandos.

* nmap -Pn ldap-server20 | grep -P '389|636', para comprobar que el servidor LDAP es accesible desde el cliente.

![imagen39](./images/a1_servidor_ldap_opensuse/39.png)

* Usar gq en el cliente para comprobar que se han creado bien los usuarios.

![imagen40](./images/a1_servidor_ldap_opensuse/40.png)

File -> Preferencias -> Servidor -> Nuevo

![imagen41](./images/a1_servidor_ldap_opensuse/41.png)

URI = ldap://ldap-server20
Base DN = dc=noelia20,dc=curso1718

![imagen42](./images/a1_servidor_ldap_opensuse/42.png)

## **2.2 Instalar Cliente LDAP.**

Vamos a configurar de la conexión del cliente con el servidor LDAP.

Debemos instalar el paquete yast2-auth-client, que nos ayudará a configurar la máquina para autenticación.

![imagen43](./images/a1_servidor_ldap_opensuse/43.png)

Ir a Yast -> LDAP y cliente Kerberos.

![imagen44](./images/a1_servidor_ldap_opensuse/44.png)

Configurar como la imagen de ejmplo. Al final usamos la opción de Probar conexión

![imagen45](./images/a1_servidor_ldap_opensuse/45.png)

![imagen46](./images/a1_servidor_ldap_opensuse/46.png)

## **2.3 Comprobamos Desde El Cliente.**

Vamos a la consola y probamos con los siguientes comandos.

* getent passwd pirata21
* getent group piratas
* id pirata21.
* finger pirata21
* cat /etc/passwd | grep pirata21
* su pirata21

![imagen47](./images/a1_servidor_ldap_opensuse/47.png)

---

## **2.4. Autenticación.**

Con autenticacion LDAP prentendemos usar la máquina servidor LDAP, como repositorio centralizado de la información de grupos, usuarios, claves, etc. Desde otras máquinas conseguiremos autenticarnos (entrar al sistema) con los usuarios definidos no en la máquina local, sino en la máquina remota con LDAP. Una especie de Domain Controller.

Entrar en la MV cliente con algún usuario LDAP.

![imagen48](./images/a1_servidor_ldap_opensuse/48.png)

---
