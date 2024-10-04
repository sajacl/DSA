import Foundation

final class LinkedList<Element: Equatable> {
    private(set) var head: Node?

    var isEmpty: Bool {
        head == nil
    }

    var last: Node? {
        var _head = head

        while let next = _head?.next {
            _head = next
        }

        return _head
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
            return
        }

        newNode.next = _head
        head = newNode
    }

    func append(_ newValue: Element) {
        let newNode = Node(value: newValue)

        append(newNode)
    }

    func append(_ newNode: Node) {
        if head == nil {
            head = newNode
            return
        }

        last?.next = newNode
    }

    func insert(_ newNode: Node, at index: UInt) {
        if head == nil {
            head = newNode
            return
        }

        var indexer = IndexingIterator(list: self)

        while let iteration = indexer.next() {
            if iteration.index == index - 1 {
                let next = iteration.node?.next

                iteration.node?.next = newNode
                newNode.next = next
            }
        }
    }

    func removeLast() {
        if head?.next == nil {
            head = nil
            return
        }

        var _head = head

        while let next = _head?.next {
            let descendent = next.next

            if descendent == nil {
                _head?.next = nil
                break
            }

            _head = next
        }
    }

    func remove(_ node: Node) {
        if head == node {
            head = head?.next
            return
        }

        var _head = head

        while let next = _head?.next {
            if next == node {
                let descendent = next.next

                _head?.next = descendent
                break
            }

            _head = next
        }
    }

    @discardableResult
    func remove(at index: UInt) -> Node? {
        if head == nil {
            return nil
        }

        var indexer = IndexingIterator(list: self)

        while let iteration = indexer.next() {
            if iteration.index == index - 1 {
                let descendent = iteration.node?.next?.next

                iteration.node?.next = descendent
            }
        }

        return nil
    }

    func node(at index: UInt) -> Node? {
        var indexer = IndexingIterator(list: self)

        while let iteration = indexer.next() {
            if iteration.index == index {
                return iteration.node
            }
        }

        return nil
    }

    final class Node {
        /*private*/ let value: Element

        fileprivate var next: Node?

        init(value: Element) {
            self.value = value
        }
    }
}

extension LinkedList.Node: Equatable {
    static func == (lhs: LinkedList<Element>.Node, rhs: LinkedList<Element>.Node) -> Bool {
        lhs.value == rhs.value
    }
}

extension LinkedList: Sequence {
    struct Iterator: IteratorProtocol {
        let list: LinkedList

        private var current: Node?

        init(list: LinkedList) {
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

    func makeIterator() -> LinkedList.Iterator {
        Iterator(list: self)
    }
}

extension LinkedList {
    struct Index: Comparable {
        static func < (lhs: Index, rhs: Index) -> Bool {
            lhs.index < rhs.index
        }
        
        let index: UInt

        let node: Node?

//        static let zero = Index(tag: 0)
    }

    struct IndexingIterator: IteratorProtocol {
        let list: LinkedList

        private var index: UInt = 0

        private var current: Node?

        init(list: LinkedList) {
            self.list = list
        }

        mutating func next() -> Index? {
            guard let head = list.head else {
                return nil
            }

            defer {
                let (_, isOverFlow) = index.addingReportingOverflow(1)

                if !isOverFlow {
                    index += 1
                } else {
                    index = UInt.max
                }
            }

            if let _current = current {
                guard let next = _current.next else {
                    return nil
                }

                current = next

                return Index(index: index, node: next)
            }

            let next = head

            current = next

            return Index(index: 0, node: next)
        }
    }
}

extension LinkedList: Collection {
    func index(after i: Index) -> Index {
        var indexer = IndexingIterator(list: self)

        var index: UInt = 0

        while let iteration = indexer.next() {
            index = iteration.index

            if index == i.index {
                if let node = iteration.node, node.next == nil {
                    return iteration
                }
            }
        }

        fatalError()
//        node(at: i.index)
    }
    
    var startIndex: Index {
        Index(index: 0, node: head)
    }
    
    var endIndex: Index {
        var indexer = IndexingIterator(list: self)

        var index: UInt = 0
        var node: Node?

        while let iteration = indexer.next() {
            index = iteration.index
            node = iteration.node
        }

        return Index(index: index, node: node)
    }

    subscript(position: Index) -> Node {
        node(at: position.index)!
    }
}

extension LinkedList: ExpressibleByArrayLiteral where Element == Int {
    convenience init(arrayLiteral elements: Int...) {
        self.init()

        elements
            .map { Node(value: $0) }
            .forEach { node in
                append(node)
            }
    }
}

extension LinkedList.Node: CustomStringConvertible {
    struct NodeDescriptor {
        let node: LinkedList.Node

        var description: String {
            let nextValueRepresentation: String = {
                let nextNode = node.next

                if let nextNode {
                    return "\(nextNode.value)"
                }

                return "nil"
            }()

            return "(\(node.value)) -> [\(nextValueRepresentation)]"
        }
    }

    var description: String {
        NodeDescriptor(node: self)
            .description
    }
}
