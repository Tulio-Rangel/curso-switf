import UIKit

//Estructuras vs Clases
/**
 Ambas permiten almacenar datos y definir métodos, inicializadores (constructores) y pueden ser extendidas.
 Clases:
    - Herencia
    - Casting
    - Desinicializador para liberar memoria
    - Reference counting: sistema que permite localizar cuántos fragmentos de código están usando una determinada variable, esta implementado para referenciar mas de una referencia por clase en tiempo de ejecución.
 */
// Sintaxis de una Estructura y una Clase:

struct SomeStruct {
    // La definición de la estructura
}

class SomeClass {
    // La definición de la clase
}

//Ejemplos
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlace = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution()
let someVideoMode = VideoMode()

print(someResolution.width)
someVideoMode.resolution.width = 1280
print(someVideoMode.resolution.width)

//someResolution.width = 1280    // esto no se puede hacer porque fue declarada como constante.

someVideoMode.frameRate = 30.0
print(someVideoMode.frameRate)

/*
 Una estructura, una vez creada, ocupa un espacio de memoria y al declararla como constante, tiene que permanecer inmutable. Es por eso que esto no se puede realizar:
 */
//someResolution.width = 1280
/**
 En el caso de un objeto de una clase, lo que tengo no es el propio objeto sino la zona de la memoria que ocupa. Las variables que tenga en su interior, las computed properties o las stored properties, podrán ir cambiando si se han declarado como variables (var dentro de la clase.
 
 struct = copias, tienen su propio espacio de memoria
 class = referencias, apuntan a un espacio de memoria
 */

//Estructura: Datos copiados por valor
let vga = Resolution(width: 640, height: 480)
vga.width
vga.height

let hd = Resolution(width: 1920, height: 1080)

var cinema = hd
print("\(cinema.width) x \(cinema.height)")
cinema.width = 2048
print("\(cinema.width) x \(cinema.height)")
print("\(hd.width) x \(hd.height)")


enum CompassPoint{
    case north, south, east, west
}

var currentDirection = CompassPoint.north
var oldDirection = currentDirection
currentDirection = .south

print(currentDirection)
print(oldDirection)

//Clases: datos referenciados
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
tenEighty


if tenEighty === alsoTenEighty{ //!==
    print("Son el mismo objeto")
}else{
    print("Son diferentes")
}

