// https://docs.google.com/document/d/1VWjnxw1aOuve_oRyB55AU5LK3XDvln2uKEq_HnL3710/edit

class Isla {
	const property habitantes
}
object islaPajaro inherits Isla {
	method pajarosFuertes() = habitantes.filter{h => h.fuerza() > 50}
	
	method fuerzaDeLaIsla() = self.pajarosFuertes().sum{h => h.fuerza()}
	
	method manejoDeIra() = habitantes.map({h => h.tranquilizar()})
	method invasionCerditos(unaCantidad) {
		
	}	
}

class Pajaro {
	var property ira
	
	method enojarse() { ira *= 2 }
	
	method fuerza() = ira * 2
	
	method tranquilizar() { ira -= 5 }
}
class Rencoroso inherits Pajaro {
	var property cuantasVecesSeEnojo
	var property multiplicadorIra
	
	override method fuerza() { return ira * multiplicadorIra * cuantasVecesSeEnojo }
	
	override method enojarse() {
		super()
		cuantasVecesSeEnojo++
	}
}
object bomb inherits Pajaro {
	var property maxFuerza
	
	override method fuerza() = maxFuerza.min(super())
}
object chuck inherits Pajaro {
	var property velocidad
	
	override method fuerza() = 150.max(150 + 5 * (velocidad - 80))
	
	override method tranquilizar() { }
}
object matilda inherits Pajaro {
	const property huevos = []
	
	method fuerzaDeLosHuevos() = huevos.sum{huevo => huevo.peso()}
	
	override method fuerza() = super() + self.fuerzaDeLosHuevos()
	
	override method enojarse() {
		huevos.add(new Huevo(peso = 2))
	}
}

class Huevo {
	const property peso
}

object eventos {
	method manejoIra() {
		
	}
}