//
//  ViewController.swift
//  FlowerLens
//
//  Created by Hamed Tara on 2024-02-04.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON


class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    let imagePicker = UIImagePickerController();

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self;
        imagePicker.allowsEditing = true;
        imagePicker.sourceType = .camera;
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBOutlet weak var label: UILabel!
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[.editedImage] as? UIImage {
            
            guard let convertedCIIamge = CIImage(image:userPickedImage) else {
                fatalError("Cannot Convert To CI Image ")
            }
            
            detect(image: convertedCIIamge)
            
            imageView.image = userPickedImage
        }
        
        imagePicker.dismiss(animated: true,completion: nil)
        
    }
    
    func detect(image:CIImage){
        guard let model = try? VNCoreMLModel(for:FlowerClassifier().model) else{
            fatalError("Can not import model")
        }
        
        let requset = VNCoreMLRequest(model: model){(request,error) in
            guard let classification = request.results?.first as? VNClassificationObservation else {
                fatalError("could not classify image")
            }
            
            
            self.navigationItem.title = classification.identifier.capitalized
            self.requestInfo(flowerName: classification.identifier);
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do{
            try handler.perform([requset])
        }catch{
            print(error)
        }
    }
    
    func requestInfo(flowerName: String){
        let parameters : [String:String] = [
        "format" : "json",
        "action" : "query",
        "prop" : "extracts",
        "exintro" : "",
        "explaintext" : "",
        "titles" : flowerName,
        "indexpageids" : "",
        "redirects" : "1",
        ]
        
        

        AF.request(wikipediaURl, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Got The wikipedia Info")
                let flowerJson: JSON = JSON(value)
                let pageId = flowerJson["query"]["pageids"][0].stringValue
                let flowerDescription = flowerJson["query"]["pages"][pageId]["extract"].stringValue
                DispatchQueue.main.async {
                    self.label.text = flowerDescription
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.label.text = "Failed to load information"
                }
            }
        }

    }
    


    @IBAction func cameraTaped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
}

