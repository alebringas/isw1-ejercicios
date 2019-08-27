"""
Ejercicio1: To the moon
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
        tipo_de_suelo = self.calcular_tipo_suelo(suelo)
        if tipo_de_suelo == "PIEDRA":
            self.excavador.excavar(HORARIO, 150, 10)
            self.excavador.cerrar()
            self.excavador.excavar(ANTIHORARIO, 150, 10)
        elif tipo_de_suelo == "POLVO":
            self.excavador.excavar(ANTIHORARIO, 100, 5)
            self.excavador.cerrar()
            self.excavador.excavar(HORARIO, 100, 5)
        else:
            self.excavador.excavar(HORARIO, 150, 5)
            self.excavador.cerrar()
            self.excavador.excavar(ANTIHORARIO, 100, 10)


"""
ToTheMoon-01
La funcion calcular_tipo_suelo ahora nos puede devolver:
"PIEDRA", "POLVO" o "INTERMEDIO".

Debido a esto, agregamos una nueva rama en 'tomar_muestra'
que actua como se nos pide
"""
