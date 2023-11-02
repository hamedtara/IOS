//
//  ManagerView.swift
//  Assignment2
//
//  Created by user235795 on 10/28/23.
//

import Foundation

class ManagerView: UIViewController {

    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ManagerViewController - Received transactions: \(transactions)")

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHistory" {
            if let historyVC = segue.destination as? HistoryViewController {
                print("ManagerViewController - Transferring data to HistoryViewController: \(transactions)")
                historyVC.transactions = self.transactions
            }
        } else if segue.identifier == "showReset" {
            if let resetVC = segue.destination as? ResetViewController {
                print("ManagerViewController - Transferring data to ResetViewController: \(tickets)")
                resetVC.tickets = self.tickets
            }
      }
    }
}
