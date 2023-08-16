//: [Previous](@previous)

import Foundation
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

//Challenge 1: Reverse an Array
//Create a function that uses a stack to print the contents of an array in reversed order.

func printInReverse<T>(_ values: Array<T>) {

    var stack = Stack<T>()
    for value in values {
        stack.push(value)
    }
    while let value = stack.pop() {
        print(value)
    }
}


//Challenge 2: Balance the parentheses
//Check for balanced parentheses. Given a string, check if there are ( and ) characters, and return true if the parentheses in the string are balanced.
//For example:
// 1
//h((e))llo(world)() // balanced parentheses
// 2
//(hello world // unbalanced parentheses
//: [Next](@next)

func checkParentheses(in word: String) -> Bool {
    var stacks = Stack<Character>()
    if !word.contains("()") {
        return false
    }
    for w in word {
        if w == "(" || w == ")" {
            stacks.push(w)
        }
    }
    while let w = stacks.pop() {
        if w == ")" {
            return true
        }
    }
    return true
}

let check = checkParentheses(in: "h((e))llo(world)(")
print(check)

//Book Solution
//func checkParentheses(_ string: String) -> Bool {
//  var stack = Stack<Character>()
//  for character in string {
//    if character == "(" {
//      stack.push(character)
//    } else if character == ")" {
//      if stack.isEmpty {
//        return false
//} else {
//        stack.pop()
//      }
//} }
//  return stack.isEmpty
//}
