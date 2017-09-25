# Clientes Ligeros.

# 1. Clientes Ligeros Con LTSP/Ubuntu.

El cliente ligero es un ordenador básico de dimensiones reducidas (1/3 de un PC normal), que realiza todas sus tareas contra otro más potente a través de la red, generalmente un servidor, adquiriendo la capacidad computacional de éste.

El servidor concentra todo el procesamiento y envía respuesta a través de la red a los Thin Clients. Cada usuario posee una cuenta de acceso que le permite iniciar una sesión en cualquier terminal, dando mayor flexibilidad.

# 2. Preparativos.

Usaremos 2 MVs para montar clientes ligeros con LTSP.

Para consultar o leer más información ir a su web oficial [LTSP](http://www.ltsp.org/).

# 3. Servidor LTSP.

## 3.1. Preparar La MV Server.

Creamos la MV del servidor con dos interfaces de red.

* La primera interfaz será la externa. Estará configurada en VirtualBox como adaptador puente y nos servirá para comunicarnos con Internet. La IP de esta interfaz de red deber ser estática y será 172.18.20.41, la máscara será de clase B, el gateway será 172.18.0.1 y Servidor DNS será 8.8.4.4.

* La segunda interfaz será la interna. Estará configurada en VirtualBox como red interna y nos servíra para conectarnos con los clientes ligeros. La IP de esta interfaz de red debe ser estática y debe estar en la misma red de los clientes, su IP sera 192.168.67.1 y su máscara será de clase C.

## 3.2. Instalación Del SSOO.

## 3.3. Instalar El Servicio LTSP.

# 4. Preparar MV Cliente.
