//
//  Petition.swift
//  Project7
//
//  Created by Volodymyr Ostapyshyn on 18.05.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
