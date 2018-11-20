// https://docs.google.com/document/d/15GSlTJnE2B4w43FAofSYShbJI0BdpWhsYiysEZFShoY/edit#

class Fiesta {
	const property lugar
	const property fecha
	const property invitados
}

class Invitado {
	var property edad
	var property disfraz
	var property personalidad
	var property tipo
	
	method puntuacionDelDisfraz() = disfraz.puntuacion(self)
	
	method esSexy() = personalidad.esSexy(self)
	
	method estaConformeConSuDisfraz() = disfraz.puntuacion(self) > 10 && tipo.estaConformeCon(self, disfraz)
}

// Disfraces y caracteristicas
class Disfraz {
	const property nombre
	const property fechaConfeccion
	const property caracteristicas
	
	method puntuacion(unaPersona) = caracteristicas.sum{ c => c.puntuacionQueOtorga(unaPersona, self) }
	
	// Metodos usados en tipos de persona
	method nombrePar() = nombre.length().even()
	method esNuevo() = (new Date() - fechaConfeccion) > 30 // no se si esto esta bien.
}



// Personalidades
object alegre {
	method esSexy(unaPersona) = false
}
object taciturna {
	method esSexy(unaPersona) = unaPersona.edad() < 30
}
object cambiante {
	var property personalidad
	
	method esSexy(unaPersona) = personalidad.esSexy(unaPersona)
}

// Tipos de persona
object caprichoso {
	method estaConformeCon(unaPersona, unDisfraz) = unDisfraz.nombrePar()
}
object pretencioso {
	method estaConformeCon(unaPersona, unDisfraz) = unDisfraz.esNuevo()
}
class Numerologo {
	var property numeroPreferido
	
	method estaConformeCon(unaPersona, unDisfraz) = unDisfraz.puntuacion(unaPersona) == numeroPreferido
}