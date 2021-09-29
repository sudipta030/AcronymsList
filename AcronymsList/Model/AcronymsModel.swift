//
//  AcronymsModel.swift
//  AcronymsList
//
//  Created by Sudipta on 29/09/21.
//

import Foundation
struct AcronymsList: Decodable {
    let lfs: [Acronyms]
}
struct Acronyms: Decodable {
    let lf : String?
  
    
}
