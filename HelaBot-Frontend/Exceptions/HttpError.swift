//
//  HttpError.swift
//  HelaBot SwiftUI
//
//  Created by Guido Gimeno on 21/10/2020.
//

import Foundation

enum HttpError: Error {
    case emptyData
    case communicationFailed(String)
    case statusCode(Int)
    case failedParsingJson
}
