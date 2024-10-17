import Foundation

/// Value type `Queue` that is backed by a ``DoublyLinkedList``.
/// Enqueue is O(1)
/// Dequeue is O(1)
struct AdvanceQueue<Element>: Sequence {
    private var store: DoublyLinkedList<Element> = DoublyLinkedList()

    var isEmpty: Bool {
        store.isEmpty
    }

    mutating func enqueue(_ newValue: Element) {
        store.append(newValue)
    }

    mutating func dequeue() -> Element? {
        store.removeFirst()
    }

    func peek() -> Element? {
        store.head?.value
    }

    func peekTail() -> Element? {
        store.tail?.value
    }

    func makeIterator() -> some IteratorProtocol {
        store.makeIterator()
    }
}
