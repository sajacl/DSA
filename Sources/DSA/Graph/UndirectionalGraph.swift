import Foundation

/// Value type `Graph` that represents a undirectional graph.
struct UndirectionalGraph<Element> {
    private var root: Node?

    init(root: Node?) {
        self.root = root
    }

    final class Node {
        fileprivate let value: Element

        fileprivate var neighbours: [Node]

        init(value: Element, neighbours: [Node] = []) {
            self.value = value
            self.neighbours = neighbours
        }
    }
}

extension UndirectionalGraph.Node: Equatable where Element: Equatable {
    static func == (
        lhs: UndirectionalGraph<Element>.Node,
        rhs: UndirectionalGraph<Element>.Node
    ) -> Bool {
        lhs.value == rhs.value && rhs.neighbours == rhs.neighbours
    }
}

extension UndirectionalGraph.Node: Hashable where Element: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

// Copying
extension UndirectionalGraph where Element: Hashable {
    mutating func addNode(value: Element, to parent: Node?) {
        // COW: Ensure unique reference before mutation
        if !isKnownUniquelyReferenced(&root) {
            self.root = deepCopyNode(original: root)
        }

        let newNode = Node(value: value)
        parent?.neighbours.append(newNode)
    }

    // Deep copy method for external use
    func deepCopy() -> UndirectionalGraph<Element> {
        let newRoot = deepCopyNode(original: root)
        return UndirectionalGraph<Element>(root: newRoot)
    }

    private func deepCopyNode(original: Node?) -> Node? {
        guard let original = original else { return nil }

        var visited = [Node: Node]()
        return copyNode(original: original, visited: &visited)
    }

    private func copyNode(original: Node, visited: inout [Node: Node]) -> Node {
        if let existingCopy = visited[original] {
            return existingCopy
        }

        let nodeCopy = Node(value: original.value)
        visited[original] = nodeCopy

        for neighbour in original.neighbours {
            let neighbourCopy = copyNode(original: neighbour, visited: &visited)
            nodeCopy.neighbours.append(neighbourCopy)
        }

        return nodeCopy
    }
}

// Iteration
extension UndirectionalGraph where Element: Hashable {
    func rdfs() {
        guard let root else {
            return
        }

        var visited = Set<Node>()
        rdfs(root: root, visited: &visited)
    }

    private func rdfs(root: Node?, visited: inout Set<Node>) {
        guard let root else {
            return
        }

        guard !visited.contains(root) else {
            return
        }

        print(root.value)

        visited.insert(root)

        let neighbours = root.neighbours

        for neighbour in neighbours {
            rdfs(root: neighbour, visited: &visited)
        }
    }
}

extension UndirectionalGraph: CustomStringConvertible {
    var description: String {
        guard let root = root else {
            return "Graph is empty."
        }

        var visited = Set<ObjectIdentifier>()
        return printNode(node: root, prefix: "", isTail: true, visited: &visited)
    }

    private func printNode(
        node: Node,
        prefix: String,
        isTail: Bool,
        visited: inout Set<ObjectIdentifier>
    ) -> String {
        let nodeID = ObjectIdentifier(node)

        var description = ""

        if visited.contains(nodeID) {
            description += "\(prefix)\(isTail ? "└── " : "├── ")\(node.value) (already printed)\n"
            return description
        }

        visited.insert(nodeID)

        description = "\(prefix)\(isTail ? "└── " : "├── ")\(node.value)\n"

        let newPrefix = prefix + (isTail ? "    " : "│   ")
        let count = node.neighbours.count
        for (i, neighbour) in node.neighbours.enumerated() {
            let isLast = i == count - 1
            description += printNode(node: neighbour, prefix: newPrefix, isTail: isLast, visited: &visited)
        }

        return description
    }
}

extension UndirectionalGraph where Element == String {
    static func create(
        from adjacencyList: AdjacencyList,
        root: String
    ) -> UndirectionalGraph<String>? {
        guard !adjacencyList.isEmpty else {
            return nil
        }

        let nodes = adjacencyList.keys.map { Node(value: $0) }

        for index in 0..<nodes.count {
            let node = nodes[index]
            let adjacencyListKey = node.value

            guard let neighbour = adjacencyList[adjacencyListKey] else {
                continue
            }

            neighbour.forEach { value in
                let neighbourNode = nodes.first(where: { $0.value == value })!

                node.neighbours.append(neighbourNode)
            }
        }

        return UndirectionalGraph(root: nodes.first(where: { $0.value == root })!)
    }
}
