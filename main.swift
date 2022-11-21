//
//  main.swift
//  MyCreditManager
//
//  Created by 박혜운 on 2022/11/21.
//

import Foundation

class MyCreditManager {
    private enum TrackingRequest {
        case addStudent
        case deleteStudent
        case addSubjectAndGrade
        case deleteSubjectAndGrade
        case totalGrade
        case exit
        case error
        }
    
    private var myStudents:[Student] = []
    
    ///유저가 원하는 동작을 '지시'할 책임
    func selectMenu() {
        var clieckedMenu: TrackingRequest?
        while clieckedMenu != .exit {
            clieckedMenu = questionForUser()
            switch clieckedMenu {
            case .addStudent: addStudent()
            case .deleteStudent: deleteStudent()
            case .addSubjectAndGrade: addSubjectAndGrade()
            case .deleteSubjectAndGrade: deleteSubjectAndGrade()
            case .totalGrade: totalGrade()
            case .exit: print("프로그램을 종료 합니다...")
            case .error: print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
            case nil: break
            }
        }
    }
    
    
    ///유저가 '원하는 동작'을 '질문'할 책임
    private func questionForUser() -> TrackingRequest {
        let trackingStateMessages: [String : TrackingRequest ]
        = ["1" : .addStudent,
           "2" : .deleteStudent,
           "3" : .addSubjectAndGrade,
           "4" : .deleteSubjectAndGrade ,
           "5" : .totalGrade,
           "x" : .exit,
           "X" : .exit,
           "0" : .error]
        
        print("원하는 기능을 입력해주세요")
        print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
        let enterAnswer = String(readLine()!)
        let whatMenu = trackingStateMessages[enterAnswer] ?? .error
        
        return whatMenu
    }
    

    ///유저가 원하는 '학생 추가'를 '요청'할 책임
    private func addStudent() {
        print("추가할 학생의 이름을 입력해주세요.")
        let enterStudent = String(readLine()!)
        guard enterStudent != "" else { return
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
        guard myStudents.filter({$0.checkName(name: enterStudent)}).count == 0 else { return
            print("\(enterStudent)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        }
        myStudents.append(Student(name: enterStudent))
        print("\(enterStudent) 학생을 추가했습니다.")
        
    }
    
    ///유저가 원하는 학생 '삭제'를 '요청'할 책임
    private func deleteStudent() {
        print("삭제할 학생의 이름을 입력해주세요.")
        let enterStudent = String(readLine()!)
        guard enterStudent != "" else { return
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
        guard myStudents.filter({$0.checkName(name: enterStudent)}).count == 1 else { return
            print("\(enterStudent) 학생을 찾지 못했습니다.")
        }
        myStudents = myStudents.filter{!$0.checkName(name: enterStudent)}
        print("\(enterStudent) 학생을 삭제했습니다")
        
    }
    
    ///유저가 원하는 학생의 '성적을 추가, 변경' '요청'할 책임
    private func addSubjectAndGrade() {
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift A+\n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        let enterSubjectAndGrade = String(readLine()!).components(separatedBy: " ")
        guard !enterSubjectAndGrade.contains("") else { return
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
        guard enterSubjectAndGrade.count == 3 else { return
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
            
        let nameSet = enterSubjectAndGrade[0]
        let subjectSet = enterSubjectAndGrade[1]
        let gradeSet = enterSubjectAndGrade[2]
        
        guard myStudents.filter({$0.checkName(name: nameSet)}).count == 1 else { return
            print("\(nameSet) 학생을 찾지 못했습니다.")
        }
        
        for (index, student) in myStudents.enumerated() {
            if student.checkName(name: nameSet) {
                myStudents[index].addSubjectAndGrade(subject: subjectSet, grade: gradeSet)
                print("\(nameSet) 학생의 \(subjectSet) 과목이 \(gradeSet)로 추가(변경)되었습니다.")
                break
            }
        }
    }
    
    ///유저가 원하는 학생의 '성적을 삭제' '요청'할 책임
    private func deleteSubjectAndGrade() {
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift")
        let enterSubject = String(readLine()!).components(separatedBy: " ")
        guard !enterSubject.contains("") else { return
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
        
        guard enterSubject.count == 2 else { return
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
        let nameSet = enterSubject[0]
        let subjectSet = enterSubject[1]
        
        guard myStudents.filter({$0.checkName(name: nameSet)}).count == 1 else { return
            print("\(nameSet) 학생을 찾지 못했습니다.")
        }
        
        for (index, student) in myStudents.enumerated() {
            if student.checkName(name: nameSet) {
                myStudents[index].deleteSubject(subject: subjectSet)
                print("\(nameSet) 학생의 \(subjectSet) 과목의 성적이 삭제되었습니다.")
                break
            }
        }
    }
    
    
    ///유저가 원하는 학생의 '성적 정보'를 '요청'할 책임
    private func totalGrade() {
        print("평점을 알고싶은 학생의 이름을 입력해주세요")
        let enterStudent = String(readLine()!)
        guard enterStudent != "" else { return
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
        guard myStudents.filter({$0.checkName(name: enterStudent)}).count == 1 else { return
            print("\(enterStudent) 학생을 찾지 못했습니다.")
        }
        
        for (index, student) in myStudents.enumerated() {
            if student.checkName(name: enterStudent) {
                myStudents[index].totalGrade()
                break
            }
        }
    }
}



let hyeunCreditManager = MyCreditManager()
hyeunCreditManager.selectMenu()

