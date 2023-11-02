//
//  ViewController.swift
//  Raptors
//
//  Created by hamedtara on 10/26/23.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    


    @IBOutlet weak var TicketType: UILabel!
    
    @IBOutlet weak var TicketQuantity: UILabel!
    
    @IBOutlet weak var TotalPrice: UILabel!
    
    @IBOutlet weak var TicketPicker: UIPickerView!
    
    @IBAction func Button(_ sender: UIButton) {
        switch sender.titleLabel?.text
        {
        case "1", "2", "3", "4", "5", "6", "7", "8", "9", "0":
            if let number = Int(sender.titleLabel?.text ?? "") {
                getNumbers(number: number)
            }
        case "Buy":
            calPrice()
            buyButton()
        default:
            break
        }
    }
    
    var transactions: [Transaction] = []
    var selTicketType: Ticket?
    var NumberOfTickets: Int = 0
    var tranHistory: [Transaction] = []
    var tickets: [Ticket] = []
    var updatedTicket: Ticket?
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tickets = TicketManager.shared.getTickets()
            TicketPicker.reloadAllComponents()
        }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tickets.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let ticket = tickets[row];
        return "\(ticket.type) - \(ticket.available) left - $\(ticket.price)";
    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selTicketType = tickets[row];
        TicketType.text = selTicketType?.type;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        TicketType.backgroundColor = UIColor.white
            TicketQuantity.backgroundColor = UIColor.white
            TotalPrice.backgroundColor = UIColor.white
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showManager", let managerVC = segue.destination as? ManagerViewController {

            
            managerVC.transactions = self.tranHistory
        }
    }

    func getNumbers(number: Int) {
        NumberOfTickets = NumberOfTickets * 10 + number
        TicketQuantity.text = "\(NumberOfTickets)"
    }

    func calPrice() {
        if let ticketType = selTicketType {
            let totalCost = ticketType.price * Double(NumberOfTickets)
            TotalPrice.text = "$\(totalCost)"
        }
    }

    
    func buyButton() {
        guard let ticketType = selTicketType else {
                return
        }

        if NumberOfTickets > ticketType.available {
            NumberOfTickets = 0
        } else {
            if let index = tickets.firstIndex(where: { $0.type == ticketType.type }) {
                tickets[index].available -= NumberOfTickets
                
          
                let transaction = Transaction(ticketType: ticketType.type, numberOfTickets: NumberOfTickets, totalCost: ticketType.price * Double(NumberOfTickets), purchaseDate: Date())
                tranHistory.append(transaction)
                updatedTicket = Ticket(type: ticketType.type, price: tickets[index].price, available: tickets[index].available)
                TicketManager.shared.editTicket(updatedTicket!)
                NumberOfTickets = 0
                TicketQuantity.text = ""
                TicketPicker.reloadAllComponents()
            }
        }
    }
    
}
