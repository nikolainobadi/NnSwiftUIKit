//
//  NnErrorAlert.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import Foundation

struct NnErrorAlert: Identifiable {
    var id = UUID()
    var title: String = "Error"
    var message: String = ""
    var dismissAction: (() -> Void)?
}
