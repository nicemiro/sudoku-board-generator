//
//  HiddenCellGenerator.swift
//  SudokuBoard
//
//  Created by babyK on 2023/11/10.
//

import Foundation

enum Level : CaseIterable {
    
    case kid
    case normal
    case hard
    case expert
    case master
}

class HiddenCellGenerator {
    
    var board = [[Int]]()
    var hiddenBoard = [[Int]]()
    var hiddenCellIndices = [Int]()
    var hiddenCellProgress = [Int]()
    var hiddenCellEnd = [Int]()
    var dfsEnd = false
    let genHelper = GenHelper()
    
    init(_ board: [[Int]] ) {
        self.board = board
        self.hiddenBoard = self.board
    }
    
    func makeHiddenCells(level : Level) -> [[Int]] {
        
        hiddenCellIndices = Array(0...80).shuffled()
        var offset : Int
        
        switch(level){
        case .kid : offset = (35...40).randomElement()!
        case .normal : offset = (30...35).randomElement()!
        case .hard : offset = (25...30).randomElement()!
        case .expert : offset = (22...25).randomElement()!
        case .master : offset = (19...22).randomElement()!
        }
        
        let numHint = 81 - offset
        while(hiddenCellProgress.count < numHint)
        {
            let idx = hiddenCellIndices.removeFirst()
            hiddenCellProgress.append(idx)
            hiddenBoard[idx / 9][idx % 9] = 0
        }
        return hiddenBoard
    }
    
    func hideCells(_ indices: [Int]) {
        
        for i in indices {
            let y = i / 9
            let x = i % 9
            hiddenBoard[y][x] = 0
        }
    }
}
