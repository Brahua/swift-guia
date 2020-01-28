import Foundation


var me = Person(name: "Andres", lastName: "Silva")

let account = Acccount(amount: 100_000, name: "X bank")

me.account = account

print(me.account!)

let entertainment = Budget(category: .entertainment, budget: 100, name: "Entretenimiento")
let health = Budget(category: .health, budget: 300, name: "Salud")

account.add(budget: entertainment)
account.add(budget: health)

try me.account?.addTransaction(
    transaction: .debit(
        value: 20,
        name: "Cafe con amigos",
        category: DebitCategories.food,
        date: Date(year: 2018, month: 11, day: 14)
    )
)

do {
    try me.account?.addTransaction(
        transaction: .debit(
            value: 1_000_000,
            name: "Juego PS4",
            category: .entertainment,
            date: Date(year: 2018, month: 11, day: 10)
        )
    )
} catch {
    print("Error in PS4", error)
}

try me.account?.addTransaction(
    transaction: .debit(
        value: 500,
        name: "PS4",
        category: .entertainment,
        date: Date(year: 2018, month: 11, day: 10)
    )
)

try me.account?.addTransaction(
    transaction: .gain(
        value: 1000,
        name: "Salario",
        date: Date(year: 2018, month: 11, day: 1)
    )
)

var salary = try me.account?.addTransaction(
    transaction: .gain(
        value: 1000,
        name: "Salario",
        date: Date(year: 2018, month: 11, day: 1)
    )
)

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    salary?.invalidateTrantraction()
    print("Invalidated")
}

print(me.account!.amount)

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    let transactions = me.account?.transactionsFor(category: .entertainment) as? [Debit]
    for transaction in transactions ?? [] {
        print(
            "Hello",
            transaction.name,
            transaction.value,
            transaction.category.rawValue,
            transaction.date
        )
    }
    
    for gain in me.account?.gains ?? [] {
        print(
            "Hello gain",
            gain.name,
            gain.isValid,
            gain.value,
            gain.date
        )
    }
}


print(me.account?.amount ?? 0)


