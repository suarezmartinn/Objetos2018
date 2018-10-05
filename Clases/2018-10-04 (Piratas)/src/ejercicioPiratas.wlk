// https://docs.google.com/document/d/1YPvqHIzJ7vNrFgu2EF244uPtXwQFT1oTUzuoIz6nFJ4/edit#

// VICTIMAS

class Barco {
	const property tripulantes = []
	var property mision
	
	method seTeAnima(unPirata) = unPirata.pasadoDeGrog()
	method elMasEbrio() = tripulantes.max{pirata => pirata.nivelEbriedad()}
	method esTemible() = mision.puedeRealizarla(self) && tripulantes.count{tripulante => mision.esUtil(tripulante)} >= 5
	method anclarEn(unaCiudad) {
		tripulantes.filter({tripulante => tripulante.monedas() > 0}).forEach({tripulante => tripulante.escabiar()})
		tripulantes.remove(self.elMasEbrio())
		unaCiudad.poblacion(unaCiudad.poblacion() + 1)
	}
	method elQueMasInvito() = tripulantes.max({ tripulante => tripulante.invitadosEntre(tripulantes)})
}

class Ciudad {
	method seTeAnima(unPirata) = unPirata.nivelEbriedad() > 50
}

// FIN VICTIMAS

// PIRATAS

class Pirata {
	const property objetos = []
	var property monedas = 0 // también puede ser un string "moneda" dentro de objetos y uso count(item == "moneda") para saber cuantas tiene
	var property nivelEbriedad = 0
	
	method tieneAlguno(os) = os.any{objeto => objetos.contains(objeto)}
	//method tieneObjeto(unObjeto) = self.objetos().contains(unObjeto)
	method pasadoDeGrog() = nivelEbriedad > 90
	method escabiar() {
		nivelEbriedad += 5
		monedas -= 1
	}
	method invitadosEntre(tripulantes) = tripulantes.count({ t => t.invitador(self)})
}

// FIN PIRATAS

// MISIONES

object busquedaDelTesoro {
	method esUtil(unPirata) = unPirata.monedas() <= 5 && unPirata.tieneAlguno(["grogXD", "brujula", "mapa"])
	method puedeRealizarla(unBarco) = unBarco.tripulantes().tieneAlguno(["llave de cofre"]) // tieneAlguno no está codificado
}

class ConvertirseEnLeyenda {
	const itemNecesario = ""
	
	method esUtil(unPirata) = unPirata.objetos().asSet().size() >= 10 && unPirata.tieneAlguno([itemNecesario]) // unPirata.objetos().asSet().size() = cantidadObjetosDistintos()
	method puedeRealizarla(unBarco) = true
}

class Saqueo {
	const victima = null
	const dineroNecesario = 0
	
	method esUtil(unPirata) = unPirata.monedas() < dineroNecesario && victima.seTeAnima(unPirata)
	method puedeRealizarla(unBarco) = victima.esVulnerableA(unBarco) //esVulnerableA no esta codificado
}

// FIN MISIONES