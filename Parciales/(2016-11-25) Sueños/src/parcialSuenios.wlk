// https://docs.google.com/document/d/1vtru1ysNDA5N3eVt33hD9IexzrL7rnQbEofYYrlp7yE/edit

class Persona {
	const property sueniosPendientes
	const property sueniosCumplidos
	var property felicidonios
	var property edad
	const property quiereEstudiar
	const property quiereGanar
	const property quiereViajarA
	var property tieneHijos
	var property tipo
	
	// Punto 1
	method cumplir(unSuenio) {
		if(unSuenio.puedeSerCumplidoPor(self)) {
			sueniosPendientes.remove(unSuenio)
			sueniosCumplidos.add(unSuenio)
			unSuenio.realizarsePara(self)
		}
		else throw new Exception("No puede cumplir el sueño.")
	}
	
	method noCumplio(unSuenio) = sueniosPendientes.contains(unSuenio)
	
	// Punto 4
	method esFeliz() = felicidonios > sueniosPendientes.sum{ s => s.felicidonios() }
	
	// Punto 5
	method esAmbiciosa() = (sueniosPendientes + sueniosCumplidos).filter{s => s.felicidonios() > 100}.size() > 3 // la parde de obtener los suenios con mas de 100 felicidonios era mejor delegarla en Suenio.
	
	// Punto 3
	method cumplirSuenioElegido() {
		const suenioElegido = tipo.elegirSuenio(sueniosPendientes)
		self.cumplir(suenioElegido)
	}
}
// Punto 1
class Suenio {
	const property felicidonios
	
	method puedeSerCumplidoPor(unaPersona)
	
	method realizarsePara(unaPersona) { }
}

class Viaje inherits Suenio {
	const property destino
	
	override method puedeSerCumplidoPor(unaPersona) = unaPersona.quiereViajarA() == destino
}
class Recibirse inherits Suenio {
	const property carrera
	
	override method puedeSerCumplidoPor(unaPersona) = unaPersona.quiereEstudiar() == carrera && unaPersona.noCumplio(self)
}
class Laburar inherits Suenio {
	const property quiereGanar
	
	override method puedeSerCumplidoPor(unaPersona) = unaPersona.quiereGanar() >= quiereGanar
}
object tenerUnHijo inherits Suenio { 
	override method puedeSerCumplidoPor(unaPersona) = true
	
	override method realizarsePara(unaPersona) {
		unaPersona.tieneHijos(true)
	}
}
class Adoptar inherits Suenio {
	const property cantidad
	
	override method puedeSerCumplidoPor(unaPersona) = !unaPersona.tieneHijos()
	
	override method realizarsePara(unaPersona) {
		unaPersona.tieneHijos(true)
	}
}

// Punto 2
class SuenioMultiple {
	const property sueniosParaCumplir
	
	method puedeSerCumplidoPor(unaPersona) = sueniosParaCumplir.all{suenio => suenio.puedeSerCumplidoPor(unaPersona)}
}

// Punto 3
//object realista {
//	method cumplirSuenioPara(unaPersona) {
//		unaPersona.cumplir(unaPersona.sueniosPendientes().max{s => s.felicidonios()})
//	}
//}
//object alocado {
//	method cumplirSuenioPara(unaPersona) {
//		unaPersona.cumplir(unaPersona.sueniosPendientes().anyOne())
//	}
//}
//object obsesivo {
//	method cumplirSuenioPara(unaPersona) {
//		unaPersona.cumplir(unaPersona.sueniosPendientes().first())
//	}
//}
// ERA MEJOR HACER LO SIGUIENTE:

object realista { // strategy stateless
	method elegirSuenio(sueniosPendientes) {
		sueniosPendientes.max { suenio => suenio.felicidonios() }
	}
}
object alocado { // strategy stateless
	method elegirSuenio(sueniosPendientes) {
		sueniosPendientes.anyOne()
	}
}
object obsesivo { // strategy stateless
	method elegirSuenio(sueniosPendientes) {
		sueniosPendientes.first()
	}
}