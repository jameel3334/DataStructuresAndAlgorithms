//: [Previous](@previous)

import Foundation

public class Node<Value> {
  public var value: Value
  public var next: Node?
  public init(value: Value, next: Node? = nil) {
    self.value = value
    self.next = next
  }
}
extension Node: CustomStringConvertible {
  public var description: String {
    guard let next = next else {
      return "\(value)"
    }
    return "\(value) -> " + String(describing: next) + " "
  }
}


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
    
    //pop operations
    
    @discardableResult
    public mutating func pop() -> Value? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil }
        }
        return head?.value
    }
    //    removeLast operations
    @discardableResult
    public mutating func removeLast() -> Value? {
        // 1
        guard let head = head else {
            return nil
        }
        // 2
        guard head.next != nil else {
            return pop()
        }
        // 3
        var prev = head
        var current = head
        while let next = current.next {
            prev = current
            current = next
        }
        // 4
        prev.next = nil
        tail = prev
        return current.value
    }
    
    @discardableResult
    public mutating func remove(after node: Node<Value>) -> Value? {
        defer {
            if node.next === tail {
                tail = node }
            node.next = node.next?.next
        }
        return node.next?.value
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

//    example(of: "pop") {
      var list3 = LinkedList<Int>()
      list3.push(3)
      list3.push(2)
      list3.push(1)
      print("Before popping list: \(list3)")
    let poppedValue = list.pop()
    print("After popping list: \(list)")
    print("Popped value: " + String(describing: poppedValue))
  
//    example(of: "removing the last node") {
      var list4 = LinkedList<Int>()
      list4.push(3)
      list4.push(2)
      list4.push(1)
      print("Before removing last node: \(list4)")
      let removedValue = list4.removeLast()
      print("After removing last node: \(list4)")
      print("Removed value: " + String(describing: removedValue))
    
//    example(of: "removing a node after a particular node") {
      var list5 = LinkedList<Int>()
      list5.push(3)
      list5.push(2)
      list5.push(1)
      print("Before removing at particular index: \(list5)")
      let index = 1
      let node = list5.node(at: index - 1)!
      let removeddValue = list5.remove(after: node)
      print("After removing at index \(index): \(list5)")
      print("Removed value: " + String(describing: removeddValue))
    
    
    
    
//: [Next](@next)
