import UIKit
 //Inicializaodres, Init, Constructor.
struct Fahrenheit {
    var temperature : Double
   
    init(){
        self.temperature = 32
    }
}

var f1 = Fahrenheit()

struct Celsius {
    var temperature: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        self.temperature = (fahrenheit - 32) / 1.8
    }
    
    init(fromKelvin kelvin:Double) {
        self.temperature = kelvin - 273.15
    }
    
    init(_ celsius: Double) {
        self.temperature = celsius
    }
}


let boilingPointOfWater = Celsius(fromFahrenheit: 212)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

//Nombres, etiquetas y optionals
struct Color{
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        self.red = white
        self.green = white
        self.blue = white
    }
}


let magenta = Color(red: 1, green: 0, blue: 1)
let halfGrey = Color(white: 0.5)
let green = Color(red: 0,green: 1,blue: 0)

let bodyTemperature = Celsius(37)

class SurveyQuestion {
    let text: String
    var response: String?
    
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

let q1 = SurveyQuestion(text: "¿Te gustan los tacos?")
q1.ask()
q1.response = "Si, me encatan todos ellos"

//Otro ejemplo-Reto
class SurveyQuestions{
    let Q1: String
    var R1: String?

    let Q2: String
    var R2: String?

    let Q3: String
    var R3: String?
    
    let Q4: String
    var R4: String?
    
    init(q1: String, q2: String, q3: String, q4: String){
        self.Q1 = q1
        self.Q2 = q2
        self.Q3 = q3
        self.Q4 = q4
    }
    
    func ask1(){
        print(Q1)
    }
    func ask2(){
        print(Q2)
    }
    func ask3(){
        print(Q3)
    }
    func ask4(){
        print(Q4)
    }
    
    func res1(){
        if self.R1 != nil{
            print(R1!, "\n")
            
        }else{
            print("No hubo respuesta :( \n")
        }
    }
    func res2(){
        if self.R2 != nil{
            print(R2!, "\n")
        }else{
            print("No hubo respuesta :( \n ")
        }
    }
    func res3(){
        if self.R3 != nil{
            print(R3!, "\n")
        }else{
            print("No hubo respuesta :( \n")
        }
    }
    func res4(){
        if self.R4 != nil{
            print(R4!, "\n")
        }else{
            print("No hubo respuesta :( \n")
        }
    }
}

var preguntas = SurveyQuestions(q1: "¿Como te llamas guap@?", q2: "No respondas nada, es para probar el nil ", q3: "¿Quien te gustaria ser en 5 años?", q4: "¿Quienes son tus instructores favoritos?")
preguntas.ask1()
preguntas.R1 = "Cedric"
preguntas.res1()

preguntas.ask2()
preguntas.R2
preguntas.res2()

preguntas.ask3()
preguntas.R3 = "Alguien que se esfuerza por cumplir sus sueños y no deja de aprender "
preguntas.res3()

preguntas.ask4()
preguntas.R4 = "Freddy Vega y Juan Gomila"
preguntas.res4()

//Inicializadores en subclases
//Designado -> Designado super clase
//Conveniencia -> Otro init de la misma clase
//El último init que se llame siempre debe ser designado

class Vehicle {
    var numberOfWheels = 0
    var description: String{
        return "\(numberOfWheels) ruedas"
    }
}

let vehicle = Vehicle()
vehicle.description

class Bicycle: Vehicle{
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
bicycle.description


class Hoverboard: Vehicle{
    var color: String
    init(color: String){
        self.color = color
        //aquí se llama implícitamente a super.init()
    }
    override var description: String{
        return "\(super.description) en el color \(self.color)"
    }
}

let hoverboard = Hoverboard(color: "Silver")
hoverboard.description
/**
 Para los inicializadores con herencia, se deben cumplir las siguientes condiciones de manera obligatoria:
 Un inicializador designado llama a un designado de la super clase (implícita o explícitamente)
 Un inicializador por conveniencia solo puede llamar a otro de la misma clase
 El último init que se llame siempre debe ser designado
 */

//Failable Initializer
enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    
    init?(symbol: Character) {
        switch symbol {
        case "K", "k":
            self = .kelvin
        case "C", "c":
            self = .celsius
        case "F", "f":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

if let someUnit = TemperatureUnit(symbol: "x") {
    print(someUnit)
}else {
    print("Please, insert a valid character")
}

class Product{
    let name: String
    init?(name: String) {
        if name.isEmpty{
            return nil
        }
        self.name = name
    }
}

class CartItem: Product{
    let quantity: Int
    init?(name: String, quantity: Int){
        if quantity < 1{
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let someSocks = CartItem(name: "Socks", quantity: 2){
    print("\(someSocks.name) - \(someSocks.quantity)")
}

//Destrucción de objetos con deinit
class Bank {
    static var coinsInBank = 2_000
    static func distribute(coins numberOfCoinsRequested:Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int){
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int){
        self.coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
    
}



var playerOne: Player? =  Player(coins: 100)
Bank.coinsInBank
playerOne!.win(coins: 2_000)
Bank.coinsInBank

playerOne = nil
Bank.coinsInBank
