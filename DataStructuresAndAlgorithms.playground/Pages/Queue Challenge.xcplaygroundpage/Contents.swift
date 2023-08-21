//: [Previous](@previous)

import Foundation

// MARK: - Array Based Queue
public protocol Queue {
  associatedtype Element
  mutating func enqueue(_ element: Element) -> Bool
  mutating func dequeue() -> Element?
  var isEmpty: Bool { get }
  var peek: Element? { get }
}
public struct QueueArray<T>: Queue {
  
  private var array: [T] = []
  public init() {}
  
  public var isEmpty: Bool {
    array.isEmpty
  }
  
  public var peek: T? {
    array.first
  }
  
  public mutating func enqueue(_ element: T) -> Bool {
    array.append(element)
    return true
  }
  
  public mutating func dequeue() -> T? {
    isEmpty ? nil : array.removeFirst()
  }
}
extension QueueArray: CustomStringConvertible {
  
  public var description: String {
    String(describing: array)
  }
}
public struct QueueStack<T> : Queue {
  
  private var leftStack: [T] = []
  private var rightStack: [T] = []
  public init() {}
  
  public var isEmpty: Bool {
    leftStack.isEmpty && rightStack.isEmpty
  }
  
  public var peek: T? {
    !leftStack.isEmpty ? leftStack.last : rightStack.first
  }
  
  public mutating func enqueue(_ element: T) -> Bool {
    rightStack.append(element)
    return true
  }
  
  public mutating func dequeue() -> T? {
    if leftStack.isEmpty {
      leftStack = rightStack.reversed()
      rightStack.removeAll()
    }
    return leftStack.popLast()
  }
}
extension QueueStack: CustomStringConvertible {
  
  public var description: String {
    let printList = leftStack.reversed() + rightStack
    return String(describing: printList)
  }
}

//3. Whose turn is it?
//
//Imagine that you are playing a game of Monopoly with your friends. The problem is that everyone always forget whose turn it is! Create a Monopoly organizer that always tells you whose turn it is. Below is a protocol that you can conform to:

public protocol BoardGameManager {
    
    associatedtype Player
    mutating func nextPlayer() -> Player?
}

//ANSWER

extension QueueArray: BoardGameManager {
  public typealias Player = T
  public mutating func nextPlayer() -> T? {
    guard let person = dequeue() else { // 1
return nil
    }
    enqueue(person) // 2
    return person // 3
} }

//EXAMPLE

var queue = QueueArray<String>()
queue.enqueue("Vincent")
queue.enqueue("Remel")
queue.enqueue("Lukiih")
queue.enqueue("Allison")
print(queue)
print("===== boardgame =======")
queue.nextPlayer()
print(queue)
queue.nextPlayer()
print(queue)
queue.nextPlayer()
print(queue)
queue.nextPlayer()
print(queue)

//Challenge 4: Reverse Queue

extension QueueArray {
  func reversed() -> QueueArray {
    var queue = self //1
      
      // Solution here.

      var stack = Stack<T>() //2
      while let element = queue.dequeue() { // 3
            stack.push(element)
          }
          while let element = stack.pop() { // 4
            queue.enqueue(element)
          }
      // Solution end
    return queue//5
} }
//1. Create a copy of the queue.
//2. Create a stack.
//3. dequeue all the elements in the queue onto the stack.
//4. pop all the elements off the stack and insert them into the queue.
//5. Return your reversed queue!

//EXAMPLE
var queue4 = QueueArray<String>()
queue4.enqueue("1")
queue4.enqueue("21")
queue4.enqueue("18")
queue4.enqueue("42")
print("before: \(queue4)")
print("after: \(queue4.reversed())")

//5. Double-ended queue
//
//A doubled-ended queue — a.k.a. a deque — is, as its name suggests, a queue where elements can be added or removed from the front or back.
//
//Recall:
//
//A queue (FIFO order) allows you to add elements to the back and remove from the front.
//A stack (LIFO order) allows you to add elements to the back, and remove from the back.
//
//Deque can be considered both a queue and a stack at the same time.
//
//A simple Deque protocol has been provided to help you build your data structure. An enum Direction has been provided to help describe whether you are adding or removing an element from the front or back of the deque. You can use any data structure you prefer to construct a Deque.
//
//Note: In DoubleLinkedList.swift one additional property and function has been added:
//
//A property called last has been added to help get the tail element of a double-linked list.
//A function called prepend(_:) has been added to help you add an element to the front of a double-linked list.

enum Direction {
  case front
case back }
protocol Deque {
  associatedtype Element
  var isEmpty: Bool { get }
  func peek(from direction: Direction) -> Element?
  mutating func enqueue(_ element: Element,
                        to direction: Direction) -> Bool
  mutating func dequeue(from direction: Direction) -> Element?
}

class DequeDoubleLinkedList<Element>: Deque {
  
  private var list = DoublyLinkedList<Element>()
  public init() {}
  
  var isEmpty: Bool {
    list.isEmpty
  }
  
  func peek(from direction: Direction) -> Element? {
    switch direction {
    case .front:
      return list.first?.value
    case .back:
      return list.last?.value
    }
  }
  
  func enqueue(_ element: Element, to direction: Direction) -> Bool {
    switch direction {
    case .front:
      list.prepend(element)
    case .back:
      list.append(element)
    }
    return true
  }
  
  func dequeue(from direction: Direction) -> Element? {
    let element: Element?
    switch direction {
    case .front:
      guard let first = list.first else { return nil }
      element = list.remove(first)
    case .back:
      guard let last = list.last else { return nil }
      element = list.remove(last)
    }
    return element
  }
}

extension DequeDoubleLinkedList: CustomStringConvertible {
  
  public var description: String {
    String(describing: list)
  }
}


let deque = DequeDoubleLinkedList<Int>()
deque.enqueue(1, to: .back)
deque.enqueue(2, to: .back)
deque.enqueue(3, to: .back)
deque.enqueue(4, to: .back)

print(deque)

deque.enqueue(5, to: .front)

print(deque)

deque.dequeue(from: .back)
deque.dequeue(from: .back)
deque.dequeue(from: .back)
deque.dequeue(from: .front)
deque.dequeue(from: .front)
deque.dequeue(from: .front)

print(deque)


//: [Next](@next)
