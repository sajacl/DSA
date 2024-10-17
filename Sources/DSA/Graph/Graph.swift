import Foundation

struct Graph<Value> {
    private var storage: [Node] = []

    init(storage: [Node]) {
        self.storage = storage
    }

//    mutating func add(_ newNode: Node) {
//        storage.append(newNode)
//    }

    mutating func add(_ newValue: Value, neighbours: [Node] = []) {
        let newNode = Node(value: newValue, neighbours: [])

        storage.append(newNode)
    }

    struct Node {
        let value: Value

        fileprivate var neighbours: [Node]

        init(value: Value, neighbours: [Node]) {
            self.value = value
            self.neighbours = neighbours
        }
    }
}

extension Graph where Value == String {
    static func create(from adjacencyList: AdjacencyList) -> Graph<String> {
        var graphNodes: [Node] = []

        for adjacency in adjacencyList {
            var neighbours: [Node] = []

            for neighbour in adjacency.value {
                let neighbourNode = Node(value: neighbour, neighbours: [])

                neighbours.append(neighbourNode)
            }

            let node = Node(value: adjacency.key, neighbours: neighbours)

            graphNodes.append(node)
        }

        return Graph(storage: graphNodes)
    }
}
