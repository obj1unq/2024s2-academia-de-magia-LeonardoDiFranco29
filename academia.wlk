
class Cosa {

	const property marca
	const property volumen
	const property esMagico
	const property esReliquia    

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

	method remover(cosa) {
		cosas.remove(cosa)
	}

	method validarEspecifico(cosa)

	method estaEnCosas(cosa) {
	  return cosas.any({cosa2 => cosa2 == cosa})
	}

	method tiene(cosa) = cosas.contains(cosa) 
	method puedeGuardar(cosa)

	method cosaMenosUtil() = cosas.min({ c => c.utilidad() })

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

	 override method utilidad() = super() + self.extras()
	
	 method extras() = if (self.sonTodasReliquias()) 2 else 0
	
	 method sonTodasReliquias() = cosas.all({ c => c.esReliquia() })
}

class BaulMagico inherits Baul {
	override method utilidad() = super() + self.cantidadDeCosasMagicas()
	
	method cantidadDeCosasMagicas() = cosas.count({ c => c.esMagico() })
	
	override method precio() = super() * 2
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

		method menosUtiles() = muebles.map({ m => m.cosaMenosUtil() }).asSet()

		method marcaMenosUtil() = self.menosUtiles().min({ c => c.utilidad() }).marca()

		method removerMenosUtilesNoMagicas() {
		self.validarRemover()
		self.lasCosasQueNoSonMagicasMenosUtiles().forEach(
			{ c => self.remover(c) }
		)
	}

	method validarRemover() {
	  if(muebles.size() < 3){
			self.error("No se puede tirar, no hay al menos 3 muebles")
	}
	}


	method lasCosasQueNoSonMagicasMenosUtiles() {
	  return self.menosUtiles().filter({ c => not c.esMagico() })
	}
	
	method remover(cosa) {
		self.cosaEstaGuardadaEn(cosa).remover(cosa)
	}

		
	method sacarMueble(mueble) {
	  muebles.remove(mueble)
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