import Foundation

public enum AccountExceptions: Error {
    case invalidTransacion
    case amountExeded
    case budgetExeded
}

public enum TransactionType {
    case debit(value: Float, name: String, category: DebitCategories, date: Date)
    case gain(value: Float, name: String, date: Date)
}


public class Acccount {
    public var amount: Float = 0 {
        willSet {
            print("Vamos a cambiar el valor", amount, newValue)
        }
        didSet {
            print("Tenemos nuevo valor", amount)
        }
    }
    public var name: String = ""
    public var transactions: [Transaction] = []
    public var debits: [Debit] = []
    public var gains: [Gain] = []
    public var budgets = [DebitCategories: Budget]()
    
    
    public init(amount: Float, name: String) {
        self.amount = amount
        self.name = name
    }
    
    @discardableResult
    public func addTransaction(transaction: TransactionType) throws -> Transaction? { //exception
        switch transaction {
        case .debit(let value, let name, let category, let date):
            if (amount - value) < 0 {
                throw AccountExceptions.amountExeded
            }
            
            let total = transactionsFor(category: category).reduce(0.0, {
                $0 + $1.value
            })
            
            if(total+value) > budgets[category]?.budget ?? 0{
                throw AccountExceptions.budgetExeded
            }
            
            let debit = Debit(value: value, name: name, category: category, date: date)
            debit.delegate = self
            
            debit.handler = { (completed, confirmation) in
                debit.confirmation = confirmation
                self.amount -= debit.value
                self.transactions.append(debit)
                self.debits.append(debit)
            }
            
            return debit
        case .gain(let value, let name, let date):
            let gain = Gain(value: value, name: name, date: date)
            gain.delegate = self
            gain.handler = { (completed, confirmation) in
                gain.confirmation = confirmation
                self.amount += gain.value
                self.transactions.append(gain)
                self.gains.append(gain)
            }
            return gain
        }
    }
    
    public func transactionsFor(category: DebitCategories) -> [Transaction] {
        return transactions.filter({ (transaction) -> Bool in
            guard let transaction = transaction as? Debit else {
                return false
            }
            
            return transaction.isValid && transaction.category == category
        })
    }
    
    public func add(budget: Budget){
        self.budgets[budget.category] = budget
    }
    
    public func lifeTimeValue() -> Int {
        var total: Float = 0
        for key in budgets.keys {
            total = total + budgets[key]!.budget
        }
        
        let months = Int(amount/total)
        print("Tenemos \(months) meses de vida")
        
        return months
    }
}

extension Acccount: InvalidateTransaction {
    public func invalidateTrantraction(transaction: Transaction) {
        if transaction is Debit {
            amount += transaction.value
        }
        if transaction is Gain {
            amount -= transaction.value
        }
    }
}
