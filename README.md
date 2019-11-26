# Civitas

Civitas es una adaptación del juego Monopoly® de Hasbro, donde el objetivo es convertirse en el jugador más rico comprando y vendiendo propiedades y edificios.

El proyecto se implementa en Java y Ruby, para la asignatura de PDOO de 3. curso de Ingeniería Informática+ADE de la UGR (2019-20)

## Autores
* Andrés José García Macías
* José Mª Poblador Márquez

**Profesor responsable:** Prof. Dr. Francisco Velasco Anguita, LSI-UGR

## Descripción del juego
Civitas consiste en un tablero de 20 casillas, dado de 6 caras, casas, hoteles y tarjetas sorpresa. Pueden jugar de 2 a 4 jugadores.

### Transcurso del juego
Los jugadores comienzan en la casilla de SALIDA (0) con un saldo inicial de 7500. El primer jugador se elige aleatoriamente, luego el resto recibirán el turno hasta volver a empezar el ciclo.

En el turno, el jugador tira el dado y avanza lo que este indique. Al caer en la casilla, podrá comprar propiedades, pagar alquileres o impuestos, coger tarjetas sorpresa o ir a la cárcel.

### Fin del juego
El juego termina cuando alguien cae en bancarrota (llega a un saldo negativo). En ese caso, los jugadores restantes se ordenan por saldos. Resulta ganador el jugador con **mayor saldo restante**.

### Tablero. Casillas y títulos
Una casilla es una posición del tablero. Hay 20 casillas en el tablero y 7 tipos de casillas.
* Salida ×1
* Calles ×12
* Sorpresa ×3
* Juez ×1
* Cárcel ×1
* Impuesto ×1
* Parking ×1

#### Distribución
1. sección: **Salida, Calle, Sorpresa, Calle, Cárcel**
1. sección: **Calle, Calle, Sorpresa, Calle, Parking**
1. sección: **Calle, Calle, Sorpresa, Calle, Juez**
1. sección: **Calle, Calle, Impuesto, Calle, Calle**

Las calles tienen asociadas títulos de propiedad. Estos indican información sobre el precio de compra, factor de revalorización de la venta, precio base de alquiler, hipoteca base y nombre de la calle. Al comprar una calle, el jugador es _propietario_ de la casilla.

### Eventos de las casillas
#### Salida
Marca el inicio del tablero y del juego. Cada vez que el jugador pasa por esta casilla durante el juego, recibe un salario de 1000 (a la cárcel se va directo y sin salario).
#### Calle
Cada vez que un jugador cae en una calle pueden ocurrir estos eventos:
* **Calle sin dueño:** se ofrece la posibilidad de comprarla y devenir su propietario. No se subasta si no se quiere comprar.
* **Calle con dueño**: se paga al propietario el alquiler correspondiente. No ocurre nada si el propio jugador es el propietario.
#### Sorpresa
El jugador levanta una tarjeta sorpresa y sigue sus instrucciones.
#### Juez
El juez envía al jugador directo a la cárcel, sin pasar por Salida y sin cobrar salario.
#### Cárcel
Aquí se ubican los jugadores encarcelados. Si un jugador pasa o cae en ella, está "solo de visita" _(JUST visiting)_
#### Impuesto
El jugador paga la cantidad indicada. ¡Hacienda somos todos!
#### Parking
No pasa absolutamente nada. Aquí paz, después gloria.
### Compraventa de propiedades
* **Compra:** Las propiedades se compran cuando se cae en sus respectivas casillas. Para comprar, la casilla debe no tener dueño y se debe tener saldo suficiente.
* **Venta:** Un jugador puede vender cualquier calle de su propiedad (no tiene que caer en dicha calle). El precio de venta es el que sigue:
```
PrecioVenta = PrecioCompra + (NumCasas + 5 * NumHoteles) * PrecioEdificar * FactorRevalorizacion
```
**Atención:** el factor puede ser negativo (devaluación)

Tras la venta, se demolen todas las edificaciones y la propiedad queda libre. 

Las propiedades no se venden a otros jugadores.

### Edificación de casas y hoteles
Un jugador en su turno puede edificar en cualquier casilla de su propiedad (aunque no esté posicionado sobre ella en ese momento). El número máximo tanto de casas como de hoteles que se pueden edificar en una misma casilla es 4. Es decir, como máximo habrá 8 edificios: 4 casas y 4 hoteles.

Para edificar una casa, deberá pagarse el precio de edificación que se especifica en el título de propiedad de la casilla. Los hoteles se edifican a cambio de 4 casas edificadas en la casilla más el coste de edificación que se indique en el título de propiedad. Sólo se podrá edificar cuando lo permita el saldo del jugador.

En Civitas no existe el concepto de _grupos de colores_ de Monopoly. Un jugador puede construir sobre cualquier casilla en cuanto sea propietario de esta.

### Alquiler
Cuando un jugador cae en una casilla con dueño, debe pagar un alquiler. El alquiler se calcula de esta manera:
```
PrecioAlquiler = AlquilerBase * (1 + (NumCasas * 0.5) + (NumHoteles * 2.5))
```
En el caso de que no tuviera dinero para pagar, entraría en bancarrota y acabaría el juego (no se le da opción a aumentar el saldo hipotecando o vendiendo propiedades).

El alquiler lo recibirá el dueño del título de propiedad de la casilla a no ser que **tenga la casilla hipotecada o se encuentre en la cárcel**, en cuyo caso el jugador que tiene el turno se ve exento del pago del alquiler.

### Hipotecas
Un jugador puede hipotecar alguna propiedad de la cual sea dueño, aunque no necesite el dinero. No tiene que estar en dicha casilla ni tiene que derruir sus edificios. Recibirá la siguiente cantidad:
```
CantidadRecibida = HipotecaBase * (1 + (numCasas * 0.5) + (numHoteles * 2.5))
```
De la misma manera se puede revocar la hipoteca. Devolverá lo recibido más un 10 % de interés.

### Cárcel
Un jugador irá a la cárcel si el juez o una tarjeta sorpresa lo ordenan, a no ser que posea una tarjeta de SALIRCARCEL (salvoconducto), la cual devolverá al mazo al usarse.

A la cárcel se va directamente. No se cobrará el salario de la Salida y se pierde el turno.

Para salir de la Cárcel, se puede pagar una fianza de 200 o tirar el dado y sacar un mínimo de 5. En caso contrario, el jugador pierde el turno.

### Sorpresas
Al caer en una casilla de Sorpresa se debe coger una tarjeta y seguir sus instrucciones. El mazo contiene 10 cartas y hay 6 tipos de sorpresas diferentes.

Tipo | Acción | Cantidad en el mazo
---------|----------|---------
 PAGARCOBRAR | Suma o resta el saldo indicado | ×2 (Positivo y negativo)
 IRCASILLA | Dirige al jugador a la casilla indicada | ×2
 PORCASAHOTEL | El jugador cobra o paga en función del nr. de edificaciones que posea | ×2 (Positivo y negativo)
 PORJUGADOR | El jugador recibe de o paga a, cada jugador, el saldo indicado | ×2 (Positivo y negativo)
 IRCARCEL | Envía al jugador a la cárcel | ×1
 SALIRCARCEL | Salvoconducto para evitar la cárcel. Se conserva hasta que sea necesaria y se devuelve al mazo. **No se comercia con ella.** | ×1

#### Referencias
 README basado en el documento _Civitas. Reglas del juego_ (`CivitasElJuego.pdf`).