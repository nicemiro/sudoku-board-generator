//
//  main.swift
//  SudokuBoard
//
//  Created by babyK on 2023/11/09.
//

import Foundation

func createWholeLevel(num : Int) async throws{
    await withThrowingTaskGroup(of: Void.self, body: { group in
        
        for i in Level.allCases {
            group.addTask {
                print("보드 생성 레벨 : \(i)")
                for _ in 0..<num {
                    let file = FileLoader()
                    file.createBoardJson(level: i)
                }
                      print("보드 생성 레벨 \(i) 완료.")
            }
        }
    })
}



/* 생성된 레벨별 Answer Board의 비어있는 셀 검사 */
/*
let loader = FileLoader()
let data = loader.loadJsonVO(level: .expert)

print("COUNT : \(data.count)")
print("START")
var errorIndex = [Int]()
for data in data {
    for board in data.answer {
        for i in board {
            if i == 0 
            {
                errorIndex.append(data.id)
                print(data.id)
            }
        }
    }
}
print("RESULT")
print(errorIndex)
*/



/* 보드 생성 ( 레벨별 각 생성할 보드 갯수 입력 */
let handle = FileHandle.standardInput
var num = Int(0)
print("생성할 보드의 갯수를 입력하고 엔터 : ")

for try await line in handle.bytes.lines {

    if !line.isEmpty {
        num = Int(line)!
    }
    break
}

print("보드 생성 시작")
try await createWholeLevel(num: num)
exit(0)

/*************************/



