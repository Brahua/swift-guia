import Foundation

//Variables
var accountTotal: Float = 1_000_000.0
let name = "Andres"
let lastName = "Silva"
let fullName = "\(name) \(lastName)"

print(fullName.capitalized)

accountTotal += 100_000
print(accountTotal)

var isActive = !fullName.isEmpty
print(isActive)

var transactions: [Float] = [20, 10, 100.0] //Arreglo
print(transactions)

transactions.count
transactions.isEmpty
transactions.append(40)
print(transactions)

transactions.first
transactions.last
transactions.removeLast()
print(transactions)

transactions.min()
transactions.max()

var dailyTransaction: [[Float]] = [ //Matriz
    [20, 10, 100.0],
    [],
    [1000],
    [],
    [10]
]
dailyTransaction.first
dailyTransaction[4].isEmpty


var transactionsDict: [String: [Float]] = [ //Diccionario
    "1nov": [20, 10, 100.0],
    "2nov": [],
    "3nov": [1000],
    "4nov": [],
    "5nov": [10]
]
var transactionsDict2: [String: [Float]] = [
    "2nov": [1000],
    "3nov": [1000],
    "4nov": [1000],
]
print(transactionsDict.count)
print(accountTotal)




//Estructuras de control
accountTotal -= 300_000
if accountTotal > 1_000_000 {
    print("Somos ricos")
} else if accountTotal > 0 {
    print("No tenemos tanto dinero")
} else {
    print("No tenemos nada!!")
}

let hasMoney = accountTotal > 1_000_000 ? "Somos ricos" : "No tenemos tanto dinero"
print(hasMoney)


var age = 24
var tax = 1.0
switch age {
    case 0...17:
        print("No podemos dar una tarjeta de credito")
    case 18...22:
        tax = 2
        print("La tasa de interes es del 2%")
    case 23...25:
        tax = 1.5
        print("La tasa de interes es del 1.5%")
    default:
        print("La tasa de interes es del 1%")
}


let bankType = "B"
switch bankType {
case "B":
    print("Es el Banco B")
default:
    print("Es otro Banco")
}

var total: Float = 0
for transaction in transactions {
    total += (transaction * 100)
}
print(total)
print(accountTotal)

accountTotal -= total
print(accountTotal)


var total2: Float = 0.0
for key in transactionsDict.keys {
    for transaction in transactionsDict[key]! where transaction < 20 {
        total2 += transaction
    }
}
print(transactions)


var total3 = transactions.reduce(0.0) { (result, element) -> Float in
    return result + element
}
print(transactions.reduce(0.0, { return $0 + $1 }))
print(transactions.reduce(0.0, { $0 + $1 }))
print(total3)
print(transactions.reduce(0.0, +))


var newTransactions = transactions.map { (element) -> Float in
    return element * 100
}
print(newTransactions)


print(transactions.sorted(by: >))


print(transactions.filter { (element) -> Bool in
    return element > 10
})


transactions.removeAll(where: {
    $0 > 10
})
print(transactions)


var nombre: String?
if let nombre = nombre {
    print(nombre)
}
nombre = "Andres"
print(nombre!)




//Tuplas
let name2 = (name: "Andres", lastName: "Silva")
print(name2.name)
print(name2.lastName)

var a = 1
var b = 2
(a, b) = (b, a)
print(a, b)




//Funciones
func totalAccount(forTransactions transactions: [String: [Float]]) -> (Float, Int) {
    var total: Float = 0
    for key in transactions.keys {
        let array = transactions[key]!
        total += array.reduce(0.0, +)
    }
    return (total, transactions.count)
}
let total4 = totalAccount(forTransactions: transactionsDict)
let total5 = totalAccount(forTransactions: transactionsDict2)

print(total4.0, total4.1)
print(total5)

@discardableResult
func addTransaction(transactionValue value: Float?) -> Bool {
    guard let value = value else {
        return false
    }
    
    if (accountTotal - value) < 0 {
        return false
    }
    
    accountTotal -= value
    transactions.append(value)
    return true
}

addTransaction(transactionValue: 30)
addTransaction(transactionValue: nil)









