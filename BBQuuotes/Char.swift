//
//  Char.swift
//  BBQuuotes
//
//  Created by Arun  on 08/03/25.
//
import Foundation

struct Char: Decodable{
    let name: String
    let birthday: String
    let ocupation: [String]
    let images: [URL]
    let aliases: [String]
    let status: String
    let protrayedby: String
    var death: Death? // Can be nil
}
