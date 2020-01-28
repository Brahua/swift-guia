import UIKit

//Struct vs Class
/*
 Primero, echemos un vistazo a lo que las clases y estructuras tienen en común:
 - Pueden definir propiedades para almacenar valores y pueden definir funciones
 - Pueden definir subíndices para proporcionar acceso a valores con sintaxis de subíndice
 - Pueden definir inicializadores para configurar su estado inicial, con init()
 - Se pueden ampliar con extension(¡esto es importante!)
 - Pueden ajustarse a protocolos, por ejemplo, para admitir la programación orientada a protocolos
 
 Las clases admiten algunas capacidades más que las estructuras no tienen:
 - Las clases pueden heredar de otra clase, como usted hereda UIViewControllerpara crear su propia subclase de controlador de vista
 - Las clases se pueden desinicializar, es decir, puede llamar a una función antes de que se destruya la clase
 - Las clases son tipos de referencia y las estructuras son tipos de valor
 
 
 
 ¿Cuándo debe usar estructuras?
 Se recomienda usar struct de forma predeterminada. Las estructuras también son útiles en estos escenarios:
    - Utilice estructuras para tipos de datos simples. Piense en la base de datos de objetos que desea pasar alrededor de su código, como NewsItem, Task o User. Dado que están tan bien definidos y, a menudo, no necesitan acomodar relaciones complejas entre objetos, es más sencillo usar estructuras.
    - En un entorno multiproceso , por ejemplo, con una conexión de base de datos que se abre en un subproceso diferente, las estructuras son más seguras . Se pueden copiar de un hilo a otro, sin correr el riesgo de una condición de carrera o punto muerto. Las clases no tienen esta seguridad inherente, a menos que sean deliberadamente seguras para subprocesos .
    - Cuando las propiedades de una estructura son principalmente tipos de valor también, por ejemplo String, tiene sentido envolverlas en una estructura en lugar de una clase. Está bien usar estructuras dentro de los tipos de clase, pero preste especial atención si usa clases dentro de los tipos de estructura. Las clases son tipos de referencia, así que si no sabes que tu estructura hace referencia a una instancia de clase compartida, ¡estás en problemas!
 
 
 ¿Cuándo debe usar las clases?
 Se recomienda usar una clase si necesita las características específicas de una clase. Como se señaló anteriormente, las clases tienen algunas características adicionales que las estructuras no tienen:
    - Las clases pueden heredar de otra clase, lo que no puedes hacer con estructuras. Con clases, puede escribir para crear una subclase de . Por el contrario, las estructuras pueden implementar protocolos.class MyViewController : UIViewControllerUIViewController
    - Las clases se pueden desinicializar, es decir, pueden implementar una deinitfunción, y puede hacer una o más referencias a la misma clase (es decir, las clases son un tipo de referencia).
    - Las clases vienen con la noción incorporada de identidad , porque son tipos de referencia. Con el operador de identidad === puede verificar si dos referencias (variables, constantes, propiedades, etc.) se refieren al mismo objeto.
 */

struct SomeStruct {
    //La definición de la estructura aquí
}
class SomeClass {
    //La definición de la clase aquí
}

struct Resolution {
    var width = 0 // -> stored property (propiedades)
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution()
let someVideoMode = VideoMode()

print(someResolution.width)
someVideoMode.resolution.width = 1280
print(someVideoMode.resolution.width)

someVideoMode.frameRate = 30.0
print(someVideoMode.frameRate)

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
