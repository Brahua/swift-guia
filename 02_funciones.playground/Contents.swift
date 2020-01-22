import UIKit

/*
 Contenido
 -----------------------
 1. Funciones, Tipos y Parametros (Paso por valor)
 2. Parámetros Opcionales
 3. Etiquetas de parámetros
 4. Variádicos
 5. Parametros tipo inout (Paso por referencia)
 6. Funcion Types
 7. Funciones anidadas
 8. Clousures
 9. Trailing Clousures
 10. Capturing Clousures
 11. Escaping Clousures
 12. Enumeradores
 13. Enumeradores Iterables
 14. Enumeradores con parametros
 15. Enumeradores con valores - rawValue
*/






//1. Funciones, Tipos y Parametros por valor
func greeting(person: String) -> String {
    let greet = "¡Bienvenue, \(person)!"
    return greet
}
greeting(person: "Ricardo Celis")
greeting(person: "Edgar")
greeting(person: "Juan Gabriel")


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






//2. Parámetros Opcionales
func minMax(array:[Int]) -> (min: Int, max: Int)?{
    
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

let bounds = minMax(array: [6,3,-8,3,1,9,5,15,-9])
print("Los valores se halla entre \(bounds!.min) y \(bounds!.max)")
minMax(array: [])

func searchWord(_ word: String = "NOMBRE"){
    print("Palabra a buscar: \(word)")
}
searchWord()
searchWord("CONTENIDO")






//3. Etiquetas de Parametros
func someFunction(f1 firstParamName: Int, f2 secondParamName:Int = 6){
    print(firstParamName + secondParamName)
}
someFunction(f1: 5, f2: 1)
someFunction(f1: 5)

func greeting(_ person: String, from hometown: String) -> String {
    return "Hola \(person) un placer que no visites desde \(hometown)"
}
greeting("Juan Gabriel", from: "Mallorca")






//4. Variadicos
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






//5. Parametros tipo inout (Paso por referencia)
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






//6. Funcion Types
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






//7. Funciones anidadas
func chooseStepFunction(backward: Bool ) -> (Int) -> Int {
    
    func stepForward(_ input: Int) -> Int {
        return input + 1
    }

    func stepBackward(_ input: Int) -> Int {
        return input - 1
    }
       
    return backward ? stepBackward : stepForward
}

var value = -7
let moveNearerZero = chooseStepFunction(backward: value > 0)
while value != 0{
    print("\(value)...")
    value = moveNearerZero(value)
}
print("Cero!!!!!!")






//8. Clousures
let names = ["Christian", "Ricardo", "Juan Gabriel", "Edgar", "Freddy"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
backward("Juan Gabriel", "Edgar")

var reversedNames = names.sorted(by: backward)

//Clousures
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






//9. Trailing Clousures
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
let numbers = [16, -58, 510, -2127]

let numberStrings = numbers.map { (number) -> String in
    var esNegativo: Bool = false
    let menos: String = "Menos"
    if number < 0 {
        esNegativo = true
    }
    
    var number = number < 0 ? -number : number
    var output = ""
    
    repeat{
        output = digitNames[number%10]! + output
        number = number/10
    }while number > 0
    
    if esNegativo {
        output = menos + output
    }
    //print(output)
    return output
}






//10. Capturing clousures
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()


let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()

incrementByTen()






//11. Escaping clousures
var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void){
    completionHandlers.append(completionHandler)
}
completionHandlers.count

func someFunctionWithNonEscapingClosure(closure: () -> Void){
    closure()
}

class SomeClass{
    var x = 10
    func doSomething(){
        someFunctionWithEscapingClosure {
            self.x = 100
        }
        someFunctionWithNonEscapingClosure {
            x = 200
        }
    }
}

let instance = SomeClass()
print(instance.x)

instance.doSomething()
print(instance.x)

completionHandlers.count
completionHandlers.first?()
print(instance.x)






//12. Enumeradores
enum SomeEnumeration{
    //aquí iria la definición del enumerado
}

enum CompassPoint: String {
    case north
    case south
    case east
    case west
}
var directionToGo = CompassPoint.east
directionToGo = .south

switch directionToGo {
case .north:
    print("Hay que ir al norte")
case .south:
    print("Hay pinguinos en el sur")
case .east:
    print("Mordor se extiende hacia las tierras del este")
case .west:
    print("Cuidado con los vaqueros")
}

enum Planet: Int{
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
let somePlanet = Planet.mars
switch somePlanet {
case .earth:
    print("La tierra es segura")
default:
    print("No es seguro ir a este planeta")
}






//13. Enumeradores Iterables
enum Beverage: CaseIterable {
    case coffee, tea, juice, redbull
}
let numberOfChoices = Beverage.allCases.count
for beverage in Beverage.allCases{
    print(beverage)
}






//14. Enumeradores con parametros
enum Barcode{
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ASDFGHJKL")
productBarcode
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR: \(productCode)")
}






//15. Enumeradores con valores - rawValues
enum ASCIIControlCharacter: Character{
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

let earthOrder = Planet.earth.rawValue
let northDirection = CompassPoint.north.rawValue
let possiblePlanet = Planet(rawValue: 5)

let planetPosition = 3
if let anyPlanet = Planet(rawValue: planetPosition){
    switch anyPlanet{
        case .earth:
            print("La tierra es segura")
        default:
            print("No es seguro ir a este planeta")
    }
}else{
    print("El planeta indicado no existe... ")
}


