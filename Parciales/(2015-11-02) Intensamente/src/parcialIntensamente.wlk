object riley {
	var property nivelFelicidad = 1000
	var property emocionDominante
	const property recuerdosDelDia = []
	var property pensamientosCentrales = #{}
	const property memoriaLargoPlazo = []
	
	method vivir(unEvento) = unEvento.vivitePara(self)
	method asentar(unRecuerdo) = unRecuerdo.asentarsePara(self)
	
	method agregarARecuerdosDelDia(unRecuerdo) = recuerdosDelDia.add(unRecuerdo)
	method agregaATusPensamientosCentrales(unRecuerdo) = pensamientosCentrales.add(unRecuerdo)
	method disminuirFelicidad(unPorcentaje) {
		// deberia controlar que el porcentaje esta entre 0 y 1 pero paja.
		if(self.nivelFelicidad() - (self.nivelFelicidad() * unPorcentaje) < 1)
			throw new Exception("El nivel de felicidad queda por debajo de 1.")
		else
			nivelFelicidad = nivelFelicidad - (nivelFelicidad * unPorcentaje)
	}
	method restaurarFelicidad(puntos) {
		nivelFelicidad = 1000.min(nivelFelicidad + puntos)
	}
	method recuerdosRecientesDelDia() = recuerdosDelDia.reverse().take(5)
	method pensamientosCentralesDificilesDeExplicar() = pensamientosCentrales.filter{p => p.dificilDeExplicar()}
	
	method negar(unRecuerdo) = emocionDominante.negar(unRecuerdo)
	method ocurre(unProceso) = unProceso.ocurrirEn(self)
	
	method desequilibrioHormonal() {
		self.disminuirFelicidad(0.15)
		pensamientosCentrales = pensamientosCentrales.drop(3)
	}
}

// Recuerdos
class Evento {
	const property descripcion
	const property fecha
	
	method vivitePara(unaPersona) = new Recuerdo(descripcion = descripcion, fecha = fecha, emocionDominante = unaPersona.emocionDominante()).vivirsePara(unaPersona)
}

class Recuerdo {
	const property descripcion
	const property fecha
	const property emocionDominante
	
	method vivirsePara(unaPersona) = unaPersona.agregarARecuerdosDelDia(self)
	method asentarsePara(unaPersona) = emocionDominante.asentarRecuerdo(unaPersona, self)
	
	method dificilDeExplicar() = descripcion.length() > 10
}

// Emociones
class Emocion {
	method asentarRecuerdo(unaPersona, unRecuerdo) { }
	
	method negar(unRecuerdo) = false
}
object alegria inherits Emocion {
	override method asentarRecuerdo(unaPersona, unRecuerdo) {
		if(unaPersona.nivelFelicidad() > 500) {
			unaPersona.agregaATusPensamientosCentrales(unRecuerdo)
		}
	}
	
	override method negar(unRecuerdo) = !unRecuerdo.emocionDominante() == self
}
object tristeza inherits Emocion {
	override method asentarRecuerdo(unaPersona, unRecuerdo) {
		unaPersona.agregaATusPensamientosCentrales(unRecuerdo)
		unaPersona.disminuiTuFelicidad(0.1)
	}
	
	override method negar(unRecuerdo) = !unRecuerdo.emocionDominante() == self
}
object disgusto inherits Emocion {
	
}
object furia inherits Emocion {

}
object temor inherits Emocion {
	
}

// Procesos mentales
class Proceso {
	method ocurrirEn(unaPersona)
}
object asentamiento inherits Proceso {
	override method ocurrirEn(unaPersona) = unaPersona.asentarRecuerdos(unaPersona.recuerdosDelDia())
}
object asentamientoSelectivo inherits Proceso {
	var palabraClave
	
	override method ocurrirEn(unaPersona) {
		unaPersona.asentarRecuerdos(unaPersona.filtrarRecuerdosDelDiaSegun(palabraClave))
	}
}
object profundizacion inherits Proceso {
	override method ocurrirEn(unaPersona) {
		unaPersona.agregarALaMemoriaALargoPlazo(unaPersona.recuerdosDelDiaNoCentrales().noLosNiegaElEstadoDeAnimo())
		}
}
object controlHormonal inherits Proceso {
	override method ocurrirEn(unaPersona){
		if(unaPersona.unPensamientoCentralEsTambienALargoPlazo() || unaPersona.losRecuerdosDelDiaCompartenEmocion())
			unaPersona.desequilibrioHormonal()
	}
}
object restauracionCognitiva inherits Proceso {
	override method ocurrirEn(unaPersona){
		unaPersona.restaurarFelicidad(100)
	}
}
object liberacionRecuerdosDelDia inherits Proceso {
	override method ocurrirEn(unaPersona) = unaPersona.liberaTusRecuerdosDelDia()
}