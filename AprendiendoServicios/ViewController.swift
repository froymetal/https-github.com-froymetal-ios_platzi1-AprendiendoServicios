//
//  ViewController.swift
//  AprendiendoServicios
//
//  Created by Field Employee on 6/28/21.
//

import UIKit

class ViewController: UIViewController {
    //Referencias UI
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ferchService()
    }
    
    private func ferchService(){
        let endpointString = "https://www.mocky.io/v2/5e2674472f00002800a4f417"
        guard let endpoint = URL(string: endpointString) else{
            return
        }
        //para que empiece a animar
        activityIndicator.startAnimating()
        
        URLSession.shared.dataTask(with: endpoint) { (data: Data?,_,error: Error?) in
            self.activityIndicator.stopAnimating()
            if error != nil {
                print("Hubo error")
            }
            
            guard let dataFromService = data, let dictionary = try? JSONSerialization.jsonObject(with: dataFromService, options: []) as? [String: Any] else{
                return
            }
            //Importante: Todos los llamados a la UI se hacen en el main Thread
            DispatchQueue.main.async {
                let isHappy = dictionary["isHappy"] as? Bool ?? false
                self.nameLabel.text = dictionary["user"] as? String
                self.statusLabel.text = isHappy ? "Es feliz" : "Es triste"
            }
        }.resume()
    }
}

