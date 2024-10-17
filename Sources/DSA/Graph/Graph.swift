import Foundation

struct Graph<Element> {
    private var root: Node?

    init(root: Node?) {
        self.root = root
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

        node.neighbours.forEach { neighbour in
            _rdfs(neighbour)
        }
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

extension Graph where Element == String {
    static func create(from adjacencyList: AdjacencyList, root: String) -> Graph<String>? {
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

        return Graph(root: nodes.first(where: { $0.value == root })!)
    }
}
