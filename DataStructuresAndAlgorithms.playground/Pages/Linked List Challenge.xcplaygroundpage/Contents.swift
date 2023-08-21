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


//Challenge 1: Print in reverse
//Create a function that prints the nodes of a linked list in reverse order. For example:
//1 -> 2 -> 3 -> nil
// should print out the following:
//3
//2
//1
private func printInReverse<T>(_ node: Node<T>?) {
    // 1
    guard let node = node else { return }
    // 2
    printInReverse(node.next)
    print(node.value)
}

func printInReverse<T>(_ list: LinkedList<T>) {
    printInReverse(list.head)
}
//example(of: "printing in reverse") {
var list = LinkedList<Int>()
list.push(3)
list.push(2)
list.push(1)
print("Original list: \(list)")
print("Printing in reverse:")
printInReverse(list)



//Challenge 2: Find the middle node
//Create a function that finds the middle node of a linked list. For example:
//1 -> 2 -> 3 -> 4 -> nil
// middle is 3
//1 -> 2 -> 3 -> nil
// middle is 2

func getMiddle<T>(_ list: LinkedList<T>) -> Node<T>? {
    var slow = list.head
    var fast = list.head
    while let nextFast = fast?.next {
        fast = nextFast.next
        slow = slow?.next
    }
    return slow }

//example(of: "getting the middle node") {
var list1 = LinkedList<Int>()
list1.push(3)
list1.push(2)
list1.push(1)
print(list1)
if let middleNode = getMiddle(list1) {
    print(middleNode)
}



//Challenge 3: Reverse a linked list
//Create a function that reverses a linked list. You do this by manipulating the nodes so that they’re linked in the other direction. For example:
// before
//1 -> 2 -> 3 -> nil
// after
//3 -> 2 -> 1 -> nil

//NOT BEST WAY
//extension LinkedList {
//  mutating func reverse() {
//// 1
//    let tmpList = LinkedList<Value>()
//    for value in self {
//      tmpList.push(value)
//    }
//// 2
//    head = tmpList.head
//  }
//}

extension LinkedList {
    mutating func reverse() {
        tail = head
        var prev = head
        var current = head?.next
        prev?.next = nil
        while current != nil {
            let next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        head = prev
    }
}
//    example(of: "reversing a list") {
var list2 = LinkedList<Int>()
list2.push(3)
list2.push(2)
list2.push(1)
print("Original list: \(list2)")
list2.reverse()
print("Reversed list: \(list2)")


//Challenge 4: Merge two lists
//Create a function that takes two sorted linked lists and merges them into a single sorted linked list. Your goal is to return a new linked list that contains the nodes from two lists in sorted order. You may assume the sort order is ascending. For example:
// list1
//1 -> 4 -> 10 -> 11
// list2
//-1 -> 2 -> 3 -> 6
// merged list
//-1 -> 1 -> 2 -> 3 -> 4 -> 6 -> 10 -> 11

func returnSortedList<T:Comparable> (_ left: LinkedList<T>, _ right: LinkedList<T>) -> LinkedList<T> {
    
    var sortedList = LinkedList<T>()
    guard !left.isEmpty else {
        return right
    }
    guard !right.isEmpty else {
        return left }
    var newHead: Node<T>?
    
    //Setting up
    // 1
    var tail: Node<T>?
    var currentLeft = left.head
    var currentRight = right.head
    // 2
    if let leftNode = currentLeft, let rightNode = currentRight {
        if leftNode.value < rightNode.value {
            newHead = leftNode
            currentLeft = leftNode.next
        } else {
            newHead = rightNode
            currentRight = rightNode.next
        }
        tail = newHead
    }
    
    //Merging
    while let leftNode = currentLeft, let rightNode = currentRight {
        // 2
        if leftNode.value < rightNode.value {
            tail?.next = leftNode
            currentLeft = leftNode.next
        } else {
            tail?.next = rightNode
            currentRight = rightNode.next
        }
        tail = tail?.next
    }
    
    //Add the following to handle the remaining nodes:
    
    if let leftNodes = currentLeft {
        tail?.next = leftNodes
    }
    if let rightNodes = currentRight {
        tail?.next = rightNodes
    }
    //To wrap things up, you instantiate a new list. Instead of using using the append or insert methods to insert elements to the list, you’ll simply set the reference of the head and tail of the list directly:
    sortedList.head = newHead
    sortedList.tail = {
        while let next = tail?.next {
            tail = next }
        return tail
    }()
    return sortedList
}

//example(of: "merging two lists") {
var list4 = LinkedList<Int>()
list4.push(3)
list4.push(2)
list4.push(1)
var anotherList = LinkedList<Int>()
anotherList.push(-1)
anotherList.push(-2)
anotherList.push(-3)
print("First list: \(list)")
print("Second list: \(anotherList)")
let mergedList = returnSortedList(list, anotherList)
print("Merged list: \(mergedList)")






//Challenge 5: Remove all occurrences
//Create a function that removes all occurrences of a specific element from a linked list. The implementation is similar to the remove(at:) method you implemented for the linked list. For example:
// original list
//1 -> 3 -> 3 -> 3 -> 4
// list after removing all occurrences of 3
//1 -> 4

extension LinkedList where Value: Equatable {
  
  mutating func removeAll(_ value: Value) {
    while let head = self.head, head.value == value {
      self.head = head.next
    }
    var prev = head
    var current = head?.next
    while let currentNode = current {
      if currentNode.next == nil {
        tail
      }
      guard currentNode.value != value else {
        prev?.next = currentNode.next
        current = prev?.next
        continue
      }
      prev = current
      current = current?.next
    }
    tail = prev
  }
}

//example(of: "deleting duplicate nodes") {
  var list5 = LinkedList<Int>()
  list5.push(3)
  list5.push(2)
  list5.push(2)
  list5.push(1)
  list5.push(1)
  
  list5.removeAll(3)
  print(list5)



//: [Next](@next)
