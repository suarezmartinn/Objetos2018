class Inmobiliaria {
	const property empleados
	
	method mejorEmpleadoSegun(unCriterio) = empleados.max(unCriterio)	
}

class Empleado {
	const property operacionesCerradas
	const property reservas
	
	method reservarPara(unCliente, unaPropiedad) {
		if(unaPropiedad.reservadaPara() != null && unaPropiedad.reservadaPara() != unCliente)
			throw new Exception("La propiedad ya se encuentra reservada.")
		else
			unaPropiedad.reservadaPara(unCliente)
	}
	
	method concretarOperacionPara(unCliente, unaPropiedad) {
		if(unaPropiedad.reservadaPara() != null && unaPropiedad.reservadaPara() != unCliente)
			throw new Exception("La propiedad está reservada por otra persona.")
		else {
			
		}
	}
}

// Operaciones
class Alquiler {
	const property mesesAlquiler
	
	method comisionPor(unaPropiedad) = (mesesAlquiler * unaPropiedad.valor()).div(50000)
}
object venta {
	var property porcentaje = 0.015
	method comisionPor(unaPropiedad) = porcentaje * unaPropiedad.valor()
}

// Inmuebles
class Inmueble {
	const property ambientes
	const property metrosCuadrados
	const property publicadoPara
	var property zona
	var property reservadaPara
	
	method valorBase()
	method valor() = self.valorBase() + zona.plus()
}
class Casa inherits Inmueble {
	const valor
	
	override method valorBase() = valor
}
class PH inherits Inmueble {
	override method valorBase() = 500000.max(metrosCuadrados * 14000)
}
class Departamento inherits Inmueble {
	override method valorBase() = 350000 * ambientes
}