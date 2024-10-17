import Foundation

/// Array containing only 2 elements, that represent `leftChild` and `rightChild` anonymously.
/// It's backed by an array.
struct ArrayOfTwo<Element>: Sequence {
    private let store: ArraySlice<Element>

    init(_ array: [Element]) {
        self.store = array.prefix(2)
    }

    func makeIterator() -> IndexingIterator<ArraySlice<Element>> {
        store.makeIterator()
    }
}
