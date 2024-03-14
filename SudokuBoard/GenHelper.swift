//
//  swift
//  Sudoku
//
//  Created by babyK on 2023/11/11.
//

import Foundation

class GenHelper {
    
    
    func isBoxValid(_ board: [[Int]],_ boxIndex: Int) -> Bool {
        let loopRange = getBoxLoopRange(boxIndex)
        for k in loopRange.0...loopRange.1 {
            for m in loopRange.2...loopRange.3 {
                if board[k][m] == 0
                {
                    print("오류")
                    return false // 오류
                }
            }
        }
        return true
    }
    
    // 생성된 보드 유효성 체크
    func isBoardValid(_ board: [[Int]]) -> Bool {
        
//        // 중복값 체크1
//        for i in [0, 3 ,6] {
//            for j in [0, 3 ,6] {
//                if( isCellOverlappedInBox(board, i, j) )
//                {
//                    // error
//                    print("오류")
//                    return false
//                }
//            }
//        }
//        
//        // 중복값 체크2
//        for i in 0...8 {
//            if( hasHorizontalOverlap(board, i) && hasVerticalOverlap(board, i) )
//            {
//                // error
//                print("오류")
//                return false
//            }
//        }
        
        // 비어있는 보드 셀 체크
        for i in board {
            for j in i {
                if j == 0 {
                    print("오류")
                    return false
                }
            }
        }
        // complete
        return true
    }
    
    func removeBox(_ board: inout [[Int]], _ index: Int) {
        let loopRange = getBoxLoopRange(index)
        for p in loopRange.0...loopRange.1 {
            for q in loopRange.2...loopRange.3 {
                board[p][q] = 0
            }
        }
    }
    
    func getBoxLoopRange(_ boxIndex: Int) ->(Int, Int, Int, Int) {
        var yFrom    = Int(0)
        var yTo      = Int(0)
        var xFrom     = Int(0)
        var xTo       = Int(0)
        
        switch(boxIndex) {
        case 0...2 :
            yFrom = 0
            yTo = 2
        case 3...5 :
            yFrom = 3
            yTo = 5
        case 6...8 :
            yFrom = 6
            yTo = 8
        default :
            break
        }
        switch(boxIndex) {
        case 0, 3, 6 :
            xFrom = 0
            xTo = 2
        case 1, 4, 7 :
            xFrom = 3
            xTo = 5
        case 2, 5, 8 :
            xFrom = 6
            xTo = 8
        default :
            break
        }
        
        return (yFrom, yTo, xFrom, xTo)
    }
    
    func getBoxIndexFromCellIndex(_ index: Int) -> Int {
        
        let y = index / 9
        let x = index % 9
        
        var yBox = Int(0)
        switch(y) {
        case 0...2 :
            switch(x) {
            case 0...2 :
                yBox = 0
            case 3...5 :
                yBox = 1
            case 6...8 :
                yBox = 2
            default:
                break
            }
        case 3...5 :
            switch(x) {
            case 0...2 :
                yBox = 3
            case 3...5 :
                yBox = 4
            case 6...8 :
                yBox = 5
            default:
                break
            }
        case 6...8 :
            switch(x) {
            case 0...2 :
                yBox = 6
            case 3...5 :
                yBox = 7
            case 6...8 :
                yBox = 8
            default:
                break
            }
        default:
            break
        }
        return yBox
    }
    
    func isCellOverlappedInBox(_ board: [[Int]], _ yIndex: Int, _ xIndex: Int) -> Bool {
        
        var vBegin  = Int(0)
        var vEnd    = Int(0)
        var hBegin  = Int(0)
        var hEnd    = Int(0)
        
        switch(yIndex) {
        case 0, 1, 2 :
            vBegin = 0
            vEnd = 2
        case 3, 4, 5 :
            vBegin = 3
            vEnd = 5
        case 6, 7, 8 :
            vBegin = 6
            vEnd = 8
        default :
            break
        }
        
        switch(xIndex) {
        case 0, 1, 2 :
            hBegin = 0
            hEnd = 2
        case 3, 4, 5 :
            hBegin = 3
            hEnd = 5
        case 6, 7, 8 :
            hBegin = 6
            hEnd = 8
        default :
            break
        }
        
        var sArr = [Int]()
        for k in vBegin...vEnd {
            for m in hBegin...hEnd {
                sArr.append(board[k][m])
            }
        }
        let bDup : Bool = hasArrayOverlap(sArr)
        return bDup
    }
    
    func hasArrayOverlap(_ arr: [Int]) -> Bool {
        
        var tempArr = Array(repeating: Bool(false), count: 9)
        for i in arr {
            if i != 0 {
                if (tempArr[i - 1] == false)
                {
                    tempArr[i - 1] = true
                }
                else
                {
                    return true
                }
            }
        }
        return false
    }
    
    func hasVerticalOverlap(_ arr : [[Int]],_ index: Int) -> Bool {
        
        var testArr = [Int]()
        for i in arr {
            testArr.append(i[index])
        }
        return hasArrayOverlap(testArr)
    }
    
    func hasHorizontalOverlap(_ arr : [[Int]], _ index : Int) -> Bool {
        
        let testArr = arr[index]
        return hasArrayOverlap(testArr)
    }
    
    func getValidNumbersFromArr(_ arr : [Int]) -> [Int]{
        
        var tempArr = Array(repeating: Bool(false), count: 9)
        var validArr = [Int]()
        for i in arr {
            if i != 0
            {
                tempArr[i - 1] = true
            }
        }
        
        for (index, item) in tempArr.enumerated() {
            if item != true
            {
                validArr.append(index+1)
            }
        }
        return validArr
    }
    
    func getVerticalArrByHorIndex(_ board: [[Int]], _ xIndex: Int) -> [Int] {
        
        var arr = [Int]()
        
        for i in 0...8 {
            arr.append(board[i][xIndex])
        }
        return arr
    }
    
    func getBoxArrFromBoxIndex(_ board: [[Int]], _ index: Int) -> [Int] {
        
        let loopRange = getBoxLoopRange(index)
        var boxArr = [Int]()
        
        for i in loopRange.0...loopRange.1 {
            for j in loopRange.2...loopRange.3 {
                boxArr.append(board[i][j])
            }
        }
        return boxArr
    }
    
    func getVerticalArrByCellIdx(_ board: [[Int]], _ index: Int) -> [Int] {
        
        let x = index % 9
        var vArr = [Int]()
        
        for i in board {
            vArr.append(i[x])
        }
        return vArr
    }
    
    func getHorizontalArrByCellIdx(_ board: [[Int]], _ index: Int) -> [Int] {
        
        let y = index / 9
        return board[y]
    }
    
    func getValidNumbersByCellIdx(_ board: [[Int]], _ index: Int) -> [Int] {
        
        let yValidArr: [Int] = getValidNumbersFromArr(getVerticalArrByCellIdx(board, index))
        let xValidArr: [Int] = getValidNumbersFromArr(getHorizontalArrByCellIdx(board, index))
        let boxIndex = getBoxIndexFromCellIndex(index)
        let boxValidArr: [Int] = getValidNumbersFromArr(getBoxArrFromBoxIndex(board, boxIndex))
        
        var tempArr = Array(repeating: 0, count: 9)
        var resultArr = [Int]()
        for i in yValidArr {
            tempArr[i-1] += 1
        }
        for i in xValidArr {
            tempArr[i-1] += 1
        }
        for i in boxValidArr {
            tempArr[i-1] += 1
        }
        for (index, item) in tempArr.enumerated() {
            if item == 3 {
                resultArr.append(index + 1)
            }
        }
        return resultArr
    }
    
    func isBoardCompleted(_ board:[[Int]]) -> Bool {
        
        for i in board {
            for j in i {
                if j == 0 {
                    return false
                }
            }
        }
        return true
    }
    
    func areTwoBoardsIdentical(_ board1: [[Int]],_ board2: [[Int]]) -> Bool {
        
        for i in 0...8 {
            let arr1 = board1[i]
            let arr2 = board2[i]
            for j in 0...8 {
                if arr1[j] != arr2[j]
                {
                    return false
                }
            }
        }
        return true
    }
    
    func findHiddenCellIndices(_ board: [[Int]]) -> [Int] {
        
        var indices = [Int]()
        for i in board {
            for j in i {
                if j == 0
                {
                    indices.append(j)
                }
            }
        }
        return indices
    }
    
    func countHiddenByBoxes(_ board: [[Int]]) -> [Dictionary<Int, Int>.Element]  {
        
        var cntByBox : [Int:Int] = [:]
        for i in 0...8 {
            let arr = getBoxArrFromBoxIndex(board, i)
            var count = 0
            for j in arr {
                if j == 0
                {
                    count += 1
                }
            }
            cntByBox[i] = count
        }
        
        let result = cntByBox.sorted{ $0.1 > $1.1 }
        
        return result
    }
    
    func countHiddenByLines(_ board: [[Int]]) -> [Dictionary<Int, Int>.Element]  {
        
        var cntByLine : [Int:Int] = [:]
        for i in 0...8 {
            let arr = board[i]
            var count = 0
            for j in arr {
                if j == 0
                {
                    count += 1
                }
            }
            cntByLine[i] = count
        }
        
        let result = cntByLine.sorted{ $0.1 > $1.1 }
        return result
    }
    
    func countHiddenByCullums(_ board: [[Int]]) -> [Dictionary<Int, Int>.Element]  {
        
        var cntByCullum : [Int:Int] = [:]
        for i in 0...8 {
            var count = 0
            for j in 0...8 {
                if board[j][i] == 0
                {
                    count += 1
                }
            }
            cntByCullum[i] = count
        }
        
        let result = cntByCullum.sorted{ $0.1 > $1.1 }
        return result
    }
}

