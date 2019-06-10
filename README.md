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

Por otra parte, se agrega un sensor de ultrasonido digital. Sin embargo, para medir distancia, es necesario generar un pulso de ancho igual a 8 us. Este pulso es generado por un pin configurado como salida en uno de los pmods disponibles en la fpga. Luego, en otro pin designado como "echo" se recibe la respuesta del sensor, que consiste en un pulso de ultrasonido generado por la señal reflejada frente a un obstaculo. Finalmente, para obtener distancia se mide el ancho del pulso recibido y se realiza la conversión necesaria.  

### Módulo de procesamiento

Este módulo está implementado sobre el IPcore Microblaze, el cual que genera un procesador con la lógica de la FPGA. Entre las especificaciones de diseño necesarias para correr el sistema se requirió por una parte, que el procesador tenga integrada una FPU (Floating-point Unit) con el objetivo de realizar distintas operaciones matematicas manteniendo la precisión en punto flotante, y por otra, que se encuentren habilitadas las interrupciones para poder comunicarse con los módulos de los sensores y también con el hardware que implementa el enlace via ethernet.

Los datos provenientes de Los sensores son almacenados en un buffer circular de tamaño igual a 20 muestras. Cuando se llena el buffer, se aplica un algoritmo bayesiano encargado de fusionar los datos.

#### Algoritmo de "sensor fusion"

Se implementa un algoritmo estocastico basado en el teorema de Bayes para fusionar la información proveniente de los dos sensores. Para el funcionamiento este algoritmo, se asume que las mediciones obtenidas por los dispositivos son de la forma:

<a href="https://www.codecogs.com/eqnedit.php?latex=z&space;=&space;x&space;&plus;&space;n" target="_blank"><img src="https://latex.codecogs.com/gif.latex?z&space;=&space;x&space;&plus;&space;n" title="z = x + n"/></a>

Donde z es la medición obtenida, x el valor real y n representa ruido aleatorio con una distribución gaussiana. Luego, la función de densidad condicional de z dado x será:

<a href="https://www.codecogs.com/eqnedit.php?latex=P(z|x)&space;=&space;k&space;\exp{\frac{1}{2}\left(\frac{x&space;-&space;z}{\sigma}\right)^{2}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(z|x)&space;=&space;k&space;\exp{\frac{1}{2}\left(\frac{x&space;-&space;z}{\sigma}\right)^{2}}" title="P(z|x) = k \exp{\frac{1}{2}\left(\frac{x - z}{\sigma}\right)^{2}}" /></a>

Entonces, es posible obtener la función de "likelyhood" (básicamente, representa la densidad de probabilidad para x dada la data obtenida), que es igual a la siguiente expresión:

<a href="https://www.codecogs.com/eqnedit.php?latex=L(z;x)&space;=&space;\exp{\frac{1}{2}\left(\frac{x&space;-&space;z}{\sigma}\right)^{2}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?L(z;x)&space;=&space;\exp{\frac{1}{2}\left(\frac{x&space;-&space;z}{\sigma}\right)^{2}}" title="L(z;x) = \exp{\frac{1}{2}\left(\frac{x - z}{\sigma}\right)^{2}}" /></a>

Luego, dadas las mediciones recolectadas desde dos sensores distintos z1 y z2, es posible aplicar el teorema de Bayes para obtener la función de densidad de probabilidad asociada a la distancia x:

<a href="https://www.codecogs.com/eqnedit.php?latex=P(x|z_{1},z_{2})&space;\propto&space;P(x)L(x;z_{1})L(x;z_{2})" target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(x|z_{1},z_{2})&space;\propto&space;P(x)L(x;z_{1})L(x;z_{2})" title="P(x|z_{1},z_{2}) \propto P(x)L(x;z_{1})L(x;z_{2})" /></a>

En este caso, se asume que no se tiene información previa sobre x, por lo que se asume que:

<a href="https://www.codecogs.com/eqnedit.php?latex=P(x)&space;=&space;1" target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(x)&space;=&space;1" title="P(x) = 1" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=P(x|z_{1},z_{2})&space;=&space;\exp{\frac{1}{2}\left(\frac{x&space;-&space;z_{1}}{\sigma_{1}}\right)^{2}}&space;\exp{\frac{1}{2}\left(\frac{x&space;-&space;z_{2}}{\sigma_{2}}\right)^{2}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(x|z_{1},z_{2})&space;=&space;\exp{\frac{1}{2}\left(\frac{x&space;-&space;z_{1}}{\sigma_{1}}\right)^{2}}&space;\exp{\frac{1}{2}\left(\frac{x&space;-&space;z_{2}}{\sigma_{2}}\right)^{2}}" title="P(x|z_{1},z_{2}) = \exp{\frac{1}{2}\left(\frac{x - z_{1}}{\sigma_{1}}\right)^{2}} \exp{\frac{1}{2}\left(\frac{x - z_{2}}{\sigma_{2}}\right)^{2}}" /></a>

Por lo que, es valor mas probable para x se encuentra al maximizar la función de densidad obtenida:

<a href="https://www.codecogs.com/eqnedit.php?latex=\hat{x}&space;=&space;\operatorname*{argmax}_x&space;P(x|z_{1},z_{2})" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\hat{x}&space;=&space;\operatorname*{argmax}_x&space;P(x|z_{1},z_{2})" title="\hat{x} = \operatorname*{argmax}_x P(x|z_{1},z_{2})" /></a>

Donde, al resolver la expresión para el valor x, se obtiene que la estimación final será:

<a href="https://www.codecogs.com/eqnedit.php?latex=\hat{x}&space;=&space;\frac{\frac{z_{1}}{\sigma_{1}^{2}}&space;&plus;&space;\frac{z_{2}}{\sigma_{2}^{2}}}{\frac{1}{\sigma_{1}^{2}}&space;&plus;&space;\frac{1}{\sigma_{2}^{2}}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\hat{x}&space;=&space;\frac{\frac{z_{1}}{\sigma_{1}^{2}}&space;&plus;&space;\frac{z_{2}}{\sigma_{2}^{2}}}{\frac{1}{\sigma_{1}^{2}}&space;&plus;&space;\frac{1}{\sigma_{2}^{2}}}" title="\hat{x} = \frac{\frac{z_{1}}{\sigma_{1}^{2}} + \frac{z_{2}}{\sigma_{2}^{2}}}{\frac{1}{\sigma_{1}^{2}} + \frac{1}{\sigma_{2}^{2}}}" /></a>

### Implementación de servidor TCP

La comunicación es realizada mediante un enlace ethernet de 100 mb/s. Sobre el procesador Microblaze se monta un servidor TCP/IP con ip local 192.168.1.10 que escucha en el puerto 7. Luego, para manejar solicitudes entrantes, se utilizan interrupciones sobre el flujo principal del programa que llaman a funciones tipo "callback", ya sea para recibir o enviar información a travez del socket. En este caso, se genera una solicitud cada vez que el o los clientes conectados envian un paquete TCP.

![ethernet](https://user-images.githubusercontent.com/6885419/59155764-91409b00-8a5e-11e9-85bc-cd3392414d2e.png)

### Diseño de interfaz para cliente

El cliente consiste en una interfaz que envía solicitudes al servidor TCP montado sobre la FPGA para recibir la información procesada. Además, se genera un gráfico en tiempo real, pudiendo comparar las mediciones del sensor infrarrojo, de ultrasonido y también el resultado de la fusión tomando en cuenta el algoritmo prsentado previamente.

## Pruebas realizadas

Se realizan distintas pruebas con la información recibida por el cliente conectado al servidor. En estas se puede observar un grafico en tiempo real por la distancia siendo monitoreada por desde el pc conectado, el cual recibe los datos a través de un enlace de 100mb/s sobre ethernet.

### AMbiente de pruebas

En la siguiente imagen se muestra el ambiente de pruebas utilizado. En este se levanta una plataforma sobre la cual se montan los sensores. Además se observa una placa de Arduino, sin embargo, esta solo es utilizada para alimentar al sensor de ultrasonido, que requiere 5V para funcionar, mientras que la FPGA solo entrega 3.3V.

<img src="https://user-images.githubusercontent.com/6885419/59172301-4f266080-8b15-11e9-9e9e-b6b73391960e.jpg" alt="imagen_pruebas" width="400"/>

### Buffer de 100 muestras sin limitar tiempo de muestreo

En esta prueba se puede observar la gráfica en tiempo real de las mediciones provenientes desde ambos sensores, así como el resultado procesado por el algoritmo de "sensor fusion".

![sensors_distance](https://user-images.githubusercontent.com/6885419/59168936-fdc2a500-8b05-11e9-9ba8-587b4f93f8a8.jpg)

La imagen muestra que cuando la entropía recibida del sensor de ultrasonido es alta (lo cual implica que se está recibiendo poca información desde este sensor debido a la alta variabilidad) en el rango que abarca desde 0 y 20, se nota que el algoritmo tiende a considerar más las mediciones del sensor infrarrojo, y por ende, no se experimentan las variaciones generadas en el sensor de ultrasonido. Luego entre los instantes 30 y 50, se observa que dado que ambos sensores se mantienen estables, las medidas del algoritmo equivalen a un promedio entre la información de los distintos dispositivos. Por ultimo, se considera el rango entre los instantes 75 y 90, donde se ve que cuando el sensor infrarrojo se vuelve inestable, se le da una mayor ponderación a la información proveniente del sensor de ultrasonido.

### Buffer de 1000 muestras sin limitar tiempo de muestreo

En este caso se varía el rango de tiempo que considera el gráfico en tiempo real desde 100 a 1000 muestras. Luego, en la imagen se pueden observar resultados similares al caso anterior.

![sensor_data1000](https://user-images.githubusercontent.com/6885419/59170205-94459500-8b0b-11e9-9a3e-06297c4b709d.jpg)

### Prueba de enlace de comunicación

Se utiliza como enlace ethernet un cable de largo igual a 10 metros. Luego, se monitoréa el tiempo que le toma al pc cliente enviar la solicidud de información y recibir las 3 mediciones con precisión en punto flotante. En la siguiente imagen se puede notar que en promedio el tiempo de respuesta es igual a 32 ms.

![link_meassure](https://user-images.githubusercontent.com/6885419/59171550-62373180-8b11-11e9-97c6-ff309e7dccb6.jpg)

Luego, esto se compara con el tiempo que toma hacer ping al servidor, viendo que los resultados obtenidos son consistentes.

![ping_meassure](https://user-images.githubusercontent.com/6885419/59171548-606d6e00-8b11-11e9-8b30-00480bfe35fb.PNG)
