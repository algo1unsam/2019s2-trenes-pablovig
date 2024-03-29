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
	
	method puedeMoverse(){ return self.arrastreUtilTotal() >= self.pesoMaxVagones()}
	
	method faltaEmpuje(){return 0.max( self.pesoMaxVagones() - self.arrastreUtilTotal() )}
	
	method vagonMasPesado(){return vagones.max({vagon => vagon.pesoTotal()})}
	
	method formacionCompleja(){return (vagones.size()+locomotoras.size() > 20) or (self.pesoMaxLocomotoras()+self.pesoMaxVagones() > 10000) }
	
	method contieneLocomotora(locomotora){return locomotoras.contains(locomotora)}
}

class VagonPasajeros {
	
	var  largo
	
	var  ancho
	
	method personaPorAncho(){return if (ancho <= 2.5) 8 else 10}

	method pesoTotal(){return self.personaPorAncho()*largo*80}
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
	var property locomotorasSueltas = []
	
	
	method formacionEnDeposito(formacion){formaciones.add(formacion)}
	
	method locomotoraSuelta(locomotora){locomotorasSueltas.add(locomotora)}
	
	method vagonesMasPesados(){return formaciones.map({formacion => formacion.vagonMasPesado()}) }
	
	method NecesitaConductor(){ return formaciones.any({formacion => formacion.formacionCompleja()}) }
	
	method agregarAFormacion(formacion){if (!formacion.puedeMoverse()) self.agregaLocomotoraSuelta(formacion) }
	
	method locomotoraDisponible(formacion){return locomotorasSueltas.filter({locomotora => locomotora.arrastreUtil() > formacion.faltaEmpuje()}).first() }
	
	method agregaLocomotoraSuelta(formacion){ 
		
		const locomotoraDisponible = self.locomotoraDisponible(formacion)
		
		formacion.agregarLocomotora(locomotoraDisponible)
		
	}
	
}










