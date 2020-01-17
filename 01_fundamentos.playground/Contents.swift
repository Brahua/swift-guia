import UIKit

/*
 Contenido
 -------------------------
 0. Var y Let
 1. Caracteres especiales
 2. Tipo de dato - Numericos
 3. Tipo de dato - Boleanos
 4. Tuplas
 5. Force Unwrapping
 6. Optional Binding
 7. Unwrap implicito
 8. Manejo de excepciones
 9. Aserciones (debug) y Preciondiciones (build)
 10. Operaciones
 11. Rangos
 12. And - Or
 13. Strings
 14. Characters
 15. Indices y Rangos de Strings
 16. Substring
 17. Prefijos y Sufijos
 18. Representaciones Unicode
 19. Arrays
 18. Conjuntos (Set)
 19. Diccionarios
 20. Bucle for-in
 21. Bucle While
 22. If y Else
 23. Switch/Case
 24. Control Transfer Sentences - continue, break, fallthrough, return, throw
 25. Available APIS
  -------------------------
 */






//0. Var y Let
//var -> para declarar variables
//let -> para declarar constantes

let maximumNumberOfLoginAttempts = 3
var currentLoginAttempt = 0
var x = 0.0, y = 0.0, z = 0.0
var welcomeMessage : String

welcomeMessage = "Hola mundo"
print(welcomeMessage)

var red, green, blue : Double






//1. Caracteres especiales
let π = 3.141592
let 你好 : String
var 👽 = "Alien"

print(👽)
👽 = "Alien 2"

print("El número de login actual es: \(currentLoginAttempt) de un total disponible de: \(maximumNumberOfLoginAttempts)")







//2. Tipo de dato - Numericos
let age : UInt8 = 31

let minValue = UInt8.min //2^0-1
let maxValue = UInt8.max //2^8-1

let f1: Float = 3.14159265
let d1: Double = 3.14159265

let meaningOfLife = 42 //Int
let pi = 3.14159 //Double
let anotherPi = 3 + 0.14159 //Double

let decimalInteger = 17 // 1*10^1 + 7*10^0
let binaryInteger = 0b10001 //1*2^4+0*2^3+0*2^2+0*2^1+1*2^0
let octalInteger = 0o21 //2*8^1+1*8^0
let hexadecimalInteger = 0x11 //1*16^1+1*16^0

let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0

let paddedDouble = 000123.456
let someNumber = 00000097.540

let oneMillion = 1_000_000
let justMoreThanAMillion = 1_000_000.000_000_1

//ERRORES DE TIPO DE DATO
//let cannotBeNegative: UInt8 = -1
//let tooBig: UInt8 = UInt8.max + 1

let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)

let three = 3
let decimalNumber = 0.14159
let piNum = Double(three) + decimalNumber

let integerPi = Int(piNum)

typealias AudioSample = UInt16
var maxAmplitude = AudioSample.max // UInt16.max






//3. Tipo de dato - Boleanos
let orangesAreOrange = true
let foodIsDelicious = false

var isAged : Bool

isAged = true

if isAged {//Solo entramos aquí, si isAged == true
    print("Puedes entrar en la fiesta")
}else{//Solo entramos aquí, si isAged == false
    print("No puedes pasar a la fiesta")
}

if age >= 18{
    print("Puedes entrar en la fiesta")
}






//4. Tuplas
let http404Error = (404, "Página no encontrada")
let (statusCode, statusMessage) = http404Error
print("El código del estado es \(statusCode)")
print("El mensaje del servidor es \(statusMessage)")

let (justStatusCode, _) = http404Error
print("El código del estado es \(justStatusCode)")

print("El código del error es \(http404Error.0) y el mensaje es \(http404Error.1)")

let http200Status = (statusCode: 200, description: "OK")
print("El código del estado es \(http200Status.statusCode) y el mensaje es \(http200Status.description)")






//5. Force Unwrapping
let possibleAge = "31"
let convertedAge = Int(possibleAge) //Int? -> Variable opcional

var serverResponseCode: Int? = 404
serverResponseCode = nil

var surveyAnswer : String?
surveyAnswer = "42"


if convertedAge != nil {
    print("La edad del usuario no es nula: \(convertedAge!)")
} else{
    print("La edad del usuario es nula")
}






//6. Optional Binding
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






//7. Unwrap implicito
let possibleString: String? = "Un string opcional"
let forcedString: String = possibleString!

let assummedString: String! = "Un string unwrapped de forma implicita a partir de un optional"
let implicitString: String = assummedString

if assummedString != nil {
    print(assummedString!)
}

if let definitiveString = assummedString {
    print(definitiveString)
}

print(assummedString)






//8. Manejo de excepciones
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






//9. Aserciones (debug) y Preciondiciones (build)
assert(age>=0, "La edad de una persona no puede ser negativa")
//precondition(age>=0, "La edad de una persona no puede ser negativa")
//... aquí el código sigue

if age > 10 {
    print("Puedes subir a la montaña rusa")
}else if age >= 0{
    print("Eres demasiado pequeño para subir a la montaña rusa")
}else{
    assertionFailure("La edad de una persona no puede ser negativa")
}






//10. Operaciones
let b = 10
var a = 5
a = b
let (q,w) = (1,2)

//let 2 = z

if a == b {
  print("Los valores de a y b son iguales")
}
1+2
5-3
2*3
10.0/2.5
"Hello " + "World"

//D/d -> D == d*c+r
9/4 //c
9%4 //r
9 == 4*2+1
-9%4 // -9 == -2*4 + (-1)

let five = 5
let minusFive = -five
let plusFive = -minusFive

let minusSix = -6
let alsoMinusSix = +minusSix

var number = 5
number += 3 //number = number + 3
number -= 2 //number = number - 2

1 == 1
1 == 2
1 != 2
2 > 1
2 < 1
2 >= 1
1 >= 1
2 <= 1

let name = "Ricardo Celis"
if name == "Juan Gabriel" {
    print("Bienvenido \(name), eres invitado a la fiesta")
}else{
    print("Cuidado, ha aparecido un \(name) salvaje")
}

(1, "Juan Gabriel") < (2, "Ricardo Celis")
(3, "Juan Gabriel") < (3, "Ricardo Celis") //Las cadenas se verifican por el orden alfabetico
(3, "Ricardo") < (3, "Juan Gabriel")
(4, "perro") == (4, "perro")
("perro", false) == ("perro", true)

let contentHeight = 40
var hasImage = true
var rowHeight = 0
rowHeight = contentHeight + (hasImage ? 50 : 10) //-> Operador ternario

let defaultAge = 18
var userAge: Int?
userAge = 31
var ageToBeUsed = userAge ?? defaultAge
// ageToBeUsed = (userAge != nil ? userAge! : defaultAge)

let defaultColorName = "red"
var userColorName: String? = "green"
var colorNameToUse = userColorName ?? defaultColorName






//11. Rangos
for idx in 1...5 {
    print(idx)
}

for idx in 1..<5{
    print(idx)
}

let names = ["Ricardo", "Juan Gabriel", "Pedro"]
for i in 0..<names.count{
    print("La persona \(i+1) se llama \(names[i])")
}

for name in names[1...]{
    print(name)
}

for name in names[..<2]{
    print(name)
}

let range = ...5 // -infinity...5
range.contains(7)
range.contains(4)
range.contains(-2)






//12. And - Or
let allowEntry = false

if !allowEntry{
    print("ACCESO DENEGADO")
}

let enterDoorCode = false
let passRetinaScan = true

if enterDoorCode && passRetinaScan { //AND
    print("Bienvenido a la empresa")
}else{
    print("ACCESO DENEGADO")
}

let hasMoney = false
let hasInvitation = false
if hasMoney || hasInvitation{ //OR
    print("Bienvenido a la fiesta!")
} else{
    print("No eres bienvenido aquí...")
}

if enterDoorCode && passRetinaScan ||
    hasMoney || hasInvitation{
    print("Has entrado")
} else{
    print("Acceso denegado")
}






//13. Strings
let someString = "Soy un string cualquiera"
let multiLineString = """
 Soy Juan Gabriel Gomila\
 Estamos haciendo el curso de Swift\
 Un saludo, paz y amor...
"""
print(multiLineString)
let wiseWords = "\"La imaginación es más importante que el saber\" - Albert Einstein"
let dolarSign = "\u{24}"
let blackHeart = "\u{2665}"
let heart = "\u{1F496}"
var emptyString = ""
var anotherEmptyString = String()

if emptyString.isEmpty {
    print("Nada que ver aquí")
} else{
    print("El string tiene un valor")
}

var newSomeString = "Un caballo"
newSomeString += " y un carruaje"
newSomeString += " y un soldado"
let aString = "Juan Gabriel"
//aString += " y Ricardo Celis"
for ch in name {
    print(ch)
}
print(name.count)






//14. Characters
let exclamationMark : Character = "!"

let nameChars: [Character] = ["J", "u", "a", "n"]
var nameString = String(nameChars)

let compoundName = "Juan " + "Gabriel"

nameString.append(exclamationMark)

let multiplier = 3
var message = "El producto de \(multiplier) x 3.5 da \(Double(multiplier)*3.5)"
message.append(exclamationMark)






//15. Indices y Rangos de Strings
let greeting = "Hola, ¿que tal?"
greeting[greeting.startIndex]
greeting[greeting.index(before: greeting.endIndex)]
greeting[greeting.index(after: greeting.startIndex)]

for idx in greeting.indices{
    print("\(greeting[idx])", terminator:"")
}


var welcome = "Hola"

welcome.insert("!", at: welcome.endIndex)
welcome.insert(contentsOf: " que tal",
               at: welcome.index(before: welcome.endIndex))

welcome.remove(at: welcome.index(before: welcome.endIndex))
welcome
let range2 = welcome.index(welcome.endIndex, offsetBy: -7)..<welcome.endIndex
welcome.removeSubrange(range2)
welcome






//16. Substring
greeting
let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let firstPart = greeting[..<index]
let newString = String(firstPart)






//17. Prefijos y Sufijos
let newGreeting = "Hola, soy Juan Gabriel"
newGreeting.hasPrefix("Hola")
newGreeting.hasSuffix("l")

let collection = [
    "Act 1 Scene 1","Act 1 Scene 2","Act 1 Scene 3","Act 1 Scene 4","Act 1 Scene 5",
    "Act 2 Scene 1","Act 2 Scene 2","Act 2 Scene 3",
    "Act 3 Scene 1","Act 3 Scene 2"
]

var act1SceneCount = 0
for scene in collection{
    if scene.hasPrefix("Act 1"){
        act1SceneCount += 1
    }
}

print("El número de escenas del acto 1 es: \(act1SceneCount)")






//18. Representaciones Unicode
let ghost = "¡¡Fantasma!! 👻"

for codeUnit in ghost.utf8{
    print(codeUnit, terminator: " ")
}

print(" ")
for codeUnit in ghost.utf16{
    print(codeUnit, terminator: " ")
}

print(" ")
for codeUnit in ghost.unicodeScalars{
    print(codeUnit, terminator: " ")
}






//19. Arrays
var someInts = [Int]()
someInts.count
someInts.append(31)
someInts.count
someInts = []
someInts.count

var someDoubles = Array(repeating: 3.141592, count: 3)
someDoubles.count

var moreDoubles = Array(repeating: 2.5, count: 4)

var aLotOfDoubles = someDoubles + moreDoubles
aLotOfDoubles.count

var shoppingList : [String] = ["Papas", "Pimiento", "Tortillas", "Cerdo", "Cebolla"]
shoppingList.count


if shoppingList.isEmpty {
    print("La lista de la compra está vacía")
} else{
    print("Mandemos a Ricardo a comprar")
}

shoppingList.append("Coca Cola")
shoppingList.count

shoppingList += ["Totopos", "Guacamole", "Pico de Gallo"]
shoppingList.count

var firstElement = shoppingList[0]
shoppingList[0] = "Huevos"
shoppingList
shoppingList[5]
shoppingList[4...6]
shoppingList[4...6] = ["Naranja", "Plátano", "Mango"]
shoppingList

let pepper = shoppingList.remove(at: 1)
shoppingList

let _ = shoppingList.removeLast()
shoppingList

for item in shoppingList{
    print(item)
}

for (idx, item) in shoppingList.enumerated(){
    print("Item \(idx+1): \(item) ")
}






//18. Conjunto (Set)
var letters = Set<Character>()
letters.count
letters.insert("a")
letters.insert("h")
letters.insert("b")
letters


var favouriteGames : Set<String> = ["Final Fantasy", "World of Warcraft", "Farcry"]
favouriteGames.count


if favouriteGames.isEmpty{
    print("No hay juegos favoritos")
}

favouriteGames.insert("Metal Gear")

if let removedGame = favouriteGames.remove("Farcry"){
    print("He eliminado de la lista \(removedGame)")
}

if favouriteGames.contains("Metal Gear"){
    print("Me encanta ese juego")
}

for vg in favouriteGames.sorted() {
    print(vg)
}

let oddDigits: Set = [1,3,5,7,9]
let evenDigits: Set = [0,2,4,6,8]
let primeNumbers: Set = [2,3,5,7]

//A union B = elementos que son o bien de A, o bien de B o de los dos
oddDigits.union(evenDigits).sorted()
//A intersección B = elementos que son a la vez de A y de B
oddDigits.intersection(evenDigits)
evenDigits.intersection(primeNumbers).sorted()
oddDigits.intersection(primeNumbers).sorted()

// A - B = elementos que son de A pero no de B
oddDigits.subtracting(primeNumbers).sorted()

// A + B = (A-B) union (B-A)
oddDigits.symmetricDifference(primeNumbers).sorted()


let houseAnimals:Set = ["🐶", "😹"]
let farmAnimals:Set = ["🐮", "🐔", "🐑", "🐶", "😹"]
let cityAnimals:Set = ["🐁", "🕊"]

houseAnimals.isSubset(of: farmAnimals)
farmAnimals.isSuperset(of: houseAnimals)
//A y B son disjuntos si su intersección es vacía
farmAnimals.isDisjoint(with: cityAnimals)






//19. Diccionarios [k1:v1, k2:v2, ....]
var namesOfIntegers = [Int : String]()
namesOfIntegers[15] = "quince"
namesOfIntegers = [:]

var airports: [String: String] = ["YYZ": "Toronto",
                                  "DUB": "Dublin",
                                  "PMI": "Palma de Mallorca"]

airports.count

airports.isEmpty
airports["LHR"] = "London City Airport"
airports
airports["LHR"] = "London Heathrow"
airports

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB"){
    print("El aeropuerto tenia antiguamente el nombre de \(oldValue)")
}
airports

if let airportName = airports["DUB"]{
    print("El aeropuerto de DUB es: \(airportName)")
}

airports["PMI"] = nil
airports

if let removedAirport = airports.removeValue(forKey: "DUB"){
    //usar la variable removed airport
}
airports

for (key, value) in airports {
    print("\(key) - \(value)")
}

for airportKey in airports.keys{
    print(airportKey)
}

for airportName in airports.values{
    print(airportName)
}

let airportKeys = [String](airports.keys.sorted())
let airportNames = [String](airports.values.sorted())






//20. Bucle for-in
let names2 = ["Ricardo Celis", "Juan Gabriel", "Edgar"]
for name in names2 {
    print("Hola \(name)")
}

let numberOfLegs = ["spider": 8, "ant": 6, "dog":4]
for (animalName, legCount) in numberOfLegs{
    print("Animal: \(animalName), número de patas: \(legCount)")
}

for idx in 1...5{
    print("\(idx) x 3 = \(idx*3)")
}

let base = 2
let power = 10
var answer = 1

for _ in 0..<power{
    answer *= base
    print(answer)
}

var hour = 9
let minutes = 60
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval){
    print("\(hour) : \(tickMark)")
}






//21. Bucle While
var i = 0
while i <= 10 {
    i += 1
}
print(i)

repeat {
    i += 1
} while i <= 10
print(i)






//22. If y Else
var temp = 30
if temp <= 15{ //temp <= 15
    print("Hace frío! Enciende la calefacción")
}else if temp >= 25{//temp > 25
    print("Hace calor! Encendamos el aire acondicionado")
}else{// 15 < temp < 25
     print("La sensación térmica es agradable. No hace falta modificarla")
}






//23. Switch/Case
let someCharacter: Character = "Z"
switch someCharacter {
    case "a", "A":
        print("Es la primera letra del alfabeto")
    case "z", "Z":
        print("Es la última letra del alfabeto")
    default:
        print("Es alguna otra letra")
}


let moons = 62
let phrase = "lunas en Saturno"
let naturalCount : String
switch moons {
case 0:
    naturalCount = "No hay"
case 1, 2, 3, 4:
    naturalCount = "Hay unas pocas"
case 5..<12:
    naturalCount = "Hay bastantes"
case 12..<100:
    naturalCount = "Hay decenas de"
case 100..<1000:
    naturalCount = "Hay centenares de"
default:
    naturalCount = "Hay muchiiiiisimas"
}
print("\(naturalCount) \(phrase)")


let somePoint = (5,-8)
switch somePoint {
case (0,0):
    print("El punto \(somePoint) es el origen de coordenadas")
case (_, 0):
    print("El punto \(somePoint) se halla sobre el eje de las X")
case (0, _):
    print("El punto \(somePoint) se halla sobre el eje de las Y")
case (-2...2, -2...2):
    print("El punto \(somePoint) se halla en el interior del cuadrado de lado 4")
default:
    print("El punto \(somePoint) está en algún otro lado")
}


let anotherPoint = (5,-2)
switch anotherPoint {
case (let x, 0):
    print("Sobre el eje de las X, con valor \(x)")
case (0, let y):
    print("Sobre el eje de las Y, con valor \(y)")
case let (x,y) where x == y:
    print("El punto se halla sobre la recta x = y")
case let (x,y) where x == -y:
    print("El punto se halla sobre la recta x = -y")
case let (x,y):
    print("En algún otro lugar del plano, en (\(x), \(y))")
}

let anotherCharacter: Character = " "
switch anotherCharacter {
case "a", "e", "i", "o", "u":
    print("Se trata de una vocal")
case "b", "c", "d", "f", "g"://TODO: acabar con el resto del abecedario (solo consonantes)
    print("Se trata de una consonante")
default:
    print("Se trata de un caracter no vocal ni consonante (minúscula)")
}

let stillAnotherPoint = (0,5)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("Se halla sobre el eje, a distancia \(distance) del origen")
default:
    break
}






//24. Control Transfer Sentences - continue, break, fallthrough, return, throw
let sentence = "las mentes grandes piensan igual"
var filteredSentence = ""
let charactersToRemove:[Character] = ["a", "e", "i", "o", "u"]
for ch in sentence{
    if charactersToRemove.contains(ch){
        continue
    }
    filteredSentence.append(ch)
    if ch == "d"{
        break
    }
}
filteredSentence


let integerToDescribe = 5
var description = "El número \(integerToDescribe) es"
switch integerToDescribe {
case 2,3,5,7,11,13,17,19:
    description += " un número primo, y"
    fallthrough
default:
    description += " un número entero."
}
print(description)

var people = ["name": "Juan Gabriel", "age": 31, "isMale": true] as [String : Any]

func testUserValidation(person:[String: Any]){
    guard let surname = person["surname"] else{
        print("El apellido es desconocido")
       return
    }
    //aquí existe surname
    print(surname)
    guard let age = person["age"] else{
        print("La edad es desconocida")
        return
    }
    print("La edad de la persona es \(age)")
}

people["surname"] = "Gomila"
testUserValidation(person: people)






//25. Available APIS
if #available(iOS 12, macOS 10.12, *){
    //Ejecutar las acciones a lo iOS12+, a los macOS12+
}else{
    //Mantener el código viejo con versiones anteriores de iOS, macOS...
}



