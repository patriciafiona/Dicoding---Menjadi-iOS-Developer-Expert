//
//  ViewController.swift
//  GreetingApps
//
//  Created by Patricia Fiona on 13/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var welcome: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let usecase = Injection.init().provideUseCase()
        let presenter = MessagePresenter(useCase: usecase)
     
        let message = presenter.getMessage(name: "Dicoding")
     
        welcome.text = message.welcomeMessage
    }


}

