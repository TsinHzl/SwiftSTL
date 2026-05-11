# SwiftSTL

**SwiftSTL is a Swift implementation of common data structures, similar to the C++ STL library.**

**[中文版](https://github.com/TsinHzl/SwiftSTL/blob/main/README-zh.md)**

- [Description](#description)
- [Includes](#includes)
- [Installation](#installation)
- [Usage](#usage)
  - [LinkedList](#linkedlist)
  - [DoubleLinkedList](#doublelinkedlist)
  - [Stack](#stack)
  - [Queue](#queue)
  - [Dequeue](#dequeue)
  - [BinaryHeap](#binaryheap)
  - [PriorityQueue](#priorityqueue)

## Description

Swift's standard library only ships with `Array`, `Dictionary`, and `Set`. SwiftSTL fills the gap by providing the most commonly needed data structures with clean, generic APIs.

## Includes

| Structure | Description |
|-----------|-------------|
| `LinkedList` | Singly linked list |
| `DoubleLinkedList` | Doubly linked list |
| `Stack` | FILO stack |
| `Queue` | FIFO queue |
| `Dequeue` | Double-ended queue |
| `BinaryHeap` | Max/min binary heap |
| `PriorityQueue` | Priority queue backed by a binary heap |

All types conform to `Sequence`, so you can use `for-in`, `map`, `filter`, etc. directly.

## Installation

### CocoaPods

```ruby
pod 'SwiftSTL', '~> 1.9'
```

### Manual

Clone the repo and drag the `SwiftSTL/` folder into your Xcode project.

## Usage

```swift
import SwiftSTL
```

### LinkedList

Singly linked list. O(1) prepend, O(n) random access.

```swift
var list = LinkedList<Int>()
for i in 1 ... 11 { list.append(i) }
for i in 12 ... 21 { list.append(i, at: 0) }

list.debugPrint()

list.remove(5)
list.remove(at: 5)
list.debugPrint()

// for-in iteration
for item in list { print(item) }
```

### DoubleLinkedList

Doubly linked list. O(1) prepend/append, O(n/2) random access.

```swift
var list = DoubleLinkedList<Int>()
for i in 1 ... 11 { list.append(i, at: 0) }
list.append(20, at: 5)
list.debugPrint()

list.remove(at: 5)
list.remove(6)
list.removeFirst()
list.removeLast()
list.debugPrint()

// for-in iteration
for item in list { print(item) }
```

### Stack

FILO (First In, Last Out).

```swift
var stack = Stack<Int>()
for i in 1 ... 11 { stack.push(i) }
stack.debugPrint()

print(stack.top() ?? "empty")  // peek without removing

while let top = stack.pop() { print(top) }
```

### Queue

FIFO (First In, First Out).

```swift
var queue = Queue<Int>()
for i in 1 ... 11 { queue.offer(i) }
queue.debugPrint()

if let front = queue.poll() { print("dequeued: \(front)") }

// for-in iteration
for item in queue { print(item) }

queue.removeAll()
```

### Dequeue

Double-ended queue — enqueue/dequeue from both ends.

```swift
var deque = Dequeue<Int>()
for i in 1 ... 11  { deque.offerFront(i) }
for i in 12 ... 21 { deque.offerRear(i) }
deque.debugPrint()

deque.pollFront()
deque.pollRear()

// for-in iteration
for item in deque { print(item) }
```

### BinaryHeap

Max-heap by default. Pass `type: .min` for a min-heap. Supports O(n) batch construction.

```swift
// Max-heap (default)
var maxHeap = BinaryHeap<Int>()
for _ in 0 ... 10 { maxHeap.append(Int.random(in: 1 ... 100)) }

var result = ""
while let top = maxHeap.remove() { result += "\(top) " }
print(result)  // descending order

// Min-heap with batch construction — O(n)
let nums = (0 ... 10).map { _ in Int.random(in: 1 ... 100) }
var minHeap = BinaryHeap(type: .min, elements: nums)

result = ""
while let top = minHeap.remove() { result += "\(top) " }
print(result)  // ascending order

// for-in iterates internal array order (not sorted)
for element in minHeap { print(element) }
```

### PriorityQueue

Wraps `BinaryHeap`. Must explicitly specify `.max` or `.min`.

```swift
// Min priority queue
var minPQ = PriorityQueue<Int>(type: .min)
for _ in 0 ... 10 { minPQ.append(Int.random(in: 1 ... 100)) }

while let top = minPQ.remove() { print(top) }  // ascending order

// Max priority queue
var maxPQ = PriorityQueue<Int>(type: .max)
for _ in 0 ... 10 { maxPQ.append(Int.random(in: 1 ... 100)) }

// for-in iteration
for element in maxPQ { print(element) }
```

## Requirements

- Swift 5.0+
- iOS 9.0+ / macOS 10.13+

## License

MIT
