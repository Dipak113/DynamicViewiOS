//
//  Array+Extension.swift
//  SkodaValuation
//
//  Created by Raju@MFCWL on 12/11/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    mutating func remove(element: Element) {
        guard let index = firstIndex(of: element) else {return}
        remove(at: index)
    }
}
