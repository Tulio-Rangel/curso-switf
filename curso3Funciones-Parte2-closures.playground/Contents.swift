import UIKit

//Closures
let names = ["Christian", "Ricardo", "Juan Gabriel", "Edgar", "Freddy"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
backward("Juan Gabriel", "Edgar")

var reversedNames = names.sorted(by: backward)

/*
 { (params) -> return type in
    //Código del closure
 }
 */

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1>s2 })
reversedNames = names.sorted(by: { s1, s2 in return s1>s2 })
reversedNames = names.sorted(by: { s1, s2 in s1>s2 })
reversedNames = names.sorted(by: { $0>$1 })
reversedNames = names.sorted(by: >)

//Trailing Closures
func someFunctionThatTakesAClosure(closure: () -> Void){
    //Aquí iria el cuerpo de la función
}

someFunctionThatTakesAClosure (closure: {
    //Aquí iria el cuerpo del closure
})

someFunctionThatTakesAClosure {
    //Añadir el closure aquí
}

reversedNames = names.sorted {$0>$1}

let digitNames = [0:"Cero", 1:"Uno", 2:"Dos", 3:"Tres", 4:"Cuatro",
                  5:"Cinco", 6:"Seis", 7:"Siete", 8:"Ocho", 9:"Nueve"]
let numbers = [16, 58, 510, 2127]

let numberStrings = numbers.map { (number) -> String in
    
    var number = number
    var output = ""
    repeat{
        output = digitNames[number%10]! + output
        number /= 10
    }while number > 0
    return output
}

//Reto con numeros negativos
let numbers2 = [-9, 34 , -23, -2127 ,46, -6]

let numbersStrings2 = numbers2.map{ (number) -> String in
       
    var number = number
    var output = ""
    let minus = "menos"
    let negative = number
    
    number = number < 0 ? number * -1 : number

    repeat{
        output = digitNames[number%10]! + output
        number /= 10
    }while number > 0
    output = negative < 0 ? minus + output : output
    return output
}

print(numbersStrings2)

//Capturing closures
/**
 Los closures capturan el ambiente en el que fueron creados, lo que significa que toman una copia de los valores que son usados dentro de ellos.
 */
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()    // 10
incrementByTen()    // 20
incrementByTen()    // 30

/**
 Es por eso que cuando se vuelve a invocar a la función makeIncrementer() pero con otro valor (7), el resultado de la anterior se mantiene.
 */
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()    // 7
incrementByTen()    //40
incrementBySeven()  //14

//Escaping Closure
/**
 Un escaping closure es un closure que sobrevive a la función a la que se le pasó.
 */
var completionHandlers: [() -> Void] = []
/**
 Como los closures se tienen que ejecutar en el momento, Swift no nos permite guardar el closure completionHandler en un array para ejecutarlo despues. Para poder hacer esto ultimo, tenemos que agregar el modificador @escaping.
 */
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
completionHandlers.count
/**
 En este caso no es necesario el modificador ya que el closure se va a ejecutar:
 */
func someFunctionWithNoneEscapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure {
            self.x = 100 // El `self` le indica al closure con el modificador @escaping donde va a estar la variable `x`
        }
        someFunctionWithNoneEscapingClosure {
            x = 200 // En este caso no es necesario el `self` porque el closure se va a ejecutar ahora mismo y sabe donde va a estar la variable `x`
        }
    }
}

let instance = SomeClass()
print(instance.x)        // 10

instance.doSomething()
print(instance.x)        // 200

completionHandlers.count        // 1
completionHandlers.first?()
print(instance.x)        // 100

/*
 El self le indica al closure con el modificador @escaping dónde va a estar la variable x para ser utilizada luego.
 En el caso del closure someFunctionWithNoneEscapingClosure no es necesario el self porque el closure se va a ejecutar ahora mismo y sabe dónde va a estar la variable x.
 */
