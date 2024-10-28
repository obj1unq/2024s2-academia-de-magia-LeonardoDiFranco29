
class Cosa {

	var property marca
	var property volumen 
	var property esMagico
	var property reliquia     

}

class Mueble{
	const cosas = #{}

	method validarGuardar(cosa) {
		if (self.validarEspecifico(cosa) and not self.estaEnCosas(cosa)){
			self.error("no se puede guardar")
		}
		 
	}

	method validarEspecifico(cosa)

	method estaEnCosas(cosa) {
	  return cosas.any({cosa2 => cosa2 == cosa})
	}

	method tiene(cosa) = cosas.contains(cosa) 


}

class ArmarioConvencional inherits Mueble{
	var property cantidadMaxima 

	override method validarEspecifico(cosa){
		if (not self.hayEspacio()){
			self.error("no hay espacio")
		}
		
	}

	method hayEspacio(){
		return cantidadMaxima - 1 == 0
	}

}

class GabineteMagico inherits Mueble{
	
	override method validarEspecifico(cosa){
		if (not self.esMagico()){
			self.error("no es magico")
		}
		
	}

}	

class Baul inherits Mueble{
	var property volumenMaximo
	 
	 method volumenUsado(){
		return cosas.sum({cosa => cosa.volumen()})
	 }

	 override method validarEspecifico(cosa){
		if(not self.volumenMaximo() - self.volumenUsado() > cosa.volumen()){
			self.error("supero el volumen maximo disponible")
		}
	 }
}

class Academia {
	const muebles = #{}

		method estaEnAcademia(cosa){
			return muebles.any({mueble => mueble.estaEnCosas(cosa)})
		}

		method cosaEstaGuardadaEn(cosa) {
		  return muebles.find({mueble => mueble.tiene(cosa)})
		}
}