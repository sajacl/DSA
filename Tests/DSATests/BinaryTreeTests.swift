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

    func testAdjacencyCreating() {
        let tree = BinaryTree<String>(adjacencyList: ["A": ["B", "C"]])

        print("\nDFS\n")
        tree.dfs()

        print("\nRDFS\n")
        tree.rdfs()

        print("\nBFS\n")
        tree.bfs()
    }
}
