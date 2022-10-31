//
//  CustomError.swift
//  Test
//
//  Created by Reyhan on 31/10/22.
//

import Foundation

enum CustomError: String, Error{
    case usernameOrEmailNotInputted = "Username or email are not inputted"
    case userDoesNotExist = "user not found"
    case usernameOrPasswordEmpty = "Missing email or username"
    case emptyPassword = "Missing password"
    case UnexpectedErrorOccured = "Unexpected"
}

extension CustomError: CustomStringConvertible {
    var description: String {
        switch self{
        case .usernameOrEmailNotInputted:
            return "Username or Email not inputted"
        case .userDoesNotExist:
            return "User does not exist"
        case .usernameOrPasswordEmpty:
            return "Email or Password can't be empty"
        case .emptyPassword:
            return "Password can't be empty"
        default:
            return "Unexpected error has occured"
        }
    }
    
    
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .usernameOrEmailNotInputted:
            return "Username or Email not inputted"
        case .userDoesNotExist:
            return "User does not exist"
        case .usernameOrPasswordEmpty:
            return "Email or Password can't be empty"
        case .emptyPassword:
            return "Password can't be empty"
        default:
            return "Unexpected error has occured"
        }
    }
}
