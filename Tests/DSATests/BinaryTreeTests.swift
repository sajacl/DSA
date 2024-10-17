import Foundation
import XCTest
@testable import DSA

final class BinaryTreeTests: XCTestCase {
    func testTraversal() {
        let ANode = BinaryTree.Node(value: "A")
        let BNode = BinaryTree.Node(value: "B")
        let CNode = BinaryTree.Node(value: "C")
        let DNode = BinaryTree.Node(value: "D")
        let ENode = BinaryTree.Node(value: "E")
        let FNode = BinaryTree.Node(value: "F")

        ANode.modify { builder in
            builder
                .withAddingLeftChild(BNode)
                .withAddingRightChild(CNode)
        }

        BNode.modify { builder in
            builder
                .withAddingLeftChild(DNode)
                .withAddingRightChild(ENode)
        }

        CNode.modify { builder in
            builder
                .withAddingLeftChild(FNode)
        }

        let tree = BinaryTree(root: ANode)

        print("\nDFS\n")
        tree.dfs()

        print("\nRDFS\n")
        tree.rdfs()

        print("\nBFS\n")
        tree.bfs()
    }

    func testDFSIterator() {
        let ANode = BinaryTree.Node(value: "A")
        let BNode = BinaryTree.Node(value: "B")
        let CNode = BinaryTree.Node(value: "C")
        let DNode = BinaryTree.Node(value: "D")
        let ENode = BinaryTree.Node(value: "E")
        let FNode = BinaryTree.Node(value: "F")

        ANode.modify { builder in
            builder
                .withAddingLeftChild(BNode)
                .withAddingRightChild(CNode)
        }

        BNode.modify { builder in
            builder
                .withAddingLeftChild(DNode)
                .withAddingRightChild(ENode)
        }

        CNode.modify { builder in
            builder
                .withAddingLeftChild(FNode)
        }

        let tree = BinaryTree(root: ANode)

        print("\nDFS\n")
        tree.dfs()

        print("\nDFS Iterator\n")

        var iterator = BinaryTree.DFSIterator(tree: tree)
        while let node = iterator?.next() {
            print(node)
        }
    }

    func testBFSIterator() {
        let ANode = BinaryTree.Node(value: "A")
        let BNode = BinaryTree.Node(value: "B")
        let CNode = BinaryTree.Node(value: "C")
        let DNode = BinaryTree.Node(value: "D")
        let ENode = BinaryTree.Node(value: "E")
        let FNode = BinaryTree.Node(value: "F")

        ANode.modify { builder in
            builder
                .withAddingLeftChild(BNode)
                .withAddingRightChild(CNode)
        }

        BNode.modify { builder in
            builder
                .withAddingLeftChild(DNode)
                .withAddingRightChild(ENode)
        }

        CNode.modify { builder in
            builder
                .withAddingLeftChild(FNode)
        }

        let tree = BinaryTree(root: ANode)

        print("\nBFS\n")
        tree.bfs()

        print("\nBFS Iterator\n")

        var iterator = BinaryTree.BFSIterator(tree: tree)
        while let node = iterator?.next() {
            print(node)
        }
    }
    /*
        A
       / \
      B   C
     / \ /
    D  E F
     */
    func testAdjacencyCreating() throws {
        let list = [
            "A": ["B", "C"],
            "B": ["D", "E"],
            "C": ["F"],
            "D": [],
            "E": [],
            "F": []
        ]

        let tree = try XCTUnwrap(BinaryTree<String>.create(from: list, root: "A"))

        print("\nDFS\n")
        tree.dfs()

        print("\nRDFS\n")
        tree.rdfs()

        print("\nBFS\n")
        tree.bfs()
    }
    /*
        1
       / \
      2   3
     / \ /
    4  5 6
     */
    func testArrayCreation() throws {
        let tree = try XCTUnwrap(BinaryTree<Int>(arrayRepresentation: [1, 2, 3, 4, 5, 6]))

        print("\nDFS\n")
        tree.dfs()

        print("\nRDFS\n")
        tree.rdfs()

        print("\nBFS\n")
        tree.bfs()
    }
}
