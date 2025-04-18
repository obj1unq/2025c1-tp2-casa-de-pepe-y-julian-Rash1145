import cosas.* 

object casaDePepeYJulian {

    const property listaCompras = []
    var property cuentaActual = cuentaCorriente

    method saldoCuentaActual() {
      return cuentaActual.saldo()
    }

    method comprar(cosa) {
        listaCompras.add(cosa)
    }

    method comprarYPagar(cosa){
      self.comprar(cosa)
      cuentaActual.extraer(cosa.precio())
    }

    method compras() {
      return listaCompras 
    }

    method cantidadDeCosasCompradas() {
      return listaCompras.size()
    }

    method tieneAlgun(categoria){
       return listaCompras.any({compra => compra.categoria() == categoria})
    }

    method vieneDeComprar(categoria){
        return categoria == listaCompras.last().categoria()
    }

    method esDerrochona() {
      return listaCompras.sum({compra => compra.precio()}) >= 9000
    }

    method compraMasCara() {
      return listaCompras.max({compra => compra.precio()})
    }

    method comprados(categoria) {
      return listaCompras.filter({compra => compra.categoria() == categoria})
    }

    method malaEpoca() {
      return listaCompras.all({compra => compra.categoria().comida()})
    }
    
    method queFaltaComprar(lista){
        return lista.filter({cosa => not listaCompras.contains(cosa)})
    }

    method faltaComida() {
      return self.comprados(comida).size() < 2
    }

    method categoriasCompradas() {
      return listaCompras.map({compra => compra.categoria()}).asSet()
    }
}

object cuentaCorriente {

    var property saldo = 5000

    method validarExtraer(cantidad) {
      if (saldo < cantidad){
        self.error("No es posible extraer esa cantidad")
      }
    }

    method extraer(cantidad){
        self.validarExtraer(cantidad)
        saldo -= cantidad
    }

    method depositar(cantidad) {
      saldo += cantidad
    }
}

object cuentaConGastos {

    var property saldo = 0
    var property costoOperacion = 5

    method extraer(cantidad) {
      saldo -= cantidad
    }

    method puedeDepositar(cantidad) {
      if (cantidad > 1000){
        self.error("No puede depositar mas de 1000 pesos de una vez")
      }
    }

    method depositar(cantidad) {
      self.puedeDepositar(cantidad)
      saldo = saldo + cantidad - costoOperacion
    }
}