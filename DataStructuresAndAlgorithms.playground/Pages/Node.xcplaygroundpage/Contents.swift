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

//This code defines a generic linked list node class in Swift, along with an extension that conforms to the CustomDescriptionConvertible protocol to provide a custom textual representation of the linked list.
//
//Let's break down the code step by step:
//
//public class Node<Value> { ... }: This defines a generic class named Node that represents a single node in a linked list. The generic type parameter Value allows you to use the node to store values of any type. The class has two properties:
//
//public var value: Value: This property holds the value of the node.
//public var next: Node?: This property is a reference to the next node in the linked list. It's an optional type because the last node in the list doesn't have a next node, so it's initialized to nil.
//public init(value: Value, next: Node? = nil) { ... }: This is the initializer for the Node class. It takes two parameters: the value to be stored in the node and an optional reference to the next node in the list. If the next parameter is not provided, it defaults to nil. This allows you to conveniently create nodes without specifying the next node.
//
//extension Node: CustomDescriptionConvertible { ... }: This is an extension of the Node class that conforms to the CustomDescriptionConvertible protocol. This protocol allows you to provide a custom textual representation of the node.
//
//public var description: String { ... }: This is the implementation of the custom description. It overrides the default description property of the Node class. The method constructs a string representation of the linked list starting from the current node. It checks if the next property is nil. If it is, the node is the last one in the list, and its value is returned as the description. If not, it recursively calls the description property of the next node and concatenates it with the current node's value and an arrow symbol (->). This creates a visual representation of the linked list, showing the sequence of values and their connections.
//
//By using this code, you can create instances of the Node class to build linked lists with any type of values. The custom description enhances debugging and visualization by providing a clear representation of the linked list structure and its elements.

//example(of: "creating and linking nodes") 
let node1 = Node(value: 1)
let node2 = Node(value: 2)
let node3 = Node(value: 3)
node1.next = node2
node2.next = node3
print(node1)

//: [Next](@next)
