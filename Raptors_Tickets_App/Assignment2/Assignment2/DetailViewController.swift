//
//  DetailViewController.swift
//  Raptors
//
//  Created by hamedtara on 10/26/23.
//

import UIKit

class DetailViewController: UIViewController {

    
    
    @IBOutlet weak var TicketTypeLabel: UILabel!
    
    @IBOutlet weak var TicketQuantityLabel: UILabel!
    
    @IBOutlet weak var TicketCostLabel: UILabel!
    
    @IBOutlet weak var TicketPurchaseDateLabel: UILabel!
    
    var transaction: Transaction?
    override func viewDidLoad() {
           super.viewDidLoad()
           
           if let transaction = transaction {
               TicketTypeLabel.text = transaction.ticketType
               TicketQuantityLabel.text = "\(transaction.numberOfTickets)"
               TicketCostLabel.text = "$\(transaction.totalCost)"
               
               let dateFormatter = DateFormatter()
               dateFormatter.dateStyle = .medium
               dateFormatter.timeStyle = .none
               TicketPurchaseDateLabel.text = dateFormatter.string(from: transaction.purchaseDate)
           }
       }


}
