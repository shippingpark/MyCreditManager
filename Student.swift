//
//  Student.swift
//  MyCreditManager
//
//  Created by 박혜운 on 2022/11/21.
//

import Foundation

struct Student {
    private var name:String
    private var totalSubjectAndGrade:[String:String] = [:]
    
    init(name: String) {
        self.name = name
    }
    
    func checkName(name: String) -> Bool {
        if self.name == name {
            return true
        }
        return false
    }
    
    mutating func addSubjectAndGrade(subject:String, grade:String) {
        totalSubjectAndGrade[subject] = grade
        print(totalSubjectAndGrade) //확인용 (추후 삭제) 👀
    }
    
    mutating func deleteSubject(subject:String) {
        totalSubjectAndGrade[subject] = nil
    }
    
    func totalGrade() {
        for (key, value) in totalSubjectAndGrade {
            print("\(key) : \(value)")
        }
        print("평점 : \(calculatetotalGrade())")
    }
    
    private func calculatetotalGrade() -> Double {
        
        let totalGrade: [Double] = totalSubjectAndGrade.values.map{
            switch String($0) {
            case "A+" : return 4.5
            case "A" : return 4.0
            case "B+" : return 3.5
            case "B" : return 3.0
            case "C+" : return 2.5
            case "C" : return 2.0
            case "D+" : return 1.5
            case "D" : return 1.0
            case "F" : return 0.0
            default:
                return 0.0
            }
        }
        var calculateGrade: Double = totalGrade.reduce(0){$0+$1} / Double(totalGrade.count)
        calculateGrade = round(calculateGrade*100)/100
        
        return calculateGrade
    }
    
}
