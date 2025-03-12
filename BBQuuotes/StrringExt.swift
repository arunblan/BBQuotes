//
//  StrringExt.swift
//  BBQuuotes
//
//  Created by Arun  on 12/03/25.
//

extension String {
    func removeSpaces() -> String {
        self.replacingOccurrences(of: " ", with: "") //one line we dont need to add RETURN to return the string
    }
    
    func removeCaseAndSpace() -> String {
        removeSpaces().lowercased()
    }
}
