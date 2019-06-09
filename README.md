# Proyecto IPD432: Implementación de "sensor fusion" en FPGA

El proyecto se basa en la utilización de una FPGA para recibir y procesar información proveniente desde distintos tipos de sensores.

## Arquitectura del sistema

El diseño a alto nivel del sistema consiste en la implementación de un servidor TCP sobre el hardware de la FPGA, el cual mediante una interfaz, recibe información de los sensores. Luego, este servidor se comunica a través de la red para enviar los datos procesados al cliente que los solicite (cabe destacar que el servidor puede recibir multiples conexiones de forma concurrente).

![diagrama_general_proyecto](https://user-images.githubusercontent.com/6885419/59152844-659bc180-8a1a-11e9-9238-d148de9c8314.png)

### Diseño de interfaz con sensores

Se busca leer dos sensores orientados a medir distancia.

#### Sensor  SHARP GP2Y0A02YK0F

<img src="https://user-images.githubusercontent.com/6885419/59152999-f2944a00-8a1d-11e9-9633-cc5c80acd938.jpg" alt="drawing" width="200"/>

El primero es un sensor infrarrojo, cuya entrada es análoga, por lo que es necesario utilizar un ADC de 12 bits para recibir la señal digital en la FPGA. La señal obtenida es transformada a distancia utilizando la curva de distancia/voltaje proporcionada por el fabricante.

#### Sensor HC-SR04

<img src="https://user-images.githubusercontent.com/6885419/59153046-0c825c80-8a1f-11e9-9226-131cb57604fb.jpg" alt="drawing" width="200"/>

Por otra parte, se agrega un sensor de ultrasonido digital. Sin embargo, para medir distancia, es necesario generar un pulso de ancho igual a 8 us. Este pulso es generado por un pin configurado como salida en uno de los pmods disponibles en la fpga. Luego, en otro pin designado como "echo" se recube la respuesta del sensor, que consiste en un pulso de ultrasonido generado por la señal reflejada frente a un obstaculo. Finalmente, para obtener distancia se mide el ancho del pulso recibido y se realiza la conversión necesaria.  

### Módulo de procesamiento

Este módulo está implementado sobre el IPcore Microblaze, el cual que genera un procesador con la lógica de la FPGA. Entre las especificaciones de diseño necesarias para correr el sistema se requirió por una parte, que el procesador tenga integrada una FPU (Floating-point Unit) con el objetivo de realizar distintas operaciones matematicas manteniendo la precisión en punto flotante, y por otra, que se encuentren habilitadas las interrupciones para poder comunicarse con los módulos de los sensores y también con el hardware para la comunicación via ethernet.

Los datos provenientes de Los sensores son almacenados en un buffer circular de tamaño igual a 20 muestras. Cuando se llena el buffer, se aplica un algoritmo bayesiano encargado de fusionar los datos.

#### Algoritmo de "sensor fusion"

Se implementa un algoritmo estocastico basado en el teorema de Bayes para fusionar la información proveniente de los dos sensores. Para el funcionamiento este algoritmo, se asume que las mediciones obtenidas por los dispositivos son de la forma:

<a href="https://www.codecogs.com/eqnedit.php?latex=z&space;=&space;x&space;&plus;&space;n" target="_blank"><img src="https://latex.codecogs.com/gif.latex?z&space;=&space;x&space;&plus;&space;n" title="z = x + n"/></a>

Donde z es la medición obtenida, x el valor real y n representa ruido aleatorio con una distribución gaussiana. Luego, la función de densidad condicional de z dado x será:

<a href="https://www.codecogs.com/eqnedit.php?latex=P(z|x)&space;=&space;k&space;\exp{\frac{1}{2}\left(\frac{x&space;-&space;z}{\sigma}\right)^{2}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(z|x)&space;=&space;k&space;\exp{\frac{1}{2}\left(\frac{x&space;-&space;z}{\sigma}\right)^{2}}" title="P(z|x) = k \exp{\frac{1}{2}\left(\frac{x - z}{\sigma}\right)^{2}}" /></a>

Entonces, es posible obtener la función de "likelyhood" (básicamente, representa la densidad de probabilidad para x dada la data obtenida), que es igual a la siguiente expresión:

<a href="https://www.codecogs.com/eqnedit.php?latex=L(z;x)&space;=&space;\exp{\frac{1}{2}\left(\frac{x&space;-&space;z}{\sigma}\right)^{2}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?L(z;x)&space;=&space;\exp{\frac{1}{2}\left(\frac{x&space;-&space;z}{\sigma}\right)^{2}}" title="L(z;x) = \exp{\frac{1}{2}\left(\frac{x - z}{\sigma}\right)^{2}}" /></a>

Luego, dadas las mediciones recolectadas de dos sensores distintos z1 y z2, es posible aplicar el teorema de bayes para obtener la función de densidad de probabilidad para la distancia x:

<a href="https://www.codecogs.com/eqnedit.php?latex=P(x|z_{1},z_{2})&space;\propto&space;P(x)L(x;z_{1})L(x;z_{1})" target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(x|z_{1},z_{2})&space;\propto&space;P(x)L(x;z_{1})L(x;z_{1})" title="P(x|z_{1},z_{2}) \propto P(x)L(x;z_{1})L(x;z_{1})" /></a>

En este caso, se asume que no se tiene onformación previa sobre x, por lo que se asume que:

<a href="https://www.codecogs.com/eqnedit.php?latex=P(x)&space;=&space;1" target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(x)&space;=&space;1" title="P(x) = 1" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=P(x|z_{1},z_{2})&space;=&space;\exp{\frac{1}{2}\left(\frac{x&space;-&space;z_{1}}{\sigma}\right)^{2}}&space;\exp{\frac{1}{2}\left(\frac{x&space;-&space;z_{2}}{\sigma}\right)^{2}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(x|z_{1},z_{2})&space;=&space;\exp{\frac{1}{2}\left(\frac{x&space;-&space;z_{1}}{\sigma}\right)^{2}}&space;\exp{\frac{1}{2}\left(\frac{x&space;-&space;z_{2}}{\sigma}\right)^{2}}" title="P(x|z_{1},z_{2}) = \exp{\frac{1}{2}\left(\frac{x - z_{1}}{\sigma}\right)^{2}} \exp{\frac{1}{2}\left(\frac{x - z_{2}}{\sigma}\right)^{2}}" /></a>

Por lo que, es valor mas probable para x se encuentra al maximizar la función de densidad obtenida:

<a href="https://www.codecogs.com/eqnedit.php?latex=\hat{x}&space;=&space;\operatorname*{argmax}_x&space;P(x|z_{1}z_{2})" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\hat{x}&space;=&space;\operatorname*{argmax}_x&space;P(x|z_{1}z_{2})" title="\hat{x} = \operatorname*{argmax}_x P(x|z_{1}z_{2})" /></a>

Donde, al resolver la expresión para el valor x, se obtiene que la estimasión final será:

<a href="https://www.codecogs.com/eqnedit.php?latex=\hat{x}&space;=&space;\frac{\frac{z_{1}}{\sigma_{1}^{2}}&space;&plus;&space;\frac{z_{2}}{\sigma_{2}^{2}}}{\frac{1}{\sigma_{1}^{2}}&space;&plus;&space;\frac{1}{\sigma_{2}^{2}}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\hat{x}&space;=&space;\frac{\frac{z_{1}}{\sigma_{1}^{2}}&space;&plus;&space;\frac{z_{2}}{\sigma_{2}^{2}}}{\frac{1}{\sigma_{1}^{2}}&space;&plus;&space;\frac{1}{\sigma_{2}^{2}}}" title="\hat{x} = \frac{\frac{z_{1}}{\sigma_{1}^{2}} + \frac{z_{2}}{\sigma_{2}^{2}}}{\frac{1}{\sigma_{1}^{2}} + \frac{1}{\sigma_{2}^{2}}}" /></a>

### Implementación de servidor TCP

### Diseño de interfaz para cliente

## Pruebas realizadas
