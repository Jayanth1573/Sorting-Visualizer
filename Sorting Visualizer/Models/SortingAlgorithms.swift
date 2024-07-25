//
//  SortingAlgorithms.swift
//  Sorting Visualizer
//
//  Created by Jayanth Ambaldhage on 25/07/24.
//

import Foundation

@MainActor
class SortingAlgorithms: ObservableObject {
    @Published var numbers: [Int] = []
    @Published var sortedNumbers: [Int] = []
    @Published var isSorting: Bool = false
    @Published var currentAlgorithm: String?
    
    private var sortTask: Task<Void, Never>?
    
    init() {
        resetNumbers()
    }
    
    func resetNumbers() {
        numbers = Array(1...30).shuffled()
        sortedNumbers = numbers
    }
    
    func startSorting(algorithm: String) {
        resetNumbers()
        currentAlgorithm = algorithm
        isSorting = true
        
        sortTask = Task.detached(priority: .userInitiated) {
            switch algorithm {
            case "Bubble Sort":
                await self.bubbleSort()
            case "Selection Sort":
                await self.selectionSort()
            case "Insertion Sort":
                await self.insertionSort()
            case "Merge Sort":
                await self.mergeSort()
            case "Quick Sort":
                await self.quickSort()
            default:
                break
            }
            await MainActor.run {
                self.isSorting = false
            }
        }
    }
    
    func stopSorting() {
        sortTask?.cancel()
        sortTask = nil
        resetNumbers()
        isSorting = false
    }
    
    private func bubbleSort() async {
        for i in 0..<sortedNumbers.count {
            for j in 0..<sortedNumbers.count - i - 1 {
                if sortedNumbers[j] > sortedNumbers[j + 1] {
                    let temp = sortedNumbers[j]
                    sortedNumbers[j] = sortedNumbers[j + 1]
                    sortedNumbers[j + 1] = temp
                    await MainActor.run {
                        self.objectWillChange.send()
                    }
                    try? await Task.sleep(nanoseconds: 50000000)
                }
            }
        }
    }
    
    private func selectionSort() async {
        for i in 0..<sortedNumbers.count {
            var minIndex = i
            for j in i+1..<sortedNumbers.count {
                if sortedNumbers[j] < sortedNumbers[minIndex] {
                    minIndex = j
                }
            }
            let temp = sortedNumbers[i]
            sortedNumbers[i] = sortedNumbers[minIndex]
            sortedNumbers[minIndex] = temp
            await MainActor.run {
                self.objectWillChange.send()
            }
            try? await Task.sleep(nanoseconds: 50000000)
        }
    }

    private func insertionSort() async {
        for i in 1..<sortedNumbers.count {
            let key = sortedNumbers[i]
            var j = i - 1
            while j >= 0 && sortedNumbers[j] > key {
                sortedNumbers[j + 1] = sortedNumbers[j]
                j -= 1
                await MainActor.run {
                    self.objectWillChange.send()
                }
                try? await Task.sleep(nanoseconds: 50000000)
            }
            sortedNumbers[j + 1] = key
            await MainActor.run {
                self.objectWillChange.send()
            }
        }
    }

    private func mergeSort() async {
        await mergeSortHelper(0, sortedNumbers.count - 1)
    }

    private func mergeSortHelper(_ left: Int, _ right: Int) async {
        if left < right {
            let middle = (left + right) / 2
            await mergeSortHelper(left, middle)
            await mergeSortHelper(middle + 1, right)
            await merge(left, middle, right)
        }
    }

    private func merge(_ left: Int, _ middle: Int, _ right: Int) async {
        let leftArray = Array(sortedNumbers[left...middle])
        let rightArray = Array(sortedNumbers[middle+1...right])
        var i = 0, j = 0, k = left
        while i < leftArray.count && j < rightArray.count {
            if leftArray[i] <= rightArray[j] {
                sortedNumbers[k] = leftArray[i]
                i += 1
            } else {
                sortedNumbers[k] = rightArray[j]
                j += 1
            }
            await MainActor.run {
                self.objectWillChange.send()
            }
            try? await Task.sleep(nanoseconds: 50000000)
            k += 1
        }
        while i < leftArray.count {
            sortedNumbers[k] = leftArray[i]
            i += 1
            k += 1
        }
        while j < rightArray.count {
            sortedNumbers[k] = rightArray[j]
            j += 1
            k += 1
        }
    }

    private func quickSort() async {
        await quickSortHelper(0, sortedNumbers.count - 1)
    }

    private func quickSortHelper(_ low: Int, _ high: Int) async {
        if low < high {
            let pi = await partition(low, high)
            await quickSortHelper(low, pi - 1)
            await quickSortHelper(pi + 1, high)
        }
    }

    private func partition(_ low: Int, _ high: Int) async -> Int {
        let pivot = sortedNumbers[high]
        var i = low - 1
        for j in low..<high {
            if sortedNumbers[j] <= pivot {
                i += 1
                sortedNumbers.swapAt(i, j)
                await MainActor.run {
                    self.objectWillChange.send()
                }
                try? await Task.sleep(nanoseconds: 50000000)
            }
        }
        sortedNumbers.swapAt(i + 1, high)
        await MainActor.run {
            self.objectWillChange.send()
        }
        try? await Task.sleep(nanoseconds: 50000000)
        return i + 1
    }
}

