//
//  FileGenerator.swift
//  Sudoku
//
//  Created by babyK on 12/2/23.
//

import Foundation

class FileLoader {
    private let fileManager = FileManager.default
//    private let currentPath = "/Users/babyk/workspace/swift/SudokuBoard/SudokuBoard/json"
    private let currentPath = "/Users/babyk/Desktop/SudokuGenerator"
    private let Path_kid = "Board_kid.json"
    private let Path_normal = "Board_normal.json"
    private let Path_hard = "Board_hard.json"
    private let Path_expert = "Board_expert.json"
    private let Path_master = "Board_master.json"
    private let helper = GenHelper()
    
    func loadJsonVO(level: Level) -> [JsonVO] {
        
        var boardArr = [JsonVO]()
        var fileName: String
        switch(level) {
        case .kid       : fileName = Path_kid
        case .normal    : fileName = Path_normal
        case .hard      : fileName = Path_hard
        case .expert    : fileName = Path_expert
        case .master    : fileName = Path_master
        }
        
        let path = String(currentPath + "/" + fileName)

        if !fileManager.fileExists(atPath: currentPath)
        {
            do {
                try fileManager.createDirectory(atPath: currentPath, withIntermediateDirectories: true)
            }
            catch {
             print(error)
            }
            
            print("디렉토리생성 완료 : \(currentPath)")
        }
        
        if fileManager.fileExists(atPath: path) {
            if let contents = fileManager.contents(atPath: path) {
                do {
                    if !contents.isEmpty
                    {
                        let decoder = JSONDecoder()
                        boardArr = try decoder.decode([JsonVO].self, from: contents)
                    }
                }
                catch{
                    print(error)
                }
            }
        }
        else {  // 파일이 없다면 생성
            let bDone = fileManager.createFile(atPath: path, contents: nil)
            if bDone
            {
                print("파일생성 완료 : \(path)")
            }
        }
        return boardArr
    }
    
    func updateFile(boards: [JsonVO], level: Level) {
        
        var fileName :String
        switch(level) {
        case .kid       : fileName = Path_kid
        case .normal    : fileName = Path_normal
        case .hard      : fileName = Path_hard
        case .expert    : fileName = Path_expert
        case .master    : fileName = Path_master
        }
        
        let path = currentPath + "/" + fileName
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(boards)
            let _ = fileManager.createFile(atPath: path, contents: data)
        } catch {
            print(error)
        }
    }
    
    func createBoardJson(level:Level) {
        
        let bGenerator = BoardGenerator()
        let board = bGenerator.genBoard()
        
        let hGenerator = HiddenCellGenerator(board)
        let game = hGenerator.makeHiddenCells(level: level)
        
        var json = loadJsonVO(level: level)
        var difficulty = 0
        let cnt = json.count
        var id = 0
        
        switch(level) {
        case .kid       : 
            difficulty = 0
            id = cnt
        case .normal    :
            difficulty = 1
            id = cnt + 1000
        case .hard      :
            difficulty = 2
            id = cnt + 2000
        case .expert    :
            difficulty = 3
            id = cnt + 3000
        case .master    :
            difficulty = 4
            id = cnt + 4000
        }
        
        let vo = JsonVO.init(id: id ,level: difficulty, stage: cnt, completion: false, board: game, answer: board)
        json.append(vo)
        updateFile(boards: json, level: level)
    }
    
}
