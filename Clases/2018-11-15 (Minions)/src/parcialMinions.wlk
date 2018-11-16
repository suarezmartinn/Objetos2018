class Fruta {
	const property energia
}

/* Lo malo de esto es que puedo crear cualquier fruta con cualquier valor
 * const banana = new Fruta(energia = 10)
 * const bananaDos = new Fruta(energia = 99)
 * 
 * para remediar esto, puedo hacer lo siguiente:
 */

object frutaas {
	const banana = new Fruta(energia = 10)
	const manzana = new Fruta(energia = 5)
	const uva = new Fruta(energia = 1)
}
// de esta manera, puedo seguir creando nuevas frutas en tiempo de ejecucion para safar de algun problema
// y luego agregarla a mi object frutas.

class Empleado {
	var estamina
	var property estaminaMax
	var property rol
	var property tareasRealizadas
	
	method comer(unaFruta) { self.estamina(estamina + unaFruta.cantidad()) }
	method experiencia() = tareasRealizadas.size() * tareasRealizadas.sum{tarea => tarea.dificultad()}
	
	method realizarTarea(unaTarea)
	
	/* esta validacion sirve una vez que quedo instanciado un biclope, o sea que puedo instanciarlo con 20 de estamina
	 * y no tendría en cuenta que puede tener hasta 10 puntos.
	 * method estamina(unaCantidad) {
	 *	estamina = 10.min(unaCantidad)
	 * }
	 */
	 method estamina(unaCantidad) {
	 	estamina = estaminaMax.min(unaCantidad)
	 }
	 // para solucionar este problema tengo que definir el constructor, y a la hora de asignar estamina
	 // hacer uso del setter.
}

class Biclope inherits Empleado {
	
}

class Ciclope inherits Empleado {
	
}