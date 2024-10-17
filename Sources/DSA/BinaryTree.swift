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

        var children: ArrayOfTwo<Node> {
            let _children = [leftChild, rightChild].compactMap { $0 }
            return ArrayOfTwo(_children)
        }

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

extension BinaryTree {
    convenience init?(arrayRepresentation: Array<Element>) {
        guard !arrayRepresentation.isEmpty else {
            return nil
        }

        // O(n)
        let nodes = arrayRepresentation.map(Node.init(value:))

        // O(n)
        for index in 0..<nodes.count {
            let childIndex = 2 * index
            let leftIndex = childIndex + 1
            let rightIndex = childIndex + 2

            if leftIndex < nodes.count {
                nodes[index].leftChild = nodes[leftIndex]
            }

            if rightIndex < nodes.count {
                nodes[index].rightChild = nodes[rightIndex]
            }
        }

        self.init(root: nodes.first)
    }
}

extension BinaryTree: ExpressibleByArrayLiteral {
    convenience init(arrayLiteral elements: Element...) {
        guard !elements.isEmpty else {
            self.init(root: nil)
            return
        }

        // O(n)
        let nodes = elements.map(Node.init(value:))

        // O(n)
        for index in 0..<nodes.count {
            let childIndex = 2 * index
            let leftIndex = childIndex + 1
            let rightIndex = childIndex + 2

            if leftIndex < nodes.count {
                nodes[index].leftChild = nodes[leftIndex]
            }

            if rightIndex < nodes.count {
                nodes[index].rightChild = nodes[rightIndex]
            }
        }

        self.init(root: nodes.first)
    }
}

extension BinaryTree where Element == String {
    static func create(from adjacencyList: AdjacencyList, root: String) -> BinaryTree? {
        guard !adjacencyList.isEmpty else {
            return nil
        }

        // O(n)
        let nodes = adjacencyList.keys.map { Node(value: $0) }

        // O(n)
        for index in 0..<nodes.count {
            let nodeValue = nodes[index].value

            guard let children = adjacencyList[nodeValue] else {
                continue
            }

            // since it's reference type
            let node = nodes[index]

            if let left = children[safe: 0] {
                node.leftChild = nodes.first(where: { $0.value == left })
            }

            if let right = children[safe: 1] {
                node.rightChild = nodes.first(where: { $0.value == right })
            }
        }

        return BinaryTree(root: nodes.first(where: { $0.value == root }))
    }
}
