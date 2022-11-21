//
//  main.swift
//  MyCreditManager
//
//  Created by 박혜운 on 2022/11/21.
//

import Foundation

/* 필요 기능
- 학생추가
- 학생삭제
- 성적추가(변경)
- 성적삭제
- 평점보기
- 종료
*/


class MyCreditManager {
    
    private enum TrackingRequest {
        case addStudent
        case deleteStudent
        case addScore
        case deleteScore
        case totalGrade
        case exit
        case error
        }
    
    /* 공백 기준으로 분리하고 String으로 받는 방법
     let result = input.components(separatedBy: " ")
     print(type(of: result))
    */
    
    ///⭐️유저가 원하는 동작을 '획득' => '지시' 책임
    func selectMenu() {
        var clieckedMenu: TrackingRequest?
        while clieckedMenu != .exit {
            clieckedMenu = questionForUser()
            switch clieckedMenu {
            case .addStudent: addStudent()
            case .deleteStudent: deleteStudent()
            case .addScore: addScore()
            case .deleteScore: deleteScore()
            case .totalGrade: totalGrade()
            case .exit: print("프로그램을 종료 합니다...")
            case .error: print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
            case nil: break
            }
        }
    }
    
    private func questionForUser() -> TrackingRequest {
        let trackingStateMessages: [String : TrackingRequest ]
        = ["1" : .addStudent,
           "2" : .deleteStudent,
           "3" : .addScore,
           "4" : .deleteScore ,
           "5" : .totalGrade,
           "x" : .exit,
           "X" : .exit,
           "0" : .error]
        
        print("원하는 기능을 입력해주세요")
        print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
        let enterAnswer = String(readLine()!)
        let whatMenu = trackingStateMessages[enterAnswer] ?? .error
        print("The value is \(whatMenu)") //확인용 (추후 삭제) 👀
        return whatMenu
    }
    

    func addStudent() {
        print("1")
        
    }
    
    
    func deleteStudent() {
        
    }
    
    func addScore() {
        
    }
    
    func deleteScore() {
        
    }
    
    func totalGrade() {
        
    }
    
    
}


let hyeunCreditManager = MyCreditManager()

hyeunCreditManager.selectMenu()
