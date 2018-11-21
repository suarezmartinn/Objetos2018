// https://docs.google.com/document/d/15GSlTJnE2B4w43FAofSYShbJI0BdpWhsYiysEZFShoY/edit#

class Fiesta {
	const property lugar
	const property fecha
	const property invitados
	
	method esUnBodrio() = invitados.all{invitado => !invitado.estaConformeConSuDisfraz(self)}
	
	method mejorDisfraz() = invitados.max{invitado => invitado.puntuacionDelDisfraz(self)}.disfraz()
	
	method puedenIntercambiarDisfraces(unInvitado, otroInvitado) = self.ambosEstanInvitados(unInvitado, otroInvitado) && self.algunoNoEstaConforme(unInvitado, otroInvitado) && self.cambiandoDisfracesSeConforman(unInvitado, otroInvitado) 
	method estaInvitado(persona) = invitados.contains(persona)
	method ambosEstanInvitados(unInvitado, otroInvitado) = self.estaInvitado(unInvitado) && self.estaInvitado(otroInvitado)
	method algunoNoEstaConforme(unInvitado, otroInvitado) = !unInvitado.estaConformeConSuDisfraz(self) || !otroInvitado.estaConformeConSuDisfraz(self)
	method cambiandoDisfracesSeConforman(unInvitado, otroInvitado) = unInvitado.meConformoConElDisfrazDe(self, otroInvitado) && otroInvitado.meConformoConElDisfrazDe(self, unInvitado)
	
	method invitar(persona) {
		if(persona.tieneDisfraz() && !self.estaInvitado(persona)) invitados.add(persona)
		else throw new Exception("No se puede invitar a la persona " + persona.toString())
	}
}
object fiestaInolvidable inherits Fiesta {
	override method invitar(persona) {
		if (super(persona) && persona.esSexy() && persona.estaConformeConSuDisfraz(self)) {
			invitados.add(persona)
		}
		else throw new Exception("No se puede invitar a la persona " + persona.toString())
	}
}

class Invitado {
	var property edad
	var property disfraz
	var property personalidad
	var property tipo
	
	method puntuacionDelDisfraz(unaFiesta) = disfraz.puntuacion(unaFiesta, self)
	
	method esSexy() = personalidad.esSexy(self)
	
	method estaConformeConSuDisfraz(unaFiesta) = self.puntuacionDelDisfraz(unaFiesta) > 10 && tipo.estaConformeCon(unaFiesta, self, disfraz)
	
	// Metodo para caracteristicas de disfraz.
	method esViejo() = edad > 50
	
	// Metodo para intercambio de disfraces.
	method meConformoConElDisfrazDe(unaFiesta, otraPersona) {
		disfraz = otraPersona.disfraz()
		
		return self.estaConformeConSuDisfraz(unaFiesta)
	}
	
	method tieneDisfraz() = disfraz != null
}

// Disfraces y caracteristicas
class Disfraz {
	const property nombre
	const property fechaConfeccion
	const property caracteristicas
	
	method puntuacion(unaFiesta, unaPersona) = caracteristicas.sum{ c => c.puntuacionQueOtorga(unaFiesta, unaPersona, self) }
	
	// Metodos para tipos de persona
	method nombrePar() = nombre.length().even()
	method esNuevo() = (new Date() - fechaConfeccion) > 30
}

class Gracioso {
	const property nivelGracia
	
	method puntuacionQueOtorga(unaFiesta, unaPersona, unDisfraz) {
		if(unaPersona.esViejo()) return nivelGracia * 3
		return nivelGracia
	}
}
class Tobara {
	const property fechaCompra
	
	method puntuacionQueOtorga(unaFiesta, unaPersona, unDisfraz) {
		if((unaFiesta.fecha() - fechaCompra) >= 2) return 5
		return 3
	}
}
class Careta {
	const property puntuacion
	
	method puntuacionQueOtorga(unaFiesta, unaPersona, unDisfraz) = puntuacion
}
class Sexy {
	method puntuacionQueOtorga(unaFiesta, unaPersona, unDisfraz) {
		if(unaPersona.esSexy()) return 15
		return 2
	}
}

// Personalidades
object alegre {
	method esSexy(unaPersona) = false
}
object taciturna {
	method esSexy(unaPersona) = unaPersona.edad() < 30
}

// Tipos de persona
object caprichoso {
	method estaConformeCon(unaFiesta, unaPersona, unDisfraz) = unDisfraz.nombrePar()
}
object pretencioso {
	method estaConformeCon(unaFiesta, unaPersona, unDisfraz) = unDisfraz.esNuevo()
}
class Numerologo {
	var property numeroPreferido
	
	method estaConformeCon(unaFiesta, unaPersona, unDisfraz) = unDisfraz.puntuacion(unaFiesta, unaPersona) == numeroPreferido
}