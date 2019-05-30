class NaveEspacial {
	var velocidad = 0
	var direccion = 0
	var combustible = 0
	
	method velocidad(cuanto) { velocidad = cuanto }
	method acelerar(cuanto) { velocidad = (velocidad + cuanto).min(100000) }
	method desacelerar(cuanto) { velocidad = ( velocidad -= cuanto ).max(0) }
	
	method irHaciaElSol() { direccion = 10 }
	method escaparDelSol() { direccion = -10 }
	method ponerseParaleloAlSol() { direccion = 0 }
	
	method acercarseUnPocoAlSol() { direccion += 1 }
	method alejarseUnPocoDelSol() { direccion -= 1 }
	
	method cargarCombustible(cantidad) { combustible += cantidad }
	method descargarCombustible(cantidad) { combustible -= cantidad }
	
	method prepararViaje() {
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	method recibirAmenaza() {
		self.escapar()
		self.avisar()
	}
	method escapar()
	method avisar()
	
	method estaTranquila() {return
		combustible >= 4000 and
		velocidad <= 12000 
	}
}

class NaveBaliza inherits NaveEspacial {
	var baliza = ""
	
	method cambiarColorDeBaliza(colorNuevo) { baliza = colorNuevo }
	override method prepararViaje() {
		super()
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
	}
	override method escapar() { self.irHaciaElSol() }
	override method avisar() { self.cambiarColorDeBaliza("rojo") }
	
	override method estaTranquila() {return
		super() and
		baliza != "rojo"
	}
}

class NavePasajeros inherits NaveEspacial {
	var property pasajeros
	var property comida
	var property bebida
	
	method cargarComida(cuanto){ comida += cuanto }
	method descargarComida(cuanto) { comida -= cuanto }
	method cargarBebida(cuanto){ bebida += cuanto }
	method descargarBebida(cuanto){ bebida -= cuanto }
	
	override method prepararViaje() {
		super()
		self.cargarComida( 4 * pasajeros)
		self.cargarBebida( 6 * pasajeros)
		self.acercarseUnPocoAlSol()
	}
	override method escapar() { self.acelerar(velocidad) }
	override method avisar() {
		self.descargarComida(1)
		self.descargarBebida(2)
	}
}

class NaveCombate inherits NaveEspacial {
	var estaVisible = false
	var mensajes = #{}
	var misilesDesplegados = false
	
	method desplegarMisiles() { misilesDesplegados = true }
	method replegarMisiles() { misilesDesplegados = false }
	method misilesDesplegados() = misilesDesplegados
	
	method ponerseVisible() { estaVisible = true }
	method ponerseInvisible() { estaVisible = false }
	method estaInvisible() = estaVisible
	
	method emitirMensaje(mensaje){ mensajes.add(mensaje) }
	
	override method prepararViaje(){
		super()
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en misión")
	}
	method esEscueta(){
		return mensajes.all { m => m.size() < 30}
		// m => m not m.size() > 30
	}
	
	/*return not mensajes.any {
		m => m.size() > 30
	}*/
	
	override method avisar() {
		self.emitirMensaje("Amenaza recibida")
	}
	override method escapar() {
		2.times { i => self.acercarseUnPocoAlSol() }
	}
	override method estaTranquila() {return
		super() and
		not self.misilesDesplegados()
	}
}

class NaveHospital inherits NavePasajeros {
	var quirofanosPreparados = false
	
	method quirofanosPreparados() = quirofanosPreparados
	method prepararQuirofano() { quirofanosPreparados = true }
	
	override method recibirAmenaza() {
		super()
		self.prepararQuirofano()
	}
	override method estaTranquila() {return
		super() and
		not self.quirofanosPreparados()
		}
}

class NaveSigilosa inherits NaveCombate {
	override method escapar() {
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
	override method estaTranquila() {return
		super() and
		not self.estaInvisible()
	}
}