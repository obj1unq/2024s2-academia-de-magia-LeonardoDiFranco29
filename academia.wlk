
class Cosa {

	var property marca
	var property volumen 
	var property esMagico
	var property reliquia     

}

class Mueble{
	const cosas = []

	method validarGuardar(cosa) {
		if (self.validarEspecifico(cosa) and not self.estaEnCosas(cosa))
		throw Exception
	}

	method validarEspecifico(cosa)

	method estaEnCosas(cosa) {
	  return cosas.any({cosa2 => cosa2 == cosa})
	}


}

class ArmarioConvencional inherits Mueble{
	var property cantidadMaxima 

	override validarEspecifico(cosa){
		if (not self.hayEspacio())
		throw Exception
	}

	method hayEspacio(){
		return cantidadMaxima - 1 == 0
	}

}

class GabineteMagico inherits Mueble{
	
	override validarEspecifico(cosa){
		if (not self.esMagico())
		throw execption
	}

}	

class Baul inherits Mueble{
	var property volumenMaximo
	 
	 method volumenUsado(){
		return cosas.sum()
	 }

	 override validarEspecifico(cosa){
		if(not self.volumenMaximo() - volumenUsado() > cosa.volumen())
		throw exception
	 }
}

class Academia {
	const muebles = []
}