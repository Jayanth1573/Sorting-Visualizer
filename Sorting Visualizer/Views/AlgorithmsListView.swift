//
//  AlgorithmsListView.swift
//  Sorting Visualizer
//
//  Created by Jayanth Ambaldhage on 25/07/24.
//

import SwiftUI

struct AlgorithmsListView: View {
    @ObservedObject var sortingAlgorithms = SortingAlgorithms()
    @State private var path: [String] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                HStack {
                    Button("Bubble Sort") {
                        path.append("Bubble Sort")
                    }
                    .foregroundStyle(Color(UIColor.label))
                    Spacer()
                    Image(systemName: "chevron.right.circle")
                }
                HStack {
                    Button("Selection Sort") {
                        path.append("Selection Sort")
                    }
                    .foregroundStyle(Color(UIColor.label))
                    Spacer()
                    Image(systemName: "chevron.right.circle")
                }
                HStack {
                    Button("Insertion Sort") {
                        path.append("Insertion Sort")
                    }
                    .foregroundStyle(Color(UIColor.label))
                    Spacer()
                    Image(systemName: "chevron.right.circle")
                }
                HStack {
                    Button("Merge Sort") {
                        path.append("Merge Sort")
                    }
                    .foregroundStyle(Color(UIColor.label))
                    Spacer()
                    Image(systemName: "chevron.right.circle")
                }
                HStack {
                    Button("Quick Sort") {
                        path.append("Quick Sort")
                    }
                    .foregroundStyle(Color(UIColor.label))
                    Spacer()
                    Image(systemName: "chevron.right.circle")
                }
            }
            .navigationTitle("Sorting Algorithms")
            .navigationDestination(for: String.self) { algorithm in
                AlgorithmDetailView(algorithm: algorithm, sortingAlgorithms: sortingAlgorithms)
            }
        }
    }
}

#Preview {
    AlgorithmsListView()
}
