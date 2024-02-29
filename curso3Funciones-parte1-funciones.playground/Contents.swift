import UIKit

//Estructura general de las funciones
func greeting(person: String) -> String {
    let greet = "¡Bienvenue, \(person)!"
    return greet
}

greeting(person: "Ricardo Celis")
greeting(person: "Edgar")
greeting(person: "Juan Gabriel")

/**
 func = inicializa la función
 greeting = el nombre de la función
 (person: String) = el parámetro de entrada y su tipo
 -> String = el tipo de la salida
 */

//Paramentros de entrada
func sayHelloWorld() -> String {
    return "Hello World"
}

sayHelloWorld()
sayHelloWorld()
sayHelloWorld()

func greeting(person: String, isMale:Bool) -> String {
    if isMale {
        return "Bienvenido Caballero \(person)"
    }else{
        return "Bienvenida Señorita \(person)"
    }
}
greeting(person: "RicardoCelis", isMale: true)
greeting(person: "Olivia", isMale: false)

//Valores de Retorno, Optionals y Parámetros de Salida
func greet2(person:String){
    print("Hola \(person)")
}
greet2(person: "Ricardo Celis")
greet2(person: "Edgar")

func printAndCount(string : String) -> Int{
    print(string)
    return string.count
}

func printWithoutCounting(string: String){
    let _ = printAndCount(string: string)
}

printAndCount(string: "Hola que tal")
printWithoutCounting(string: "Hola que tal")


func minMax0(array:[Int]) -> (min: Int, max: Int)?{
    
    if array.isEmpty { return nil }
    
    var currentMin = array[0]
    var currentMax = array[0]
    
    for value in array[1..<array.count]{
        if value < currentMin{
            currentMin = value
        }else if value > currentMax{
            currentMax = value
        }
    }
    
    return (currentMin, currentMax)
}

let bounds = minMax0(array: [6,3,-8,3,1,9,5,15,-9])
print("Los valores se halla entre \(bounds!.min) y \(bounds!.max)")

minMax0(array: [])

//otras formas del minMax
func minMax(_ array: [Int]) -> (min: Int, max: Int)? {
    // Comprobamos si el array es vacio
    if array.isEmpty { return nil }
    
    // Buscamos el min y max
    var min = array[0]
    var max = array[0]
    for n in array[1..<array.count] {
        min = n < min ? n : min
        max = n > max ? n : max
    }
    
    // Devolvemos la tupla con min y max
    return (min, max)
}


//  force unwrapping
let bounds1 = minMax([1,2,3])
print("Min: \(bounds1!.min) Max: \(bounds1!.max)")

// optional Binding
if let bounds2 = minMax([]) {
    // Con un array vacio nunca entramos aqui
    print("Min: \(bounds2.min) Max: \(bounds2.max)")
} else {
    print("No hay máximo y minimo")
}


// Operador Nil Coalescing
let bounds3 = minMax([]) ?? ( min: 0, max: 0 )
print("Min: \(bounds3.min) Max: \(bounds3.max)")

let bounds4 = minMax([1,2,312,31,3,321,-312,-3,-31,-31,-31,-7]) ?? ( min: 0, max: 0 )
print("Min: \(bounds4.min) Max: \(bounds4.max)")

//Etiquetas de Params y Variadics
/**
 - Las etiquetas son alias que le damos a los params para no tener que llamar las funciones con paramateros largos, sino con etiquetas más cortas.
 - Los Variadics son parametros cuya etiqueta es un guión bajo y que podemos usar ese parametro como si lo hubiesemos agregado n veces, solo agregando tres puntos al final del parametro definido en la función
 */
func someFunction(f1 firstParamName: Int, f2 secondParamName:Int = 6){
    //firstParamName variable de tipo Int
    //secondParamName variable de tipo Int
    print(firstParamName + secondParamName)
}
someFunction(f1: 5, f2: 1)
someFunction(f1: 5)
func greeting(_ person: String,from hometown: String) -> String {
    return "Hola \(person) un placer que no visites desde \(hometown)"
}
greeting("Juan Gabriel", from: "Mallorca")



func mean(_ numbers: Double...) -> Double {
    var total : Double = 0
    for number in numbers{
        total += number
    }
    return total / Double(numbers.count)
}
mean(1,2,3,4,5)
mean(1.5, 2.7)
mean(3, 4.5, 18.75)

//Ejercicio media geométrica
func geometricMean(_ numbers: Double...) -> Double{
    var total : Double = 1
    for i in numbers {
        total *= i
    }
    return pow(total, 1/Double(numbers.count))
}
print(geometricMean(1.20, 1.15, 1.33, 1.25))

//Parámetro tipo inout
let x = 5
func addOne(number: Int) {
    var number2 = number
    number2 += 1
    print("El número ahora vale \(number2)")
}
addOne(number: x)



func swapTwoInts(_ a: inout Int,_ b: inout Int){
    let tempA = a
    a = b
    b = tempA
}

var someInt = 3
var otherInt = 7
print("someInt vale \(someInt) y otherInt vale \(otherInt)")
swapTwoInts(&someInt, &otherInt)
print("someInt vale \(someInt) y otherInt vale \(otherInt)")

//Function types
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a+b
} //(Int, Int) -> Int

func multiplyTwoInts(_ a: Int, _ b: Int ) -> Int{
    return a*b
}//(Int, Int) -> Int

func printHW(){
    print("Hello World")
} //() -> Void

var mathFunction: (Int, Int) -> Int = multiplyTwoInts
mathFunction(4,5)



func printMathResult(_ mathFunc: (Int, Int) -> Int, _ a: Int, _ b: Int){
    print("Resultado: \(mathFunction(a,b))")
}

printMathResult(multiplyTwoInts, 5, 9)



//Nested functions
// Funciones anidadas: Una función está anidada cuando está definida dentro de otra
func chooseStepFunction(backward: Bool) -> (Int) -> Int { // Función que devuelve una función
    func stepFoward(_ input: Int) -> Int { // Función anidada
        return input + 1
    }
    func stepBackward(_ input: Int) -> Int { // Función anidada
        return input - 1
    }
    return backward ? stepBackward : stepFoward
}

var value = -7
let moveNearerZero = chooseStepFunction(backward: value > 0) // Esto tendrá como valor una función que acepta un entero y retorna un entero
while value != 0 {
    print("El valor actual es \(value).")
    value = moveNearerZero(value) // Por eso aquí al llamar esa variable, le mando un parámetro
}
print("Cero!")


