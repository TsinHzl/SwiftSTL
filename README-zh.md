# SwiftSTL

**SwiftSTL 是常见数据结构的 Swift 实现，类似于 C++ STL 库。**

**[English](https://github.com/TsinHzl/SwiftSTL/blob/main/README.md)**

- [简介](#简介)
- [包含结构](#包含结构)
- [安装](#安装)
- [使用方法](#使用方法)
  - [LinkedList - 单向链表](#linkedlist---单向链表)
  - [DoubleLinkedList - 双向链表](#doublelinkedlist---双向链表)
  - [Stack - 栈](#stack---栈)
  - [Queue - 队列](#queue---队列)
  - [Dequeue - 双端队列](#dequeue---双端队列)
  - [BinaryHeap - 二叉堆](#binaryheap---二叉堆)
  - [PriorityQueue - 优先队列](#priorityqueue---优先队列)

## 简介

Swift 标准库只提供了 `Array`、`Dictionary` 和 `Set`。SwiftSTL 补充了最常用的数据结构，提供简洁的泛型 API。

## 包含结构

| 结构 | 说明 |
|------|------|
| `LinkedList` | 单向链表 |
| `DoubleLinkedList` | 双向链表 |
| `Stack` | 先进后出栈 |
| `Queue` | 先进先出队列 |
| `Dequeue` | 双端队列 |
| `BinaryHeap` | 大顶堆 / 小顶堆 |
| `PriorityQueue` | 基于二叉堆的优先队列 |

所有类型均遵循 `Sequence` 协议，可直接使用 `for-in`、`map`、`filter` 等。

## 安装

### CocoaPods

```ruby
pod 'SwiftSTL', '~> 1.9'
```

### 手动集成

克隆仓库，将 `SwiftSTL/` 文件夹拖入 Xcode 项目即可。

## 使用方法

```swift
import SwiftSTL
```

### LinkedList - 单向链表

头部插入 O(1)，随机访问 O(n)。

```swift
var list = LinkedList<Int>()
for i in 1 ... 11 { list.append(i) }
for i in 12 ... 21 { list.append(i, at: 0) }

list.debugPrint()

list.remove(5)
list.remove(at: 5)
list.debugPrint()

// for-in 遍历
for item in list { print(item) }
```

### DoubleLinkedList - 双向链表

头尾插入 O(1)，随机访问 O(n/2)。

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

// for-in 遍历
for item in list { print(item) }
```

### Stack - 栈

先进后出（FILO）。

```swift
var stack = Stack<Int>()
for i in 1 ... 11 { stack.push(i) }
stack.debugPrint()

print(stack.top() ?? "empty")  // 查看栈顶，不弹出

while let top = stack.pop() { print(top) }
```

### Queue - 队列

先进先出（FIFO）。

```swift
var queue = Queue<Int>()
for i in 1 ... 11 { queue.offer(i) }
queue.debugPrint()

if let front = queue.poll() { print("出队：\(front)") }

// for-in 遍历
for item in queue { print(item) }

queue.removeAll()
```

### Dequeue - 双端队列

两端均可入队/出队。

```swift
var deque = Dequeue<Int>()
for i in 1 ... 11  { deque.offerFront(i) }
for i in 12 ... 21 { deque.offerRear(i) }
deque.debugPrint()

deque.pollFront()
deque.pollRear()

// for-in 遍历
for item in deque { print(item) }
```

### BinaryHeap - 二叉堆

默认大顶堆，传 `type: .min` 创建小顶堆。支持 O(n) 批量建堆。

```swift
// 大顶堆（默认）
var maxHeap = BinaryHeap<Int>()
for _ in 0 ... 10 { maxHeap.append(Int.random(in: 1 ... 100)) }

var result = ""
while let top = maxHeap.remove() { result += "\(top) " }
print(result)  // 降序输出

// 小顶堆 + 批量建堆 O(n)
let nums = (0 ... 10).map { _ in Int.random(in: 1 ... 100) }
var minHeap = BinaryHeap(type: .min, elements: nums)

result = ""
while let top = minHeap.remove() { result += "\(top) " }
print(result)  // 升序输出

// for-in 遍历内部数组顺序（非排序顺序）
for element in minHeap { print(element) }
```

### PriorityQueue - 优先队列

封装 `BinaryHeap`，**必须显式指定 `.max` 或 `.min`**。

```swift
// 小顶优先队列
var minPQ = PriorityQueue<Int>(type: .min)
for _ in 0 ... 10 { minPQ.append(Int.random(in: 1 ... 100)) }

while let top = minPQ.remove() { print(top) }  // 升序输出

// 大顶优先队列
var maxPQ = PriorityQueue<Int>(type: .max)
for _ in 0 ... 10 { maxPQ.append(Int.random(in: 1 ... 100)) }

// for-in 遍历
for element in maxPQ { print(element) }
```

## 环境要求

- Swift 5.0+
- iOS 9.0+ / macOS 10.13+

## License

MIT
