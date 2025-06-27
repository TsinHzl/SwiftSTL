# SwiftSTL
**SwiftSTL类似于C++的STL**

- [Description](#Description)
- [Includes](#Includes)
- [Installation](#Installation)
- [Usage](#Usage)
  - [LinkedList - 链表](#LinkedList)
  - [DoubleLinkedList - 双向链表](#DoubleLinkedList)
  - [Stack - 栈](#Stack)
  - [Queue - 队列](#Queue)
  - [Dequeue - 双向队列](#Dequeue)
  - [BinaryHeap - 二叉堆](#BinaryHeap)
  - [PriorityQueue - 大小顶堆](#PriorityQueue)



#### Description

大家都知道，swift仅仅包含了比较少的一些常见数据结构，并不像java那样，拥有比较齐全的常见数据结构。**因此我这里就为了方便开发，实现了剩余常见的数据结构**

#### Includes

- it includes **some common data structures :**
- 包含了**以下的常见数据结构：**
  - **LinkedList - 链表**
  - **DoubleLinkedList - 双向链表**
  - **Stack - 栈**
  - **Queue - 队列**
  - **Dequeue - 竖向队列**
  - **BinaryHeap - 二叉堆**
  - **PriorityQueue - 大小顶堆**

#### Installation

##### cocoapods

- **pod 'SwiftSTL'**
  - 或指定一个版本号:  **pod 'SwiftSTL', '~> 1.7'**


##### 下载 framwork

- 下载仓库代码
- 然后添加**SwiftSTL** 库到你的项目里即可

#### Usage

##### 导入 library

```swift
import SwiftSTL
```



##### Use

###### LinkedList

```swift
var linkedList = LinkedList<Int>()
for i in 0 ... 10 {
    linkedList.append(i + 1)
}

for i in 11 ... 20 {
    linkedList.append(i + 1, at: 0)
}

linkedList.debugPrint()

linkedList.remove(5)
linkedList.remove(at: 5)
linkedList.debugPrint()

for _ in 0 ... 30 {
    linkedList.remove(at: 0)
}

linkedList.debugPrint()
```



###### DoubleLinkedList

```swift
var dLinkedList = DoubleLinkedList<Int>()
for i in 0 ... 10 {
    dLinkedList.append(i + 1, at: 0)
}

dLinkedList.append(20, at: 5)

dLinkedList.debugPrint()

dLinkedList.remove(at: 5)
dLinkedList.remove(6)
dLinkedList.removeFirst()
dLinkedList.removeLast()

dLinkedList.debugPrint()

for _ in 0 ... 10 {
    dLinkedList.removeFirst()
}

dLinkedList.debugPrint()
```



###### Stack

```swift
var stack = Stack<Int>()
for i in 0 ... 10 {
    stack.push(i + 1)
}
stack.debugPrint()

for _ in 0 ... 11 {
    stack.pop()
}

stack.debugPrint()
```



###### Queue

```swift
var queue = Queue<Int>()
for i in 0 ... 10 {
    queue.offer(i + 1)
}
queue.debugPrint()

let _ = queue.poll()

queue.removeAll()

queue.debugPrint()
```



###### Dequeue

```swift
var deQueue = Dequeue<Int>()
for i in 0 ... 10 {
    deQueue.offerFront(i + 1)
}
for i in 11 ... 20 {
    deQueue.offerRear(i + 1)
}
deQueue.debugPrint()

let _ = deQueue.pollRear()
let _ = deQueue.pollFront()

deQueue.debugPrint()
```



###### BinaryHeap

```swift
let maxNum = 10
var heap = BinaryHeap<Int>()
for _ in 0 ... maxNum {
    let num = Int.random(in: 1 ... maxNum)
    heap.append(num)
}

var str = ""
for _ in 0 ... maxNum {
    let num = heap.remove()
    str += "\(num!) "
}
print(str)

var nums = [Int]()
for _ in 0 ... maxNum {
    let num = Int.random(in: 1 ... maxNum)
    nums.append(num)
}

var heap1 = BinaryHeap(type: .min ,elements: nums)

str = ""
for _ in 0 ... maxNum {
    let num = heap1.remove()
    str += "\(num!) "
}
print(str)
```



###### PriorityQueue

```swift
let maxNum = 10
var heap = PriorityQueue<Int>()
for _ in 0 ... maxNum {
    let num = Int.random(in: 1 ... maxNum)
    heap.append(num)
}

var str = ""
for _ in 0 ... maxNum {
    let num = heap.remove()
    str += "\(num!) "
}
print(str)

var heap1 = PriorityQueue<Int>(type: .max)
for _ in 0 ... maxNum {
    let num = Int.random(in: 1 ... maxNum)
    heap1.append(num)
}

str = ""
for _ in 0 ... maxNum {
    let num = heap1.remove()
    str += "\(num!) "
}
print(str)
```

