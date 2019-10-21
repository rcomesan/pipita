import wollok.game.*
import defines.*
import cancha.*

class Arco
{
	var imagen = "arco.png"
	var position
		
	method image() = imagen
	method position() = position
	
	method initialize()
	{
		game.addVisual(self)
	}

	method destroy()
	{
		game.removeVisual(self)
	}

	method esGol(_posPelota)
	{
		if (_posPelota.y() >= position.y())
		{
			if (_posPelota.x() == self.getPosPaloIzq()
				|| _posPelota.x() == self.getPosPaloDer())
			{
				game.sound("palo.ogg")
				return RESULTADO_ARCO_PALO	
			}
			else if (_posPelota.x() > self.getPosPaloIzq()
				&& _posPelota.x() < self.getPosPaloDer()
				&& _posPelota.y() > position.y())
			{
				cancha.getScore().incrementar(1)
				game.sound("gol.ogg")		
				return RESULTADO_ARCO_GOL
			}	
		}
		return RESULTADO_ARCO_NADA
	}
	
	method getPosPaloIzq()
	{
		return position.x()
	}
	
	method getPosPaloDer()
	{
		return position.x() + GOAL_TILES_WIDTH - 1
	}
}