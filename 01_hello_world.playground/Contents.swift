import UIKit

// var se usa para definir variables
// let se usa para definir constantes
var nombre = "Tulio"

//Definir el tipo de una variable sin conocer su valor en el momento:
var welcomeMessage : String
var red, green, blue : Double
//Forzar el tipo de la variable definidas con valor
let f1: Float = 3.14159265

//Las variables se definen con lower camel case

//Prints
print("hola mundo", "soy Tulio", separator: ", ", terminator: ".")
print("El nombre es \(nombre), cómo la ves?")

//En swift se pueden separar los miles con guión bajo
let number = 1_000_000

//Castear
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)

let three = 3
let decimalNumber = 0.14159
let piNum = Double(three) + decimalNumber

let integerPi = Int(piNum)

//Type Alias:
//Un Type alias es básicamente tomar un tipo y renombrarlo
typealias AudioSample = UInt16
var maxAmplitude = AudioSample.max // UInt16.max

//Tuplas
let http404Error = (404, "Página no encontrada")
let (statusCode, statusMessage) = http404Error
print("El código del estado es \(statusCode)")
print("El mensaje del servidor es \(statusMessage)")

let (justStatusCode, _) = http404Error
print("El código del estado es \(justStatusCode)")

print("El código del error es \(http404Error.0) y el mensaje es \(http404Error.1)")

let http200Status = (statusCode: 200, description: "OK")
print("El código del estado es \(http200Status.statusCode) y el mensaje es \(http200Status.description)")

//Optional y Nil
/*
 En Javascript sería equivalente a
 null: null
 nil: undefined
 */
let possibleAge = "31"
let convertedAge = Int(possibleAge) //Int?

var serverResponseCode: Int? = 404
serverResponseCode = nil

var surveyAnswer : String?

surveyAnswer = "42"

//Force unwrapping de una variable optional
if convertedAge != nil {
    print("La edad del usuario no es nula: \(convertedAge!)")
} else{
    print("La edad del usuario es nula")
}

//Optional binding
if let actualAnswer = surveyAnswer {
    //Al llegar aquí, surveyAnswer != nil
    print("El string \(surveyAnswer) tiene el valor \(actualAnswer)")
}else{
    //Al llegar aquí, surveyAnswer = nil
    print("El string \(surveyAnswer) es nil... ")
}

if let firstNumber = Int("4"),
    let secondNumber = Int("42"),
    firstNumber < secondNumber && secondNumber<100{
    print("\(firstNumber) < \(secondNumber) < 100")
}


if let firstNumber = Int("4"){
    if let secondNumber = Int("42"){
        if firstNumber < secondNumber && secondNumber<100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}

//Unwrap implícito
let possibleString: String? = "Un string opcional"
let forcedString: String = possibleString!

let assummedString: String! = "Un string unwrapped de forma implicita a partir de un optional"
let implicitString: String = assummedString

//Try-catch
func canThrowError() throws{
    //aquí hay codigo que puede causar un error
}

do{
    try canThrowError()
    //si llegamos aquí, no ha habido error
}catch{
    //si llegamos aquí, ha habido un error...
}

func makeASandwich() throws{
    
}

do{
    try makeASandwich()
    //Me como el sandwich
}catch{
    //tengo platos limpios... -> Lavar los platos
    //tengo ingredientes -> Ir a hace la compra
    //no tengo hambre -> esperar dentro de una hora
}

//Ejemplo
let pokemon = (name:"eevee", lv:29)
let level: Int! = pokemon.lv
enum lvUp: Error{
   case getMoreLvel
}
func jolteon() throws{
    if  level > 30{
        print("Jolteon!!!!!")
    }
    if level < 30 {
        throw lvUp.getMoreLvel
    }
}
do{
    try jolteon()
} catch (lvUp.getMoreLvel){
    print("Debes conseguir mas experiencia")
}

//Aserciones (debug) y Precondiciones (build)
let age = -5
//assert(age>=0, "La edad de una persona no puede ser negativa")
precondition(age>=0, "La edad de una persona no puede ser negativa")
//... aquí el código sigue

if age > 10 {
    print("Puedes subir a la montaña rusa")
}else if age >= 0{
    print("Eres demasiado pequeño para subir a la montaña rusa")
}else{
    assertionFailure("La edad de una persona no puede ser negativa")
}


