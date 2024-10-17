import Foundation

/// Value type `Queue` that is backed by an array.
/// Enqueue is O(1)
/// Dequeue is O(n)
struct Queue<Element>: Sequence, Collection, CustomStringConvertible {
    private var store: [Element] = []

    mutating func enqueue(_ newItem: Element) {
        store.append(newItem)
    }

    // O(n) operation
    mutating func dequeue() -> Element? {
        if store.isEmpty {
            return nil
        }

        return store.removeFirst()
    }

    func peek() -> Element? {
        store.first
    }

    // Collection
    subscript(position: Int) -> Element {
        store[position]
    }

    func index(after i: Int) -> Int {
        store.index(after: i)
    }

    var startIndex: Int {
        store.startIndex
    }

    var endIndex: Int {
        store.endIndex
    }

    // Sequence

    func makeIterator() -> IndexingIterator<[Element]> {
        store.makeIterator()
    }

    var description: String {
        let descriptor = Descriptor(queue: self)

        return descriptor.description
    }
}

extension Queue {
    /// Object that will describe an arbitrary given `Queue`.
    private final class Descriptor: CustomStringConvertible {
        var queue: Queue

        init(queue: Queue<Element>) {
            self.queue = queue
        }

        var description: String {
            guard let head = queue.dequeue() else {
                return ""
            }

            var tail = ""

            for a in queue {
                tail += " <- \(a)"
            }

            return """
            (\(head))\(tail)
            """
        }
    }
}
