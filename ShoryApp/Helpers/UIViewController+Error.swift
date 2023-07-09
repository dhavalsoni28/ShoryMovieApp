//
//  UIViewController+Error.swift
//  CashewAppDocumentReader
//
//  Created by Dhaval Soni on 23/05/2023.
//

import UIKit

extension UIViewController {
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
}
