//  Raptors
//
//  Created by hamedtara on 10/26/23.

import Foundation

class TicketManager {
    static let shared = TicketManager()
    private var tickets: [Ticket] = []
    var ticketActions: (([Ticket]) -> Void)?
    
    private init() {
        tickets.append(Ticket(type: "Balcony", price: 1170, available: 20))
        tickets.append(Ticket(type: "Lower", price: 10434, available: 20))
        tickets.append(Ticket(type: "Courtside", price: 27777, available: 15))
    }
    func editTicket(_ updatedTicket: Ticket) {
        if let index = tickets.firstIndex(where: { $0.type == updatedTicket.type }) {
            tickets[index] = updatedTicket
            ticketActions?(tickets)
        }
    }
    
    func getTickets() -> [Ticket] {
        return tickets
    }
}
