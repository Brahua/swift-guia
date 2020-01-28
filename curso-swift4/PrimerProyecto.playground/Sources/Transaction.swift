import Foundation


public protocol InvalidateTransaction {
    func invalidateTrantraction(transaction: Transaction)
}

public typealias TransactionHandler = ( (_ completed: Bool, _ confirmation: Date) -> Void )

public protocol Transaction {
    var value: Float { get }
    var name: String { get }
    var isValid: Bool { get set }
    var delegate: InvalidateTransaction? { get set } //delegate
    var date: Date { get }
    var handler: TransactionHandler? { get set } //clousure
    var completed: Bool { get }
    var confirmation: Date? { get set }
}

extension Transaction {
    mutating public func invalidateTrantraction() {
        if completed {
            isValid = false
            delegate?.invalidateTrantraction(transaction: self)
        }
    }
}
