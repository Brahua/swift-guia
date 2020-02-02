import UIKit

/*
 Contenido
 --------------------
 1. Stored Properties
 2. Lazy Properties
 3. Computed Properties
 4. Property Observers (willSet - didSet)
 5. Type Properties
 6. Mutating methods
 7. Metodos de instancia y Metodos de clase
 8. Subscripts
 9. Herencia
 10. Inicializadores, Failable Initializer y Destrucción de objetos (deinit)
 11. Optional Chaining
 */


//1. Stored Properties
struct FixedLengthRange {
    var firstValue : Int
    let length : Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4) // -> constante: no se puede modificar sus propiedades
//rangeOfFourItems.firstValue = 5 ESTO DA ERROR...





//2. Lazy Properties -> No se inicializan los valores hasta que se necesita
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





//3. Computed Properties -> Variables calculadas (get y set)
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



struct Cuboid{ // -> la variable volume no es posible actualizarla
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double{
        return width * height * depth
    }
}

let cuboid = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
cuboid.volume
//cuboid.volume = 57.0 error, puesto que la variable es de solo lectura





//4. Property Observers (willSet - didSet)
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





//5. Type Properties
struct SomeStruct {
    var counter = 0
    static var storedTypeProperty = "SOME VALUE"
    static var computedTypeProperty: Int {
        return 1
    }
}

var instanceStr = SomeStruct()
var otherInstanceStr = SomeStruct()

print(SomeStruct.storedTypeProperty)
SomeStruct.storedTypeProperty = "JOSUE"
print(SomeStruct.storedTypeProperty)
SomeStruct.computedTypeProperty

enum SomeEnum{
    static var storedTypeProperty = "SomeValue"
    static var computedTypeProperty: Int{
        return 5
    }
}

SomeEnum.storedTypeProperty = ""

class SomeClass{
    static var storedTypeProperty = "Some Value"
    //Las clases que heredan de SomeClass no pueden sobreescribir
    static var computedTypeProperty:Int{
        return -9
    }
    //Las clases que heredan de SomeClass tienen la posibilidad de sobreescribirla
    class var overrideableComputedTypeProperty:Int{
        return 108
    }
}





//6. Mutating methods
//en class
class Counter {
    var count = 0
    func increment(){
        self.count += 1
    }
    func increment(by amount:Int) {
        self.count += amount
    }
    func reset(){
        self.count = 0
    }
}
let counter = Counter()
counter.increment()
counter.increment(by: 8)
counter.reset()

//en structs
struct OtherPoint{
    var x = 0.0, y = 0.0
    func isToTheRight(of x:Double) -> Bool {
        return self.x > x
    }
    
    mutating func moveBy(x deltaX:Double, y deltaY: Double) {
        //self.x += deltaX
        //self.y += deltaY
        self = OtherPoint(x: self.x + deltaX, y: self.y + deltaY)
    }
}


var somePoint = OtherPoint(x: 4, y: 5)
somePoint.isToTheRight(of: 1)
somePoint.isToTheRight(of: 54)

somePoint.moveBy(x: 2, y: -3)
somePoint.x = 9

//en enums
enum DifferentStateSwitch{
    case off, low, high
    mutating func next(){
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var controllerStatus = DifferentStateSwitch.off
controllerStatus.next()
controllerStatus.next()
controllerStatus.next()






//7. Metodos de instancia y Metodos de clase
class OtherSomeClass{
    //Una clase que hereda de esta no puede sobreescribir este metodo
    static func otherSomeMethod(){

    }
    //Una clase que hereda de esta si puede sobreescribir este metodo
    class func someMethod(){
        print("HOLA")
    }
}
OtherSomeClass.someMethod()

struct LevelTracker{
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level:Int){
        if level > highestUnlockedLevel{
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool{
        return level <= highestUnlockedLevel
    }
    
    mutating func advance(to level:Int) -> Bool {
        if LevelTracker.isUnlocked(level){
            currentLevel = level
            return true
        }else{
            return false
        }
    }
    
}

class Player{
    var tracker = LevelTracker()
    let playerName:String
    func complete(level: Int){
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    
    init(name: String) {
        self.playerName = name
    }
}



var player = Player(name: "Juan Gabriel")
player.complete(level: 1)
player

player.complete(level: 7)

if player.tracker.advance(to: 7){
    print("Podemos avanzar hasta el nivel 7")
} else {
    print("El nivel 7 sigue bloqueado por ahora")
}

//8. Subscript(subindices)
struct TimesTable{
    let multiplier:Int
    
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTables = TimesTable(multiplier: 3)
print("6x3 = \(threeTimesTables[6])")
for idx in 0...100{
    print("\(idx) x 3 = \(threeTimesTables[idx])")
}


enum Planet : Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet{
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)


struct Matrix {
    
    let rows : Int, columns : Int
    var grid : [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row:Int, column:Int) -> Bool{
        return row>=0 && column >= 0 && row < rows && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get{
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row*columns)+column]
        }
        set{
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row*columns)+column] = newValue
        }
    }
    
}


var matrix = Matrix(rows: 15, columns: 15)
matrix[0, 1] = 1.5
matrix[1, 0] = 2.5
matrix

for row in 0..<matrix.rows {
    for col in 0..<matrix.columns{
        print(matrix[row, col], separator: "", terminator: " ")
    }
    print("")
}





//9. Herencia
class Vehicle {
    
    var currentSpeed = 0.0
    var description: String{
        return "Viajando a \(currentSpeed) km/h"
    }
    func makeNoise(){
        //do nothing, porque cada vehículo tiene su propia forma de hacer ruido
        print("El ruido depende del vehículo")
    }
}

let someVehicle = Vehicle()
print(someVehicle.description)


class Bicycle : Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print(bicycle.description)


class Tandem : Bicycle{
    var currentNumberOfPassengers = 0
}
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print(tandem.description)


class Train: Vehicle{
    final var numberOfWagons = 0
    override func makeNoise() {
       print("Chooo Chooo")
    }
}
let train = Train()
train.makeNoise()


class Car: Vehicle{
    var gear = 1
    override var description: String{
        return super.description + " en la marcha \(gear)"
    }
}

let car = Car()
car.currentSpeed = 55
car.gear = 3
print(car.description)
print(tandem.description)



class AutomaticCar : Car{
    override var currentSpeed: Double{
        didSet{
            gear = Int(currentSpeed / 15.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 65
print(automatic.description)






//10. Inicializadores, Failable Initializer y Destrucción de objetos (deinit)
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


class OtherSurveyQuestion {
    let text: String
    var response: String?
    
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}
let q2 = OtherSurveyQuestion(text: "¿Te gustan los tacos?")
q1.ask()
q1.response = "Si, me encatan todos ellos"


//Designado -> Designado super clase
//Conveniencia -> Otro init de la misma clase
//El último init que se llame siempre debe ser designado

class OtherVehicle {
    var numberOfWheels = 0
    var description: String{
        return "\(numberOfWheels) ruedas"
    }
}
let vehicle = Vehicle()
vehicle.description

class OtherBicycle: OtherVehicle{
    override init() {
        super.init()
        numberOfWheels = 2
    }
}
let bicycle2 = OtherBicycle()
bicycle2.description


class Hoverboard: OtherVehicle{
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

enum TemperatureUnit{
    case kelvin, celsius, fahrenheit
    init?(symbol: Character){
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}
let someUnit = TemperatureUnit(symbol: "X")


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

class OtherPlayer {
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

var playerOne: OtherPlayer? =  OtherPlayer(coins: 100)
Bank.coinsInBank
playerOne!.win(coins: 2_000)
Bank.coinsInBank

playerOne = nil
Bank.coinsInBank





//11. Optional Chaining
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
