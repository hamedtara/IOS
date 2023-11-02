//
//  ResetViewController.swift
//  Raptors
//
//  Created by hamedtara on 10/26/23.
//

import UIKit

class ResetViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var TicketNum: UITextField!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var TicketPicker: UIPickerView!
    
    @IBOutlet weak var TicketPrice: UITextField!
    var tickets: [Ticket] = [];
    var selectedTicketType: Ticket?;
    var updatedTicket: Ticket?;
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tickets.count;
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        let ticket = tickets[row]
        return "\(ticket.type) - \(ticket.available) left - $\(ticket.price)"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTicketType = tickets[row]
    }
    @IBAction func SaveChanges(_ sender: UIButton) {
        guard let newCountString = TicketNum.text,
              let newPriceString = TicketPrice.text,
              let newCount = Int(newCountString),
              let newPrice = Int(newPriceString),
              let selectedTicket = selectedTicketType
        else {
            return
        }
        if let index = tickets.firstIndex(where: { $0.type == selectedTicket.type }) {
            tickets[index].available = selectedTicket.available + newCount
            tickets[index].price = selectedTicket.price + Double(newPrice)
            updatedTicket = Ticket(type: selectedTicket.type, price: tickets[index].price, available: tickets[index].available)
            TicketPicker.reloadAllComponents()
        }
    }
    @IBAction func Update(_ sender: UIButton) {
        TicketManager.shared.editTicket(updatedTicket!)
    }
    @IBAction func Cancel(_ sender: Any) {
        TicketPrice.text = ""
        TicketNum.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Tickets in ResetViewController: \(tickets)")
        
        TicketPicker.delegate = self
        TicketPicker.dataSource = self
        TicketPicker.reloadAllComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tickets = TicketManager.shared.getTickets()
            TicketPicker.reloadAllComponents()
        }
}
