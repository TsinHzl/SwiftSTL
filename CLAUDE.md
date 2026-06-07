# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SwiftSTL — Swift implementation of classic data structures (C++ STL-inspired). Distributed via CocoaPods (v1.10), supports iOS 9.0+ / macOS 10.13+, Swift 5.0+.

## Build & Run

- **No Swift Package Manager** — this is a pure Xcode project (`SwiftSTLExample.xcodeproj`).
- Build/run the example target: `xcodebuild -project SwiftSTLExample.xcodeproj -scheme SwiftSTLExample build`
- Validate podspec: `pod spec lint SwiftSTL.podspec`
- No test target exists; validation is done via `SwiftSTLExample/main.swift` which exercises each data structure.

## Architecture

```
SwiftSTL/
├── List.swift              # `List` protocol — shared interface for linked lists
├── LinkedList.swift        # Singly linked list (conforms to List + Sequence)
├── DoubleLinkedList.swift  # Doubly linked list (conforms to List + Sequence)
├── Stack.swift             # Array-backed FILO stack (Sequence)
├── Queue.swift             # DoubleLinkedList-backed FIFO queue (Sequence)
├── Dequeue.swift           # DoubleLinkedList-backed double-ended queue (Sequence)
├── BinaryHeap.swift        # Array-backed max/min binary heap (Sequence)
└── PriorityQueue.swift     # Thin wrapper over BinaryHeap (Sequence)
```

### Key Design Decisions

1. **`List` protocol** (`List.swift`) defines the shared contract (`append`, `remove`, `get`, `set`, `indexOf`) with default implementations in an extension. Only `LinkedList` and `DoubleLinkedList` conform to it.

2. **All types conform to `Sequence`** — each provides `makeIterator()` enabling `for-in`, `map`, `filter`, etc. Linked lists define custom nested `Iterator` structs (with `internal init` to hide `Node`); array-backed types delegate to `IndexingIterator<[E]>`.

3. **Generic constraints differ by type**:
   - `LinkedList<E: Equatable>`, `DoubleLinkedList<E: Equatable>` — need `Equatable` for `indexOf`/`remove(_:)`
   - `Stack<E>` — no constraint (no search operations)
   - `BinaryHeap<E: Comparable>`, `PriorityQueue<E: Comparable>` — need ordering
   - `Queue<E: Equatable>`, `Dequeue<E: Equatable>` — delegate to `DoubleLinkedList`

4. **Node classes are `internal`** — `LinkedList.Node` and `DoubleLinkedList.Node` are nested classes with `internal` access so the Iterator can reference them from an extension while keeping them hidden from library consumers.

5. **`DoubleLinkedList` is the backing store** for `Queue` and `Dequeue` — provides O(1) head/tail operations.

6. **BinaryHeap supports batch construction** via `heapifyDown()` in O(n), triggered when `elements` is passed to `init`.

## Conventions

- `debugPrint()` instance method on each type for debug output (guarded by `#if DEBUG` via `_debugPrint` helper).
- `@discardableResult` on mutating removal methods.
- Structs with value semantics for all public types; `Node` is a reference type (class) internally for pointer-based linking.
