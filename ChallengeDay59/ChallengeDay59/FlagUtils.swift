//
//  FlagUtils.swift
//  ChallengeDay59
//
//  Created by Volodymyr Ostapyshyn on 29.06.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import Foundation
import UIKit

let prefixSD = "flag_sd_"
let prefixHD = "flag_hd_"
let flagExt = ".png"

func getFlagFileName(code: String, type: FlagType) -> String {
    return getFlagPrefix(type: type) + code + flagExt
}

func getFlagPrefix(type: FlagType) -> String {
    switch(type) {
    case .HD:
        return prefixHD
    case .SD:
        return prefixSD
    }
}


func getPrefix() -> String {
    return "flag_hd_"
    
}

enum FlagType {
    case HD
    case SD
}


class ViewControllers: UIViewController {
    var username: String
    
    required init?(coder aDecoder: NSCoder) {
        self.username = "Anonymous"
        super.init(coder: aDecoder)
    }
}
