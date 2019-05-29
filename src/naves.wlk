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
}

class NaveBaliza inherits NaveEspacial {
	var baliza = ""
	
	method cambiarColorDeBaliza(colorNuevo) { baliza = colorNuevo }
}

class NavePasajeros inherits NaveEspacial {
	var property pasajeros
	var property comida
	var property bebida
}