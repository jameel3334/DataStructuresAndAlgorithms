import UIKit

//Stack

public struct Stack<Element> {
    private var storage: [Element] = []
    public init() { }
    
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast()
    }
    public func peek() -> Element? {
     storage.last
    }
    public var isEmpty: Bool {
      peek() == nil
    }
    public init(_ elements: [Element]) {
      storage = elements
    }
}
extension Stack: CustomDebugStringConvertible {
    public var debugDescription: String {
    """
    // ----top----
    \(storage.map { "\($0)" }.reversed().joined(separator: "\n"))
    //-----------
    """
    }
}
extension Stack: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: Element...) {
    storage = elements
  }
}
//EXAMPLE (of: "using a stack")
  var stack = Stack<Int>()
  stack.push(1)
  stack.push(2)
  stack.push(3)
  stack.push(4)
  print(stack)
    
    if let poppedElement = stack.pop() {
        assert(4 == poppedElement)
        print("Popped: \(poppedElement)")
      }
    print(stack)

//EXAMPLE 2 "initializing a stack from an array")
  let array = ["A", "B", "C", "D"]
  var stack2 = Stack(array)
  print(stack2)
  stack2.pop()

//EXAMPLE # (of: "initializing a stack from an array literal")
var stack3: Stack = [1.0, 2.0, 3.0, 4.0]
print(stack3)
stack3.pop()


//Stacks are crucial to problems that search trees and graphs. Imagine finding your way through a maze. Each time you come to a decision point of left, right or straight, you can push all possible decisions onto your stack. When you hit a dead end, simply backtrack by popping from the stack and continuing until you escape or hit another dead end
//: [Next](@next)

