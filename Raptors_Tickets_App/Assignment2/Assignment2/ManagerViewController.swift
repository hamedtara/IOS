//
//  ManagerViewController.swift
//  Raptors
//
//  Created by hamedtara on 10/26/23.

import UIKit

class ManagerViewController: UIViewController {

    var transactions: [Transaction] = []
    var tickets: [Ticket] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHistory" {
            if let historyView = segue.destination as? HistoryViewController {
                historyView.transactions = self.transactions
            }
        } else if segue.identifier == "showReset" {
            if let resetView = segue.destination as? ResetViewController {
                resetView.tickets = self.tickets
            }
      }
    }

}
