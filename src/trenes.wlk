/** First Wollok example */
class Formacion	{
	
	var property vagones = []
	var property locomotoras = []
	
	method agregarVagon(vagon){vagones.add(vagon)}
	
	method agregarLocomotora(locomotora){locomotoras.add(locomotora)}
	
	method cuantosVagonesLivianos(){return vagones.count({vagon => vagon.pesoTotal()<2500})}
	
	method velocidadMax(){return locomotoras.map({locomotora => locomotora.velocidadMax()}).min()}
	
	method esEficiente(){return locomotoras.all({locomotora => locomotora.arrastreEficiente()})}
	
	method pesoMaxLocomotoras(){return locomotoras.sum({locomotora => locomotora.peso()})}
	
	method pesoMaxVagones(){return vagones.sum({vagon => vagon.pesoTotal()})}
	
	method arrastreUtilTotal(){return locomotoras.sum({locomotora => locomotora.arrastreUtil()})}
	
	method puedeMoverse(){return self.arrastreUtilTotal() >= self.pesoMaxVagones()}
	
	method faltaEmpuje(){return 0.max( self.pesoMaxVagones() - self.arrastreUtilTotal() )}
	
	method vagonMasPesado(){return vagones.max({vagon => vagon.pesoTotal()})}
	
	method formacionCompleja(){return (vagones.size()+locomotoras.size() > 20) or (self.pesoMaxLocomotoras()+self.pesoMaxVagones() > 10000) }

	
	
}

class VagonPasajeros {
	
	var pasajerosMax
	
	method cantPasajeros(vagon) {pasajerosMax=vagon.pasajerosMax()}
	
	method pesoTotal(){return pasajerosMax*80}
}

object anchoUtilMin {
	
	var property largo=10
	
	method pasajerosMax(){return largo*8}
	
}

object anchoUtilMax {
	
	var property largo=10
	
	method pasajerosMax(){return largo*10}
	
}

class VagonCarga{
	
	var property cargaMax
	
	method pesoTotal(){return cargaMax+160}
	
}

class Locomotora {
	
	var property peso
	var property velocidadMax
	var property pesoArrastre
	
	method arrastreEficiente(){return pesoArrastre>5*peso}
	
	method arrastreUtil(){return pesoArrastre-peso}
}

object deposito{
	
	var property formaciones = []
	
	var property vagonesPesados = []
	
	var property locomotorasSueltas = []
	
	var formacionElegida
	
	var locomotoraDisponible
	
	method vagonesMasPesados(){ formaciones.forEach({vagonesPesados.add({formacion => formacion.vagonMasPesado()})}) }
	
	method NecesitaConductor(){ return formaciones.any({formacion => formacion.formacionCompleja()}) }
	
	method agregarAFormacion(posicionDeFormacion){
		
		formacionElegida=formaciones.get(posicionDeFormacion)
		
		self.formacionPuedeMoverse()
		
	}
	
	method formacionPuedeMoverse(){if (formacionElegida.puedeMoverse()) self.agregaLocomotoraSuelta() }
	
	method estaDisponibleLocomotora(){locomotoraDisponible = locomotorasSueltas.filter({locomotora => locomotora.arrastreUtil() > formacionElegida.faltaEmpuje()}).first() }
	
	method agregaLocomotoraSuelta(){ 
		
		self.estaDisponibleLocomotora()
		
		formacionElegida.agregarLocomotora(locomotoraDisponible)
		
	}

	
}










