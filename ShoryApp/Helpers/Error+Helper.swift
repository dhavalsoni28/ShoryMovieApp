//
//  Error+Helper.swift
//  ShoryApp
//
//  Created by Dhaval Soni on 09/07/2023.
//

import Foundation

extension NSError {
    
    public convenience init(domain: String? = nil, code: Int? = nil, description: String) {
        let domain = domain ?? "ShoryAppError"
        let userInfo = [NSLocalizedDescriptionKey: description]
        self.init(domain: domain, code: code ?? 0000, userInfo: userInfo)
    }
    
    static let appDefaultError = NSError(description: "Something went wrong. Please try again later.")
}
