//: [Previous](@previous)

import Foundation

public struct LinkedList<Value> {
    public var head: Node<Value>?
    public var tail: Node<Value>?
    public init() {}
    public var isEmpty: Bool {
        head == nil }
    public mutating func push(_ value: Value) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head }
    }
    public mutating func append(_ value: Value) {
        // 1
        guard !isEmpty else {
            push(value)
            return
        }
        // 2
        tail!.next = Node(value: value)
        // 3
        tail = tail!.next
    }
    public func node(at index: Int) -> Node<Value>? {
        // 1
        var currentNode = head
        var currentIndex = 0
        // 2
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        return currentNode
    }
    @discardableResult
    public mutating func insert(_ value: Value,
    // 2
    after node: Node<Value>)
    -> Node<Value> {
      guard tail !== node else {
        append(value)
        return tail!
      }
    // 3
      node.next = Node(value: value, next: node.next)
      return node.next!
    }
}
extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}

//example(of: "push")
var list = LinkedList<Int>()
list.push(3)
list.push(2)
list.push(1)
print(list)
//example(of: "append") {
var list1 = LinkedList<Int>()
list1.append(1)
list1.append(2)
list1.append(3)
print(list1)

//example(of: "inserting at a particular index")
  var list2 = LinkedList<Int>()
  list2.push(3)
  list2.push(2)
  list2.push(1)
  print("Before inserting: \(list2)")
  var middleNode = list2.node(at: 1)!
  for _ in 1...4 {
    middleNode = list2.insert(-1, after: middleNode)
  }
  print("After inserting: \(list2)")

//: [Next](@next)
