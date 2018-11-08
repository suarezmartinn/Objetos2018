object inmobiliaria {
	const property operacionesRealizadas = []
	const property empleados = []
	
	method realizarOperacion(operacion) {
		operacionesRealizadas.add(operacion)
	}
	
	method cancelarOperacion(operacion) {
		operacionesRealizadas.remove(operacion)
	}
	
	method mejorEmpleadoSegun(unCriterio) {
		empleados.max(unCriterio)
	}
}

class Operacion {
	var property vendedor
	var property cliente
	var property propiedad
	
	method reservarPropiedad(unCliente, unVendedor) {
		cliente = unCliente
		vendedor = unVendedor
	}
	
	method comision()
}

class Alquiler inherits Operacion {
	var property mesesContrato
	
	override method comision() = (mesesContrato * propiedad.valor()) / 50000
	
	method alquilar()
}

class Compra inherits Operacion {
	const property porcentajeComision = 1.5
	
	override method comision() = porcentajeComision * propiedad.valor() 
	
	method comprar()
}

class Inmueble {
	const property cantidadAmbientes
	const property metrosCuadrados
	var property tipoOperacion
	const property zona
	
	method valorBase()
	
	method valor() = self.valorBase() + zona.plus()
}

/* Yo habia hecho que Inmueble tenga un metodo abstracto valor() y sobreescribir su comportamiento en
 * cada una de las subclases, pero el problema de eso era que dentro de valor() había que hacer super(),
 * que lo que hacía era zona.plus() y si agregaba un nuevo tipo de propiedad y no definia su propio comportamiento
 * para valor este iba a terminar siendo zona.plus()  
 * 
 * Se puede agregar un metodo valorBase() las subclases de inmueble y valor pasaria a ser zona.plus() + self.valorBase() 
 * De esa manera, si agrego un nuevo tipo de inmueble y olvido ponerle un valorBase, el programa explotaría
 * y evitaría que el valor de un inmueble sea solo el valor de su zona.
 * Esto se conoce como template method, y es la mejor alternativa.*/

class Casa inherits Inmueble{
	var property valor
	
	override method valorBase() = valor
}

class Ph inherits Inmueble {
	override method valorBase() = 500000.max(14000 * metrosCuadrados)
}

class Departamento inherits Inmueble {
	override method valorBase() = 350000 * cantidadAmbientes
}

class Zona {
	var property plus
}

class Estado {
	method reservar(operacion, empleado, cliente) {
		throw new Exception("No se puede.")
	}
}

class Abierta inherits Estado {
	override method reservar(operacion, _empleado, _cliente) {
		operacion.estado(new Reservada(empleado = _empleado, cliente = _cliente))
	}
}