import XCTest
@testable import DSA

final class GraphTests: XCTestCase {
    func testA() {
        // aka graph
        let adjacencyList = [
            "A": ["B", "C"],
            "B": ["F"],
            "C": ["D", "E"],
            "D": [],
            "E": [],
            "F": []
        ]

        let source = "A" // adjacencyList.keys.first!

//        dfs(adjacencyList, source: source)
//        rdfs(adjacencyList, source: source)

        bfs(adjacencyList, source: source)
    }

    private func dfs(_ graph: [String: [String]], source: String) {
        var stack = Stack<String>()

        stack.push(source)

        while let head = stack.pop() {
            print(head)

            for neighbour in (graph[head] ?? []) {
                stack.push(neighbour)
            }
        }
    }

    private func rdfs(_ graph: [String: [String]], source: String) {
        print(source)

        for neighbour in (graph[source] ?? []) {
            rdfs(graph, source: neighbour)
        }
    }

    private func bfs(_ graph: [String: [String]], source: String) {
        var queue = Queue<String>()

        queue.enqueue(source)

        while let head = queue.dequeue() {
            print(head)

            let neighbours = graph[head] ?? []

            for neighbour in neighbours {
                queue.enqueue(neighbour)
            }
        }
    }

    func testB() {
        let adjacencyList = [
            "A": ["B", "C"],
            "B": ["F"],
            "C": ["D", "E"],
            "D": [],
            "E": [],
            "F": []
        ]

        let graph = Graph<String>.create(from: adjacencyList)

        print(graph)
    }
}
