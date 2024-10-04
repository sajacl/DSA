import Foundation

final class DoublyLinkedList<Element> {
    private(set) var head: Node?
    
    private(set) var tail: Node?

    var isEmpty: Bool {
        head == nil
    }

    var last: Node? {
        tail
    }

    var count: UInt {
        if head == nil {
            return 0
        }

        var _head = head
        var count: UInt = 1

        while let next = _head?.next {
            let (_, isOverflow) = count.addingReportingOverflow(1)

            if isOverflow {
                count = UInt.max
            } else {
                count += 1
            }

            _head = next
        }

        return count
    }

    func prepend(_ newValue: Element) {
        let newNode = Node(value: newValue)

        prepend(newNode)
    }

    func prepend(_ newNode: Node) {
        guard let _head = head else {
            head = newNode
            tail = newNode

            return
        }

        newNode.next = _head
        _head.previous = newNode

        head = newNode
    }

    func append(_ newValue: Element) {
        let newNode = Node(value: newValue)

        append(newNode)
    }

    func append(_ newNode: Node) {
        if head == nil, tail == nil {
            head = newNode
            tail = newNode
        } else {
            let _oldTail = tail
            _oldTail!.next = newNode
            newNode.previous = _oldTail

            tail = newNode
        }
    }

    func removeLast() {
        let backwardDescendent = tail?.previous

        backwardDescendent?.next = nil
        tail = backwardDescendent
    }

    final class Node {
        let value: Element

        fileprivate var next: Node?

        fileprivate var previous: Node?

        init(value: Element) {
            self.value = value
        }
    }
}

extension DoublyLinkedList: Sequence {
    struct Iterator: IteratorProtocol {
        let list: DoublyLinkedList

        private var current: Node?

        init(list: DoublyLinkedList) {
            self.list = list
        }

        mutating func next() -> Node? {
            guard let head = list.head else {
                return nil
            }

            if let _current = current {
                let next = _current.next

                current = next

                return next
            }

            let next = head

            current = next

            return next
        }
    }

    func makeIterator() -> Iterator {
        Iterator(list: self)
    }
}

extension DoublyLinkedList: ExpressibleByArrayLiteral where Element == Int {
    convenience init(arrayLiteral elements: Int...) {
        self.init()

        elements
            .map { Node(value: $0) }
            .forEach { node in
                append(node)
            }
    }
}

extension DoublyLinkedList.Node: CustomStringConvertible {
    struct NodeDescriptor {
        let node: DoublyLinkedList.Node

        var description: String {
            let previousValueRepresentation: String = {
                let previousNode = node.previous

                if let previousNode {
                    return "\(previousNode.value)"
                }

                return "nil"
            }()

            let nextValueRepresentation: String = {
                let nextNode = node.next

                if let nextNode {
                    return "\(nextNode.value)"
                }

                return "nil"
            }()

            return "[\(previousValueRepresentation)] -> (\(node.value)) -> [\(nextValueRepresentation)]"
        }
    }

    var description: String {
        NodeDescriptor(node: self)
            .description
    }
}
