//
//  ViewController.swift
//  DownloadingImage_week9
//
//  Created by user234266 on 11/12/23.


import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, AddImageDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!

    var images: [ImageInfo] = []

    
//    var imageTitles: [String] = []
//    var imageLinks : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        navigationController?.setNavigationBarHidden(false, animated: false)
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }

       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return images.count
       }

       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return images[row].title
       }

       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           loadImage(url: images[row].url)
       }
    
    
    func loadImage(url: String) {
          if let url = URL(string: url) {
              let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                  if let data = data, let image = UIImage(data: data) {
                      DispatchQueue.main.async {
                          self?.imageView.image = image
                      }
                  }
              }
              task.resume()
          }
      }
   
    // MARK: - AddImageDelegate Methods

    func didAddNewImage(withTitle title: String, url: String) {
          images.append(ImageInfo(title: title, url: url))
          pickerView.reloadAllComponents()
      }

    // MARK: - Navigation

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let addImageVC = storyboard.instantiateViewController(withIdentifier: "a") as? AddImageViewController {
                self.navigationController?.pushViewController(addImageVC, animated: true)
            }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "a" {
            if let addImageVC = segue.destination as? AddImageViewController {
                addImageVC.delegate =  self
            }
        }
    }
}

