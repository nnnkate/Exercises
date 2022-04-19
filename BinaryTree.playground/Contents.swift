import Darwin

enum BinaryTree<T: Comparable> {
    case empty
    indirect case node(BinaryTree, T, BinaryTree)
        
    private func newTreeWhithInsertedValue(newValue: T) -> BinaryTree {
        switch self {
        case .empty:
            return .node(.empty, newValue, .empty)
        case let .node(left, value, right):
            if newValue < value {
                return .node(left.newTreeWhithInsertedValue(newValue: newValue), value, right)
            } else {
                return .node(left, value, right.newTreeWhithInsertedValue(newValue: newValue))
            }
        }
    }
        
    mutating func insert(newValue: T) {
        self = newTreeWhithInsertedValue(newValue: newValue)
    }
    
    func traverseInOrder(process: (T) -> ()) { // @noescape @escaping
        switch self {
        case .empty:
            print("Is empty")
            return
        case let .node(left, value, right):
            print("LEFT: left \(left) value \(value) right \(right)")
            left.traverseInOrder(process: process)
            print(" process(value) \(value)")
            process(value)
            print("RIGHT: left \(left) value \(value) right \(right)")
            right.traverseInOrder(process: process)
        }
    }
}

var binaryTree: BinaryTree<Int> = .empty

//
//        5
//    2       7
//  1   3        9
//
//

binaryTree.insert(newValue: 5)
binaryTree.insert(newValue: 2)
binaryTree.insert(newValue: 3)
binaryTree.insert(newValue: 7)
binaryTree.insert(newValue: 9)
binaryTree.insert(newValue: 1)

binaryTree.traverseInOrder { print($0) }

