# Proyecto IPD432: Implementación de "sensor fusion" en fpga

El proyecto se basa en la utilización de una FPGA para recibir y procesar información proveniente desde distintos tipos de sensores.

## Estructura general

El diseño a alto nivel del sistema consiste en la implementación de un servidor TCP sobre el hardware de la FPGA, el cual mediante una interfaz, recibe información de los sensores. Luego, este servidor se comunica a través de la red para enviar los datos procesados al cliente que los solicite (cabe destacar que el servidor puede recibir multiples conexiones de forma concurrente).

## Diseño de interfaz con sensores

## Módulo de procesamiento

## Implementación de servidor TCP

## Diseño de interfaz para cliente

