import Foundation

class Person {
    var account: Account?
    var name = "Andres"
    
    deinit {
        print("Vamos a eliminar a nuestra persona")
    }
}

class Account {
    unowned var person: Person
    var name = "Bank X"
    
    init(person: Person) {
        self.person = person
    }
    
    deinit {
        print("Vamos a eliminar a nuestra cuenta")
    }
}

var person: Person = Person()
var account: Account? = Account(person: person)

account?.person = person

print(person.account?.name)
print(account?.person.name)

account = nil

print(person.account?.name)
print(account?.person.name)

print(person.name)
