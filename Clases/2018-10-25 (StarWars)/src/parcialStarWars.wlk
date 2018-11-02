class Planeta {
	const property habitantes = #{}
	
	method poder() = habitantes.sum{habitante => habitante.poder()} // a partir de esto considero que todo habitante es aquel que entiende el mensaje poder.
	
	method tieneUnaOrden() = habitantes.sortedBy({habitante => habitante.poder()}).take(3).sum({habitante => habitante.poder()}) >= self.poder() / 2
}

class Habitante { // En la resolución le pusieron Persona, porque consideran Habitante a todo aquel que interprete el metodo poder() (ver clase Planeta)
	const property valentia
	const property inteligencia
	
	method poder() = valentia + inteligencia
}

class Soldado inherits Habitante {
	const property equipamiento = []
	
	override method poder() = super() + equipamiento.sum{objeto => objeto.potencia()} 
}

class Maestro inherits Habitante {
	const property midiclorianos
	var lado
	var property antiguedad
	var property energiaSable	
}

object ladoOscuro {
	method poderSable(unSith) = unSith.energiaSable() * 2 + unSith.antiguedad()
}

object ladoLuminoso {
	method poderSable(unJedi) = unJedi.energiaSable() * unJedi.antiguedad()
}