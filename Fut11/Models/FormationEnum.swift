//
//  FormationEnum.swift
//  Fut11
//
//  Created by Felipe Lima on 11/09/23.
//

import Foundation

enum Formation {
    case fourfourtwo
    case fourthreethree
    case fourOneFourOne
    case fourFiveOne
    case threeFourThree
    case threeFiveTwo
    case threeOneFiveOne
    case fiveThreeTwo
    case fiveFourOne

    var positions: [Int] {
        switch self {
        case .fourfourtwo:
            return [0, 1, 2, 4, 5, 9, 6, 8, 11, 12, 14]
        case .fourthreethree:
            return [0, 1, 2, 4, 5, 9, 10, 11, 12, 13, 14]
        case .fourOneFourOne:
            return [0, 1, 2, 4, 5, 7, 9, 6, 8, 11, 13]
        case .fourFiveOne:
            return [0, 1, 2, 4, 5, 9, 6, 10 , 8, 11, 13]
        case .threeFourThree:
            return [0, 2, 3, 4, 9, 6, 8, 11, 12, 13, 14]
        case .threeFiveTwo:
            return [0, 2, 3, 4, 9, 6, 10, 8, 11, 12, 14]
        case .threeOneFiveOne:
            return [0, 2, 3, 4, 7, 9, 6, 10, 8, 11, 13]
        case .fiveThreeTwo:
            return [0, 1, 2, 3, 4, 5, 6, 10, 8, 12, 14]
        case .fiveFourOne:
            return [0, 1, 2, 3, 4, 5, 9, 6 , 8, 11, 13]
        }
    }
    
    func toString() -> String {
        switch self {
        case .fourfourtwo:
            return "4-4-2"
        case .fourthreethree:
            return "4-3-3"
        case .fourOneFourOne:
            return "4-1-4-1"
        case .fourFiveOne:
            return "4-5-1"
        case .threeFourThree:
            return "3-4-3"
        case .threeFiveTwo:
            return "3-5-2"
        case .threeOneFiveOne:
            return "3-1-5-1"
        case .fiveThreeTwo:
            return "5-3-2"
        case .fiveFourOne:
            return "5-4-1"
        }
    }
}
