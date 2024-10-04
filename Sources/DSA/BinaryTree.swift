import Foundation

final class BinaryTree<Element> {
    private var root: Node?

    init(root: Node? = nil) {
        self.root = root
    }

    func dfs() {
        guard let root else {
            return
        }

        var stack = Stack<Node>()

        stack.push(root)

        while let current = stack.pop() {
            print(current.value)

            // favouring left child
            if let rightChild = current.rightChild {
                stack.push(rightChild)
            }

            if let leftChild = current.leftChild {
                stack.push(leftChild)
            }
        }
    }

    func rdfs() {
        guard let root else {
            return
        }

        _rdfs(root)
    }

    private func _rdfs(_ node: Node) {
        // favouring left child
        print(node.value)

        if let leftChild = node.leftChild {
            _rdfs(leftChild)
        }

        if let rightChild = node.rightChild {
            _rdfs(rightChild)
        }
    }

    func bfs() {
        guard let root else {
            return
        }

        var queue = Queue<Node>()

        queue.enqueue(root)

        while let head = queue.dequeue() {
            print(head.value)

            // favouring left child
            if let leftChild = head.leftChild {
                queue.enqueue(leftChild)
            }

            if let rightChild = head.rightChild {
                queue.enqueue(rightChild)
            }
        }
    }

    final class Node: CustomStringConvertible {
        fileprivate let value: Element

        fileprivate var leftChild: Node?

        fileprivate var rightChild: Node?

        init(value: Element) {
            self.value = value
        }

        func modify(_ modificationBlock: (Builder) -> Void) {
            modificationBlock(Builder(node: self))
        }

        var description: String {
            "\(value)"
        }

        final class Builder {
            private let node: Node

            fileprivate init(node: BinaryTree<Element>.Node) {
                self.node = node
            }

            @discardableResult
            func withAddingLeftChild(_ left: Node?) -> Self {
                node.leftChild = left
                return self
            }

            @discardableResult
            func withAddingRightChild(_ left: Node?) -> Self {
                node.rightChild = left
                return self
            }
        }
    }
}

extension BinaryTree where Element == String {
    /*
     [A: [B, C]]
     */

    convenience init(adjacencyList: AdjacencyList) {
        let _root = adjacencyList.first!

        let rootNode = Node(value: _root.key)

        rootNode.modify { builder in
            let children = _root.value

            if let left = children.first {
                let leftNode = Node(value: left)
                builder.withAddingLeftChild(leftNode)
            }

            if children.count > 1 {
                let right = children[1]
                let rightNode = Node(value: right)
                builder.withAddingRightChild(rightNode)
            }
        }

        //        root =
        for node in adjacencyList {
            let rootNode = Node(value: node.key)

            rootNode.modify { builder in
                let children = node.value

                if let left = children.first {
                    let leftNode = Node(value: left)

                    builder.withAddingLeftChild(leftNode)
                }

                if children.count > 1 {
                    let right = children[1]
                    let rightNode = Node(value: right)

                    builder.withAddingRightChild(rightNode)
                }
            }
        }

        self.init(root: rootNode)
    }
}

extension BinaryTree/*: Sequence*/ {
//    func makeIterator() -> some IteratorProtocol {
//        DFSIterator(tree: self)!
//    }

    struct DFSIterator: IteratorProtocol {
        private var stack = Stack<Node>()

        init(current: Node) {
            stack.push(current)
        }

        init?(tree: BinaryTree) {
            guard let root = tree.root else {
                return nil
            }

            stack.push(root)
        }

        mutating func next() -> Node? {
            guard let current = stack.pop() else {
                return nil
            }

            if let rightChild = current.rightChild {
                stack.push(rightChild)
            }

            if let leftChild = current.leftChild {
                stack.push(leftChild)
            }

            return current
        }
    }

    struct BFSIterator: IteratorProtocol {
        private var queue = Queue<Node>()

        init(current: Node) {
            queue.enqueue(current)
        }

        init?(tree: BinaryTree) {
            guard let root = tree.root else {
                return nil
            }

            queue.enqueue(root)
        }

        mutating func next() -> Node? {
            guard let head = queue.dequeue() else {
                return nil
            }

            if let leftChild = head.leftChild {
                queue.enqueue(leftChild)
            }

            if let rightChild = head.rightChild {
                queue.enqueue(rightChild)
            }

            return head
        }
    }
}

extension BinaryTree where Element: Equatable {
    func contains(_ value: Element) -> Bool {
        guard let root else {
            return false
        }

        var stack = Stack<Node>()

        stack.push(root)

        while let current = stack.pop() {
            if value == current.value {
                return true
            }

            // favouring left child
            if let rightChild = current.rightChild {
                stack.push(rightChild)
            }

            if let leftChild = current.leftChild {
                stack.push(leftChild)
            }
        }

        return false
    }
}
