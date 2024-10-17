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
