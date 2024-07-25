//
//  AlgorithmDetailView.swift
//  Sorting Visualizer
//
//  Created by Jayanth Ambaldhage on 25/07/24.
//

import SwiftUI

struct AlgorithmDetailView: View {
    var algorithm: String
    @ObservedObject var sortingAlgorithms: SortingAlgorithms
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .center, spacing: 16) {
                    
                    Text(theoryForAlgorithm(algorithm))
                        .padding(.horizontal)
                    
                    Text("Pseudo Code")
                        .font(.headline)
                        .padding(.top)
                    
                    Text(pseudoCodeForAlgorithm(algorithm))
                        .padding()
                        .font(.system(.body, design: .monospaced))
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    BarsView(numbers: sortingAlgorithms.sortedNumbers)
                        .frame(height: 300)
                        .padding()
                    
                    if sortingAlgorithms.isSorting {
                        ProgressView()
                            .padding()
                    } else {
                        Button(action: {
                            sortingAlgorithms.startSorting(algorithm: algorithm)
                        }) {
                            Text("Sort")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
            }
        }
        .navigationBarTitle(Text(algorithm), displayMode: .inline)
        .onDisappear {
            sortingAlgorithms.stopSorting()
        }
    }
    
    func theoryForAlgorithm(_ algorithm: String) -> String {
        switch algorithm {
        case "Bubble Sort":
            return "Bubble Sort is a simple sorting algorithm that repeatedly steps through the list, compares adjacent elements and swaps them if they are in the wrong order. It has an O(n^2) time complexity and O(1) space complexity."
        case "Selection Sort":
            return "Selection Sort is an in-place comparison sorting algorithm. It has an O(n^2) time complexity, which makes it inefficient on large lists. It has an O(1) space complexity."
        case "Insertion Sort":
            return "Insertion Sort is a simple sorting algorithm that builds the final sorted array one item at a time. It is much less efficient on large lists than more advanced algorithms such as quicksort, heapsort, or merge sort. It has an O(n^2) time complexity and O(1) space complexity."
        case "Merge Sort":
            return "Merge Sort is an efficient, stable, comparison-based, divide and conquer sorting algorithm. Most implementations produce a stable sort, meaning that the implementation preserves the input order of equal elements in the sorted output. It has an O(n log n) time complexity and O(n) space complexity."
        case "Quick Sort":
            return "Quick Sort is an efficient, in-place comparison sort. It is not a stable sort, meaning that the relative order of equal sort items is not preserved. Quick sort is faster in practice than other O(n log n) algorithms such as bubble sort or insertion sort. It has O(n^2) worst case and O(n log n) best and average time complexity and O(1) + O(n) auxiliary stack space."
        default:
            return ""
        }
    }
    
    func pseudoCodeForAlgorithm(_ algorithm: String) -> String {
        switch algorithm {
        case "Bubble Sort":
            return """
            for i from 0 to n-1 do:
                for j from 0 to n-i-1 do:
                    if array[j] > array[j+1] then
                        swap(array[j], array[j+1])
            """
        case "Selection Sort":
            return """
            for i from 0 to n-1 do:
                minIndex = i
                for j from i+1 to n do:
                    if array[j] < array[minIndex] then
                        minIndex = j
                swap(array[i], array[minIndex])
            """
        case "Insertion Sort":
            return """
            for i from 1 to n do:
                key = array[i]
                j = i - 1
                while j >= 0 and array[j] > key do:
                    array[j+1] = array[j]
                    j = j - 1
                array[j+1] = key
            """
        case "Merge Sort":
            return """
            function mergeSort(array, left, right):
                if left < right then:
                    middle = (left + right) / 2
                    mergeSort(array, left, middle)
                    mergeSort(array, middle + 1, right)
                    merge(array, left, middle, right)

            function merge(array, left, middle, right):
                leftArray = array[left..middle]
                rightArray = array[middle+1..right]
                i = 0, j = 0, k = left
                while i < leftArray.length and j < rightArray.length do:
                    if leftArray[i] <= rightArray[j] then:
                        array[k] = leftArray[i]
                        i = i + 1
                    else:
                        array[k] = rightArray[j]
                        j = j + 1
                    k = k + 1
                while i < leftArray.length do:
                    array[k] = leftArray[i]
                    i = i + 1
                    k = k + 1
                while j < rightArray.length do:
                    array[k] = rightArray[j]
                    j = j + 1
                    k = k + 1
            """
        case "Quick Sort":
            return """
            function quickSort(array, low, high):
                if low < high then:
                    pivotIndex = partition(array, low, high)
                    quickSort(array, low, pivotIndex - 1)
                    quickSort(array, pivotIndex + 1, high)

            function partition(array, low, high):
                pivot = array[high]
                i = low - 1
                for j from low to high - 1 do:
                    if array[j] <= pivot then:
                        i = i + 1
                        swap(array[i], array[j])
                swap(array[i + 1], array[high])
                return i + 1
            """
        default:
            return ""
        }
    }
}

struct AlgorithmDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlgorithmDetailView(algorithm: "Bubble Sort", sortingAlgorithms: SortingAlgorithms())
    }
}

