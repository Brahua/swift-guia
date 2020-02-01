import UIKit


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





//4. Type Properties
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





//5. Mutating methods
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
