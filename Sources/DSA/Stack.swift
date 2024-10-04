import Foundation

struct Stack<Element>: Sequence, Collection, CustomStringConvertible {
    private var store: [Element] = []

    mutating func push(_ newItem: Element) {
        store.append(newItem)
    }

    mutating func pop() -> Element? {
        if store.isEmpty {
            return nil
        }

        return store.removeLast()
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
        let descriptor = Descriptor(stack: self)

        return descriptor.description
    }
}

extension Stack {
    private final class Descriptor: CustomStringConvertible {
        var stack: Stack<Element>

        init(stack: Stack<Element>) {
            self.stack = stack
        }

        var description: String {
            var _description = ""

            for index in stride(from: stack.endIndex - 1, through: 0, by: -1) {
                let separator: String

                if index != 0 {
                    separator = "\n"
                } else {
                    separator = ""
                }

                _description += "\(stack[index])\(separator)"
            }

            return _description
        }
    }
}
