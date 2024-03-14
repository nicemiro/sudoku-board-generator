//
//  SudokuBoard.swift
//  SudokuBoard
//
//  Created by babyK on 2023/11/09.
//

import Foundation

class BoardGenerator {
    
    var board : [[Int]]
    let genHelper = GenHelper()
    init() {
        self.board = Array(repeating: Array(repeating: Int(0), count: 9), count: 9)
    }
    
    func genBoard() -> [[Int]] {
        repeat {
            self.board = Array(repeating: Array(repeating: Int(0), count: 9), count: 9)
            
            var boxIndex = 0    // 생성중인 박스 인덱스 번호
            while( boxIndex < 9 ) {
                let loopRange = genHelper.getBoxLoopRange(boxIndex)
                var bBoxRemove = false  // 박스 리젠 플래그
                var repeatCnt = 0       // 현재 박스안에서 발생된 셀의 중복입력 카운트
                var numBoxRemoveTo = 0  // 박스초기화시 몇번째 박스까지 초기화 할것인가
                
                boxLoop : while(true) {
                    for k in loopRange.0...loopRange.1 {
                        for m in loopRange.2...loopRange.3 {
                            var bDupPass = false
                            var randomNums = [1,2,3,4,5,6,7,8,9]
                            randomNums.shuffle()
                            
                            repeat {
                                repeatCnt += 1  // 셀 한자리에서 발생하는 중복카운트
                                if !randomNums.isEmpty
                                {
                                    let random = randomNums.removeFirst()
                                    board[k][m] = random
                                    
                                    // 보드셀 중복 체크
                                    bDupPass = !(genHelper.isCellOverlappedInBox(board, k, m))
                                    && !(genHelper.hasHorizontalOverlap(board, k))
                                    && !(genHelper.hasVerticalOverlap(board, m))
                                    
                                    if !bDupPass
                                    {   // 중복 발생한 박스별 리젠코드
                                        switch(boxIndex) {
                                        case 0, 1 :
                                            if repeatCnt > 200
                                            {
                                                bBoxRemove = true
                                                numBoxRemoveTo = 0
                                            }
                                        case 2 :
                                            if repeatCnt > 300
                                            {
                                                bBoxRemove = true
                                                numBoxRemoveTo = 0
                                            }
                                        case 3, 4 :
                                            if repeatCnt > 150
                                            {
                                                bBoxRemove = true
                                                numBoxRemoveTo = 2
                                            }
                                        case 5 :
                                            if repeatCnt > 150
                                            {
                                                bBoxRemove = true
                                                numBoxRemoveTo = 3
                                            }
                                        case 6 :
                                            if repeatCnt > 120
                                            {
                                                bBoxRemove = true
                                                numBoxRemoveTo = 3
                                            }
                                        case 7 :
                                            if repeatCnt > 150
                                            {
                                                bBoxRemove = true
                                                numBoxRemoveTo = 3
                                            }
                                        case 8 :
                                            if repeatCnt > 150
                                            {
                                                board = Array(repeating: Array(repeating: Int(0), count: 9), count: 9)
                                                boxIndex = 0
                                                repeatCnt = 0
                                                break boxLoop
                                            }
                                        default :
                                            break
                                        }
                                        if (bBoxRemove)
                                        {
                                            while( boxIndex >= numBoxRemoveTo ) {   // 리젠할 박스의 셀들을 0으로 초기화
                                                genHelper.removeBox(&board, boxIndex)
                                                boxIndex -= 1
                                            }
                                            repeatCnt = 0
                                            break boxLoop
                                        }
                                        board[k][m] = 0
                                        randomNums.append(random)
                                    }   // END if !bDupPass // 중복 발생되어 셀 비움
                                }   // END if !randomNums.isEmpty
                            } while (!bDupPass)
                        }
                    }
                    break boxLoop
                }   // END boxLoop : while(true) {
                boxIndex += 1 // 박스 생성 완료
            }
            
        } while (!genHelper.isBoardValid(board))    // 최종 완성 보드의 빈 셀 검사
        
        return board
        
    }   // END func genBoard
}
