import XCTest
@testable import DSA

final class UndirectionalGraphTests: XCTestCase {
    func testTraversal() throws {
        let adjacencyList = [
            "A": ["B", "C"],
            "B": ["F"],
            "C": ["D", "E"],
            "D": ["C"],
            "E": ["C"],
            "F": ["B"]
        ]

        print("\nDFS\n")
        dfs(graph: adjacencyList, source: "A")

        print("\nRDFS\n")
        var visited = Set<String>()
        rdfs(graph: adjacencyList, source: "A", visited: &visited)

        print("\nBFS")
        bfs(graph: adjacencyList, source: "A")
    }

    private func dfs(graph: AdjacencyList, source: String) {
        var stack = Stack<String>()

        stack.push(source)

        var visited = Set<String>()

        while let current = stack.pop() {
            guard !visited.contains(current) else {
                continue
            }

            print(current)

            visited.insert(current)

            let neighbours = graph[current] ?? []

            for neighbour in neighbours {
                stack.push(neighbour)
            }
        }
    }

    private func rdfs(graph: AdjacencyList, source: String, visited: inout Set<String>) {
        guard !visited.contains(source) else {
            return
        }

        print(source)

        visited.insert(source)

        let neighbours = graph[source] ?? []

        for neighbour in neighbours {
            rdfs(graph: graph, source: neighbour, visited: &visited)
        }
    }

    private func bfs(graph: AdjacencyList, source: String) {
        var queue = Queue<String>()

        var visited = Set<String>()

        queue.enqueue(source)

        while let head = queue.dequeue() {
            guard !visited.contains(head) else {
                continue
            }

            print(head)

            visited.insert(head)

            let neighbours = graph[head] ?? []

            for neighbour in neighbours {
                queue.enqueue(neighbour)
            }
        }
    }
}
