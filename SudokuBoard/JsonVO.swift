//
//  JsonVO.swift
//  Sudoku
//
//  Created by babyK on 12/2/23.
//

import Foundation

struct JsonVO : Codable{

    var id : Int
    var level : Int
    var stage : Int
    var completion : Bool
    var board : [[Int]]
    var answer: [[Int]]
    
    init(id : Int, level: Int, stage: Int, completion: Bool, board: [[Int]], answer: [[Int]]) {
        self.id = id
        self.level = level
        self.stage = stage
        self.completion = completion
        self.board = board
        self.answer = answer
    }
}
