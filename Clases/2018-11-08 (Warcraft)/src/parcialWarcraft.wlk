// Se podia resolver con composicion en raza y especialidad, o con herencia en alguna de las dos. En este caso se hereda la especialidad.

class Personaje {
	var property fuerza
	var property inteligencia
	const property raza
	
	method potencialOfensivo() = (fuerza * 10 + self.bonusOfensivo()) * raza.multiplicadorOfensivo()
	method bonusOfensivo()
	method esGroso() = raza.esInteligente(inteligencia) || self.esGrosoEnSuEspecialidad()
	method esGrosoEnSuEspecialidad()
}

class Guerrero inherits Personaje {
	override method bonusOfensivo() = 100
	override method esGrosoEnSuEspecialidad() = fuerza > 50
}
class Brujo inherits Personaje {
	override method bonusOfensivo() = 0
	override method esGrosoEnSuEspecialidad() = true
}
class Cazador inherits Personaje {
	var property mascota
	
	override method bonusOfensivo() = mascota.bonusOfensivo()
	override method esGrosoEnSuEspecialidad() = mascota.esLongeva()
}

class Mascota {
	const property fuerza
	var property edad
	const property tieneGarras
	
	method bonusOfensivo() {
		if(tieneGarras) return fuerza * 2
		
		return fuerza
	}
	method esLongeva() = edad > 10
}

class Ejercito {
	const personajes
	var property faccion
	
	/* tambien puedo hacerlo asi
	 * method faccion() = personajes.first().raza()
	 */
	
	constructor(_personajes) {
		if(! _personajes.all{pj => pj.raza() == _personajes.first().raza()}) {/*throw new ex...*/}
		personajes = _personajes
	}
	
	method invadi(localidad) {
		/* Esto lo puedo cambiar por localidad.tePuedoInvadir(self) para cumplir con el punto 4
		 * delegando responsabilidad en la ciudad, logrando asi que si agregan algo nuevo no tengo que modificar nada
		 * aca.
		if(!localidad.seBanca(self) || localidad.ejercito().faccion() == self.faccion()) {/*throw new ex... } 
		*/
		
		if(self.potencialOfensivoTotal() > localidad.potencialOfensivoTotal()) {
			/* localidad.seOcupadaPor(self) --> self = unEjercito
			 * 
			 * en seOcupadaPor() va toda la logica de la invasion de ciudades. 
			 *
			 * localidad.ejercito(self)
			 * 
			 */
		}
	}
	method potencialOfensivoTotal() = personajes.sum{pj => pj.potencialOfensivo()}
}