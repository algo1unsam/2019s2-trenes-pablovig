/** First Wollok example */
class Tren	{
	
	var property vagones = []
	var property locomotoras = []
	
	method agregarVagon(vagon){vagones.add(vagon)}
	
	method agregarLocomotora(locomotora){locomotoras.add(locomotora)}
	
	method cuantosVagonesLivianos(){return vagones.count({vagon => vagon.pesoTotal()<2500})}
	
	method velocidadMax(){return locomotoras.map({locomotora => locomotora.velocidadMax()}).min()}
	
	method esEficiente(){return locomotoras.all({locomotora => locomotora.arrastreEficiente()})}
	
	method pesoMaxVagones(){return vagones.sum({vagon => vagon.pesoTotal()})}
	
	method arrastreUtilTotal(){return locomotoras.sum({locomotora => locomotora.arrastreUtil()})}
	
	method puedeMoverse(){return self.arrastreUtilTotal() >= self.pesoMaxVagones()}
	
	method faltaEmpuje(){return 0.max( self.pesoMaxVagones() - self.arrastreUtilTotal() )}
	
	
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

