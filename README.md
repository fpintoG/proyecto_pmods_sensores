# Proyecto IPD432: Implementación de "sensor fusion" en FPGA

El proyecto se basa en la utilización de una FPGA para recibir y procesar información proveniente desde distintos tipos de sensores.

## Arquitectura del sistema

El diseño a alto nivel del sistema consiste en la implementación de un servidor TCP sobre el hardware de la FPGA, el cual mediante una interfaz, recibe información de los sensores. Luego, este servidor se comunica a través de la red para enviar los datos procesados al cliente que los solicite (cabe destacar que el servidor puede recibir multiples conexiones de forma concurrente).

### Diseño de interfaz con sensores

Se busca leer dos sensores orientados a medir distancia.

#### Sensor  SHARP2YOA02

El primero es un sensor infrarrojo, cuya entrada es análoga, por lo que es necesario utilizar un ADC de 12 bits para recibir la señal digital en la FPGA. La señal obtenida es transformada a distancia utilizando la curva de distancia/voltaje proporcionada por el fabricante.

#### Sensor HC-SR04

Por otra parte, se agrega un sensor de ultrasonido digital. Sin embargo, para medir distancia, es necesario generar un pulso de ancho igual a 8 us. Este pulso es generado por un pin configurado como salida en uno de los pmods disponibles en la fpga. Luego, en otro pin designado como "echo" se recube la respuesta del sensor, que consiste en un pulso de ultrasonido generado por la señal reflejada frente a un obstaculo. Finalmente, para obtener distancia se mide el ancho del pulso recibido y se realiza la conversión necesaria.  

### Módulo de procesamiento

### Implementación de servidor TCP

### Diseño de interfaz para cliente

## Pruebas realizadas
