"""
Ejercicio0: To the moon
"""

HORARIO = 1
ANTIHORARIO = 2


class Suelo():
    def __init__(self, dureza, porosidad):
        self.dureza = dureza
        self.porosidad = porosidad


class Excavador():

    def excavar(self, sentido_giro, rpm, minutos):
        """
        Gira en sentido de 'sentido_giro' (horario o antihorario)
        a velocidad 'rpm"
        durante el tiempo en minutos 'minutos'
        """
        pass

    def cerrar(self):
        """ Cierra la pinza del brazo """
        pass


class SpaceW():

    def __init__(self):
        self.excavador = Excavador()

    def calcular_tipo_suelo(self, suelo):
        """ Se fija la dureza y la porosidad del suelo
            y determina si es el de piedra o polvo """
        pass

    def tomar_muestra(self, suelo):
        if self.calcular_tipo_suelo(suelo) == "PIEDRA":
            self.excavador.excavar(HORARIO, 150, 10)
            self.excavador.cerrar()
            self.excavador.excavar(ANTIHORARIO, 150, 10)
        else:
            self.excavador.excavar(ANTIHORARIO, 100, 5)
            self.excavador.cerrar()
            self.excavador.excavar(HORARIO, 100, 5)


"""
ToTheMoon-00
Modelamos la situacion de la siguiente forma:

El excavador funciona como herramienta usada por SpaceW.
Asumimos que SpaceW es el encargado de saber usar la herramienta.
El excavador no sabe nada sobre los tipos de suelo, solo opera como se le ordena.
Esto significa que tiene una funcion 'excavar' que recibe, un sentido de giro, una velocidad y un tiempo.
Ademas, tambien sabe como cerrar su pinza.

El suelo no sabe de que tipo es, sino que solo conoce su dureza y su porosidad. Conocer el tipo de suelo es responsabilidad de SpaceW.

SpaceW es quien tiene el excavador, y en 'tomar_muestra'. lo opera de forma adecuada dependiendo el tipo de suelo.
Es decir, tenemos un if que de acuerdo al suelo utiliza el excavador de diferentes maneras.

"""
