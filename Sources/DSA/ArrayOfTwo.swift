import Foundation

struct ArrayOfTwo<Element>: Sequence {
    private var store: ArraySlice<Element>

    init(_ array: [Element]) {
        self.store = array.prefix(2)
    }

    func makeIterator() -> IndexingIterator<ArraySlice<Element>> {
        store.makeIterator()
    }
}
