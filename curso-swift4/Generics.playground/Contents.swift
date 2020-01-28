import Foundation

func sum<T: Numeric>(a: T, b: T) -> T {
    return a + b
}

sum(a: 1.8, b: 5)

class Stack<Element> {
    var items: [Element] = []
    
    func push(_ item: Element) {
        items.append(item)
    }
    
    func pop() -> Element {
        return items.removeLast()
    }
}

var stack = Stack<Int>()

stack.push(2)
stack.push(3)
stack.push(7)
stack.push(1)

stack.pop()

print(stack.items)

var stack2 = Stack<String>()

stack2.push("Andres")
stack2.push("Dos")
stack2.push("Tres")
stack2.push("Uno")

stack2.pop()

print(stack2.items)
