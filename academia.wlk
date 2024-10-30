
class Cosa {

	var marca
	var property volumen 
	var property esMagico
	var property esReliquia     

	method utilidad() = ((volumen + self.valorDeMagia()) + self.valorDeReliquia()) + marca.valor(self)
	
	method valorDeMagia() = if (esMagico) 3 else 0
	
	method valorDeReliquia() = if (esReliquia) 5 else 0

}

class Mueble{
	const cosas = #{}

	method validarGuardar(cosa) {
		if (self.validarEspecifico(cosa) and not self.estaEnCosas(cosa)){
			self.error("no se puede guardar")
		}
		 
	}

	method utilidad() {
	  return self.utilidadDeLasCosas() / self.precio()
	}

	method utilidadDeLasCosas() {
	  return cosas.sum({ c => c.utilidad() })
	}

	method precio()

	method agregar(cosa) {
	  cosas.add(cosa)
	}

	method validarEspecifico(cosa)

	method estaEnCosas(cosa) {
	  return cosas.any({cosa2 => cosa2 == cosa})
	}

	method tiene(cosa) = cosas.contains(cosa) 
	method puedeGuardar(cosa)

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

	method cantidadActual() {
		return cosas.size()
	}

	override method puedeGuardar(cosa) {
		return self.cantidadActual() + 1 <= cantidadMaxima
	}

	override method precio() = 5 * cantidadMaxima

}

class GabineteMagico inherits Mueble{
	
	const precio // porque se define para cada gabinete
	
	override method validarEspecifico(cosa){
		if (not cosa.esMagico()){
			self.error("no es magico")
		}
		
	}
	override method puedeGuardar(cosa) {
			return cosa.esMagico() 
	}

	override method precio() = precio

	
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
	 override method puedeGuardar(cosa){
		return self.volumenUsado() + cosa.volumen() <= self.volumenMaximo()
	 } 

	 override method precio() = volumenMaximo + 2
}

class Academia {
	const muebles = #{}

		method estaEnAcademia(cosa){
			return muebles.any({mueble => mueble.estaEnCosas(cosa)})
		}

		method cosaEstaGuardadaEn(cosa) {
		  return muebles.find({mueble => mueble.tiene(cosa)})
		}

		method puedeGuardarAcademia(cosa) {
		  return self.hayAlgunMuebleQuePuedeGuardar(cosa) and not self.estaEnAcademia(cosa)
		}

		method hayAlgunMuebleQuePuedeGuardar(cosa) {
		  return muebles.any({mueble => mueble.puedeGuardar(cosa)})
		}
		method enQueMuebleSePuedeGuardar(cosa) {
		  return muebles.filter({mueble => mueble.puedeGuardar(cosa)})
		}
		method guardar(cosa) {
		  self.validarGuardadoAcademia(cosa)
		  self.guardarEnMuebleDisponible(cosa)

		}
		method validarGuardadoAcademia(cosa) {
		  if(not self.puedeGuardarAcademia(cosa)){
			self.error("no se puede guardar" + cosa)
		  }
		}

		method guardarEnMuebleDisponible(cosa) {
			return self.enQueMuebleSePuedeGuardar(cosa).anyOne().agregar(cosa)
		}

		
		/*for each en el ultimo y filter en el anteultimo hacer una map con un min*/
}

object cuchuflito {
	method valor(cosa) = 0
}

object acme {
	method valor(cosa) = cosa.volumen() / 2
}

object fenix {
	method valor(cosa) = if (cosa.esReliquia()) 3 else 0
}