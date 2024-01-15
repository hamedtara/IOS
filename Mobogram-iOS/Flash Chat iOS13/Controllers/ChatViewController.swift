//
//  ChatViewController.swift
//  Mobogram iOS
//
//  Created by Hamed Tara on 10/01/2024.

//

import UIKit
import Firebase
import FirebaseAuth


class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore();
    
    var messages:[Message] = [
//        Message(sender: "1@2.com ", body: "Hey12"),
//        Message(sender: "2@3.com ", body: "Hey23"),
//        Message(sender: "1@2.com ", body: "Hey12")
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "MessageCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.cellIdentifier)
        
        
        loadMesages()
    }
    
    func loadMesages() {
        
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener{ QuerySnapshot, error in
            self.messages = []

            if let e = error {
                print ("There was an issue retriving data \(e)");
            }else{
                
                if let snapShotDocument = QuerySnapshot?.documents{
                    for docs in snapShotDocument {
                        let data = docs.data()
                        if  let sender = data[K.FStore.senderField] as? String ,
                            let messageBody = data[K.FStore.bodyField] as? String{
                            let newMessage = Message(sender: sender, body: messageBody)
                            self.messages.append(newMessage);
                            
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData();
                                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                self.tableView.scrollToRow(at: indexPath , at: .top, animated: true)
                            }
                        }
                        
                      //  print (docs.data())
                    }
                }
                //print("data successfully retrived");
            }
            
        }
    }

    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text,let messageSender = Auth.auth().currentUser?.email{
            
            db.collection(K.FStore.collectionName)
                .addDocument(data: [K.FStore.senderField:messageSender,
                                    K.FStore.bodyField:messageBody,
                                    K.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let e = error{
                    print("There  was an error to save data at fireStore,\(e)");
                }else{
                    print("The data is successfully added ")
                    
//                    DispatchQueue.main.sync {
//                        self.messageTextfield.text = "";
//
//                    }
                }
            }
            
        }
        
    }
    

    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            
            navigationController?.popToRootViewController(animated: true)  
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
}


extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCell

        // Display the actual message body
        cell.label?.text = message.body

        // Check if the message was sent by the current user
        if message.sender == Auth.auth().currentUser?.email {
            // User is the sender
          //  cell.leftImageView.isHidden = true
          //  cell.rightImageView.isHidden = false
            cell.MessageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple) // or any color you choose
            cell.label.textColor = UIColor(named: K.BrandColors.purple) // or any color you choose
        } else {
            // User is the receiver
         //   cell.leftImageView.isHidden = true
         //   cell.rightImageView.isHidden = true
            cell.MessageBubble.backgroundColor = UIColor.green // or any color you choose
            cell.label.textColor = UIColor(named: K.BrandColors.blue) // or any color you choose
        }

        return cell
    }

}


