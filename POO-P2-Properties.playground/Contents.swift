import UIKit

//Stored Properties
//https://docs.swift.org/swift-book/LanguageGuide/Properties.html
/**
 En su forma más simple, una propiedad almacenada es una constante o variable que se almacena como parte de una instancia de una clase o estructura en particular. Las propiedades almacenadas pueden ser propiedades almacenadas variables (introducidas por la palabra clave var) o propiedades almacenadas constantes (introducidas por la palabra clave let)
 */
struct FixedLengthRange {
    var firstValue : Int
    let length : Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue = 5 ESTO DA ERROR...

//Lazy Stored Properties
//No se inicializa su valor hasta que esté inicializada
class DataImporter{
    var filename = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Algo de datos")
manager.data.append("Muchos más datos")
manager
//HAsta esta línea, el importer no ha sido creado...
manager.importer.filename
//Aquí, la variable importer ya ha sido creada
manager

//Computed Properties
/**
 In addition to stored properties, classes, structures, and enumerations can define computed properties, which don’t actually store a value. Instead, they provide a getter and an optional setter to retrieve and set other properties and values indirectly.
 
 */
struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point{
        get{
            Point(x: origin.x + size.width/2, y: origin.y + size.height/2)
        }
        set{
            origin.x = newValue.x - size.width/2
            origin.y = newValue.y - size.height/2
        }
    }
}

var square = Rect(origin: Point(x: 0, y: 0), size: Size(width: 10, height: 10))
square.center
let initialSquareCenter = square.center
square.center = Point(x: 18, y: 3)

//Computed Properties de sólo lectura
//Una variable es de solo lectura si solo tiene getter y no tiene setter, es decir, no puedo modificarla
struct Cuboid{
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double{
        return width * height * depth
    }
}

let cuboid = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
cuboid.volume
//cuboid.volume = 57.0 error, puesto que la variable es de solo lectura

//Ejemplos con Computed properties:
struct Person {
    var firstName : String
    var lastName : String
    var name : String {
        firstName + " " + lastName
    }
}

var persona = Person(firstName: "Tulio", lastName: "Rangel")
print(persona.name)

//Otro ejemplo
enum Language{
    case Spanish, English, French
}
struct Person{
    var name : String
}
struct Greet{
    var language : Language
    var person: Person
    var greeting: String {
        switch self.language {
        case .Spanish:
            return "Hola \(person.name)"
        case .English:
            return "Hello \(person.name)"
        case .French:
            return "Salut \(person.name)"
        }
    }
}
let person = Person(name: "Cristian")
let greet = Greet(language: .French, person: person)
greet.greeting

//Otro ejemplo
struct Person{
    var name: String
    var gender: Gender
    var language: String
    var greeting: String {
        switch language {
        case "french":
            return "bonjour"
        case "spanish":
            return "hola"
        case "english":
            return "hello"
        default:
            return "I'm sorry, I can't greeting you"
        }
    }
    var presentation: String{
        var title = ""
        if gender == Gender.man{
            title = "Mr. "
        }else {title = "Mrs. "}
        
        return title + name + " says " + greeting
    }
}

var tulio = Person(name: "Tulio", gender: Gender.man, language: "french")

//Otro ejemplo
enum Languaje {
    case Spanish, English, French
}
enum Gender{
    case male, female
}
struct Person{
    var name: String
}
struct Gretting{
    var person: Person
    var languaje: Languaje
    var gender: Gender
    var languajeGretting: String{
            switch self.languaje {
            case Languaje.Spanish:
                return "Hola "
            case Languaje.English:
                return "Hello "
            case Languaje.French:
                return "Salut "
        }
    
    }
    var abbreviations: String{
            switch self.gender {
            case Gender.male:
                return languajeGretting + "Mr. \(person.name)"
            case Gender.female:
                return languajeGretting + "Mrs. \(person.name)"
        }
    }
}

let guest = Person(name: "Juana")
let welcomeGretting = Gretting(person: guest, languaje: .French, gender: .female)
welcomeGretting.abbreviations

//Property Observers
/**
 willSet is called just before the value is stored.
 didSet is called immediately after the new value is stored.
 */
class StepCounter{
    var totalSteps: Int = 0{
        willSet(newTotalSteps){
            print("El número de pasos va a subir hasta \(newTotalSteps)")
        }
        didSet{
            if totalSteps > oldValue{
                print("El número de pasos ha incrementado en \(totalSteps - oldValue)")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200

stepCounter.totalSteps = 520

stepCounter.totalSteps += 1234
//Ejemplo
class Jugador {
    var totalJugador: Int = 0{
        willSet(newTotal){
            print("vida al \(newTotal)")
        }
        didSet{
            if totalJugador <= 0{
                print("Game over")
            }
        }
    }
}

let vidaJugador = Jugador()
vidaJugador.totalJugador
vidaJugador.totalJugador = 35

//Otro ejemplo
class Player{
    var life: Int = 0{
        willSet{
            switch(newValue){
            case 1..<100:
                print("La vida actual del jugado es: \(newValue)")
            case ...0:
                print("Game over!")
            case 100...:
                print("La vida no puede ser mayor de 100%")
            default:
                print("No se puede determinar la vida")
            }
        }
        didSet{
            if life - oldValue > 100{
                self.life = 100
            }
        }
    }
}

var jugador = Player()
jugador.life = 120
jugador.life = 0

//Type Properties
struct SomeStruct {
    var counter = 0
    static var storedTypeProperty = "SOME VALUE"
    static var computedTypeProperty: Int {
        return 1
    }
}

var instanceStr = SomeStruct()

var otherInstanceStr = SomeStruct()

SomeStruct.computedTypeProperty

enum SomeEnum{
    static var storedTypeProperty = "SomeValue"
    static var computedTypeProperty: Int{
        return 5
    }
}

SomeEnum.storedTypeProperty

class SomeClass{
    static var storedTypeProperty = "Some Value"
    static var computedTypeProperty:Int{
        return -9
    }
    
    class var overrideableComputedTypeProperty:Int{
        return 108
    }
}

//Ejemplo
class FamilyMember
{
    static var budget = 100
    var name = ""
    
    func spend(_ money: Int, in element: String) -> Void
    {
        FamilyMember.budget -= money
        print("\(name) compró \(element), presupuesto restante: \(FamilyMember.budget)")
    }
}

let sarita = FamilyMember(), juanse = FamilyMember()
sarita.name = "Sarita"
juanse.name = "Juanse"

sarita.spend(21, in: "pastel")
//OUTPUT: Sarita compró pastel, presupuesto restante: 79
