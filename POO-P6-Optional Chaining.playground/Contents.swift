import UIKit

//Optional chaining
class Person {
    var residence: Residence?
}

class Residence{
    var rooms = [Room]()
    var numberOfRooms : Int {
        return rooms.count
    }
    subscript(i: Int) -> Room{
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    var address: Address?
    
    
    func printNumberOfRooms(){
        print("El número de habitaciones es \(numberOfRooms)")
    }
}

class Room{
    let name: String
    init(name: String){
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildingIdentifier() -> String?{
        if let buildingNumber = buildingNumber, let street = street{
            return "\(buildingNumber), \(street)"
        }else if buildingName != nil{
            return buildingName
        } else{
            return nil
        }
    }
}



let edgar = Person()

if let roomCount = edgar.residence?.numberOfRooms{
    print("La casa de Edgar tiene \(roomCount) habitación(es)")
}else{
    print("Edgar no tiene casa")
}

func createAddress() -> Address{
    print("La función ha sido llamada")
    
    let someAddress = Address()
    someAddress.buildingNumber = "13"
    someAddress.street = "Calle de Platzi"
    
    return someAddress
}

edgar.residence?.address = createAddress()
edgar
edgar.residence?.printNumberOfRooms()

if edgar.residence?.printNumberOfRooms() != nil{
    print("He podido obtener el número de habitaciones")
} else{
    print("NO ha sido posible saber el número de habitaciones")
}


if (edgar.residence?.address = createAddress()) != nil {
    print("Ha sido posible configurar la dirección de Edgar")
} else {
    print("Seguimos sin saber donde vive Edgar")
}


if let firstRoomName = edgar.residence?[0].name {
    print("La primera habitación es de \(firstRoomName)")
}else{
    print("La primera habitación no sabemos de quien es")
}

edgar.residence?[0] = Room(name: "Bathroom")

let edgarHouse = Residence()
edgarHouse.rooms.append(Room(name:"Bathroom"))
edgarHouse.rooms.append(Room(name:"Living Room"))
edgarHouse.rooms.append(Room(name:"Kitchen"))
edgar.residence = edgarHouse

if let firstRoomName = edgar.residence?[0].name {
    print("La primera habitación es de \(firstRoomName)")
}else{
    print("La primera habitación no sabemos de quien es")
}

edgar.residence?.address = createAddress()

if let edgarStreet = edgar.residence?.address?.street{
    print("La casa de Edgar está en la calle \(edgarStreet)")
}else{
    print("No se donde vive Edgar")
}
edgar


if let buildingIdentifier = edgar.residence?.address?.buildingIdentifier(){
    print("Edgar vive en \(buildingIdentifier)")
}

if let _ = edgar.residence?.address?.buildingIdentifier()?.hasPrefix("13"){
    print("Edgar vive en el número 13")
} else{
    print("Edgar no vive en el número 13")
}

//existe también el “coalescing operator”, el cual puede ser útil para combinarlo con el “chaining multiple”, El operador es ?? y se puede utilizar de la siguiente manera:

let edgarStreet = edgar.residence?.address?.street ?? "Calle desconocida"

//Ejemplo-reto
class Cliente {
    var nombre: String
    var presupuesto: Double
    var resicencia: Residence?
    
    init(nombre: String, presupuesto: Double) {
        self.nombre = nombre
        self.presupuesto = presupuesto
    }
    
    func restarPresupuesto(valor: Double) {
        self.presupuesto -= valor
    }
    
}

class Repartidor {
    var nombre: String
    var vehiculo: Vehiculo
    
    init(nombre: String, vehiculo: Vehiculo) {
        self.nombre = nombre
        self.vehiculo = vehiculo
    }
}

class Vehiculo {
    var marca: String
    var modelo: String
    var anio: String?
    var placa: String?
    
    init(marca: String, modelo: String) {
        self.marca = marca
        self.modelo = modelo
    }
}

class Articulo {
    var nombre: String
    var precio: Double
    var stock: Int?
    
    init(nombre: String, precio: Double) {
        self.nombre = nombre
        self.precio = precio
    }
}

class Pedido {
    var cliente: Cliente
    var repartidor: Repartidor?
    var articulos: [Articulo]? = [Articulo]()
    var direccionEnvio: String? {
        get {
            var direccionPersona: String
            if let direccion = cliente.resicencia?.address?.street {
                direccionPersona = direccion
                return direccionPersona
            } else {
                return nil
            }
        }
    }
    var totalPedido: Double?
    
    init(cliente: Cliente) {
        self.cliente = cliente
    }
    
    func agregarArticulosAlPedido(articulo: Articulo) {
        self.articulos?.append(articulo)
    }
    
    func obtenerTotal() -> Double{
        if let articulos = self.articulos {
            var totales = 0.00
            articulos.forEach { (art: Articulo) in
               totales += art.precio
            }
            return totales
        } else {
            return 0.00
        }
    }
    
    func RealizarPedido() {
        guard let totalPedido = totalPedido, let direccionEnvio = self.direccionEnvio else {
            print("No se ha podido realizar el pedido, agregue productos")
            return
        }
        print("Se va a enviar \(self.articulos!.count) a \(self.cliente.nombre) en la direccion \(direccionEnvio) con un total de \(totalPedido)")
        cliente.restarPresupuesto(valor: totalPedido)
    }
    
    func AsignarRepartidor(repartidor: Repartidor) {
        self.repartidor = repartidor
    }
}

let cliente1 = Cliente(nombre: "Jonathan", presupuesto: 500.20)

cliente1.resicencia

var residenciaCliente1 = Residence()
residenciaCliente1.rooms.append(Room(name: "Cuarto master"))

residenciaCliente1.address = Address()
residenciaCliente1.address?.buildingName = "Torres de la costa"
residenciaCliente1.address?.buildingNumber = "202"
residenciaCliente1.address?.street = "bosques de la costa"

cliente1.resicencia = residenciaCliente1

var zapatoNautico = Articulo(nombre: "ZapatoNautico", precio: 20.00)
var camisaPolo = Articulo(nombre: "Camisa polo blanca", precio: 20.00)
var telefono = Articulo(nombre: "iPhone 11", precio: 700.00)


var pedido1 = Pedido(cliente: cliente1)
pedido1.agregarArticulosAlPedido(articulo: zapatoNautico)
pedido1.agregarArticulosAlPedido(articulo: camisaPolo)
pedido1.agregarArticulosAlPedido(articulo: telefono)

pedido1.articulos

pedido1.totalPedido = pedido1.obtenerTotal()
pedido1.totalPedido
pedido1.direccionEnvio

pedido1.RealizarPedido()
