//
//  HistoryViewController.swift
//  Raptors
//
//  Created by hamedtara on 10/26/23.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var TableView: UITableView!
    var transactions: [Transaction] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            if TableView == nil {
            } else {
                TableView.dataSource = self;
            }
            TableView.reloadData()

        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showDetail",
               let detailVC = segue.destination as? DetailViewController,
               let selectedIndex = TableView.indexPathForSelectedRow {
                detailVC.transaction = transactions[selectedIndex.row]
            }
        }


        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return transactions.count;
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell") else {
                fatalError("Could not dequeue cell with identifier: TransactionCell")
            }
            let transaction = transactions[indexPath.row]
            cell.textLabel?.text = transaction.ticketType;
            cell.detailTextLabel?.text = "\(transaction.numberOfTickets)"
            return cell
            
        }
    }
