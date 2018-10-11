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