/* · Los docentes cobran sueldos de forma diferente:
	- Los adjuntos cobran $1000 por cada curso asignado.
	- Los ordinarios cobran el doble que un adjunto (solo se duplica el valor base, no el plus).
	- Los ordinarios interinos, además, cobran un extra de $1000 si están en más de un curso.
	- Los ayudantes:
		· Rentados cobran $600 si están asignados al menos a un curso.
		· No rentados no cobran.
		· Juan, que es un ayudante rentado, cobra $200 más, porque conoce al dueño.
*/

class Curso {

	var property plus
}

/*
class Adjunto {
	const property cursos = []
	
	method sueldo() = cursos.size() * 1000 + cursos.sum{c => c.plus()}
	// cursos.size() * 1000 podria ser sueldoBase() y ese 1000 podría no estar hardcodeado
}

class Ordinario {
	const property cursos = []
	
	method sueldo() = 2 * cursos.size() * 1000 + cursos.sum{c => c.plus()}
}

class OrdinarioInterino {
	const property cursos = []
	
	method sueldo() = 2 * cursos.size() * 1000 + cursos.sum{c => c.plus()} + if(cursos.size() > 1) 1000 else 0 
}

class AyudanteRentado {
	const property cursos = []
	
	method sueldo() = if(cursos.isEmpty()) 0 else 600
}

class AyudanteAdHonorem {
	const property cursos = []
	
	method sueldo() = 0
}

object juan {
	const property cursos = []
	
	method sueldo() = if(cursos.isEmpty()) 0 else 600 + 200
}

Hasta acá es la forma de mierda.
*/

// Acá empieza la forma piola.

class Docente {
	const property cursos = []
	
	method sueldo()
} // Docente es una clase abstracta (no me interesa instanciarla, solo la tengo para fijar una idea y que otras clases
  // hereden de ella. sueldo() es un método abstracto. Los métodos de este tipo deben estar SÓLO en clases abstractas.

class Profesor inherits Docente {
	method sueldoBase() = cursos.size() * 1000
	method sueldoPlus() = cursos.sum{ c => c.plus() }
	
	override method sueldo() = self.sueldoBase() + self.sueldoPlus()
}

class Adjunto inherits Profesor { } // esto puede llegar a ser un codesmell, pero en este caso no lo es porque quiero tener la idea de Adjunto en mi dominio.

class Ordinario inherits Profesor {
	override method sueldoBase() = 2 * super() // como la forma de calcular sueldo() es igual, tengo que cambiar sueldoBase() y listo. 
}

class OrdinarioInterino inherits Ordinario {	
	override method sueldo() =  super() + if(cursos.size() > 1) 1000 else 0
}

class AyudanteRentado inherits Docente {	
	override method sueldo() = if(cursos.isEmpty()) 0 else 600
}

class AyudanteAdHonorem inherits Docente {	
	override method sueldo() = 0
}

object juan inherits AyudanteRentado {	
	override method sueldo() = super() + 200
}