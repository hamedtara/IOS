//
//  AddImageViewController.swift
//  DownloadingImage_week9
//
//  Created by user234266 on 11/12/23.
//

import UIKit

protocol AddImageDelegate: AnyObject {
    
    func didAddNewImage(withTitle title: String, url: String)
    
}

class AddImageViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!`
    
     var delegate: AddImageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func AddButtonAction(_ sender: Any) {
        if let title = titleTextField.text, !title.isEmpty {
            if let url = urlTextField.text, !url.isEmpty {
                print(title, url)
                print(delegate)
                self.delegate?.didAddNewImage(withTitle: title, url: url)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func CancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
