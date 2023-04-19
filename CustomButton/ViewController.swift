//
//  ViewController.swift
//  CustomButton
//
//  Created by Chandrakant Shingala on 07/01/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myButton.backgroundColor = .link
        myButton.setTitleColor(.white, for: .normal)
        myButton.setTitle("show Alert", for: .normal)
    }
      
    @IBAction func myButtonTapped(_ sender: UIButton) {
        
        let customAlert = MyAlert()
        customAlert.showAlert(with: "Hello World",
                              message: "This is my Alert",
                              on: self )
        
    }
    
}

class MyAlert {
  
    struct Constant{
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    
    private var backgroundView: UIView {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }
    
    private var alertView: UIView {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
    }
    
    func showAlert(with title: String,
                   message: String,
                   on viewController: UIViewController) {
        guard let targetView = viewController.view else {
            return
        }
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        
        targetView.addSubview(alertView)
        alertView.frame = CGRect(x: 40,
                                 y: -300,
                                 width: targetView.frame.size.width - 80,
                                 height: 300)
        
        let titelLabel = UILabel(frame: CGRect(x: 0,
                                               y: 0,
                                               width: alertView.frame.size.width,
                                               height: 80))
        titelLabel.text = title
        titelLabel.textAlignment = .center
        alertView.addSubview(titelLabel)
        
        let messageLabel = UILabel(frame: CGRect(x: 0,
                                               y: 80,
                                               width: alertView.frame.size.width,
                                               height: 170))
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        messageLabel.textAlignment = .left
        alertView.addSubview(messageLabel)
        
        let button = UIButton(frame: CGRect(x: 0,
                                            y: alertView.frame.size.height - 50,
                                            width: alertView.frame.size.width,
                                            height: 50))
       
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self,
                         action: #selector(dismissAlert),
                         for: .touchUpInside)
        alertView.addSubview(button)
        
        UIView.animate(withDuration: 0.25,
                       animations: {
            
            self.backgroundView.alpha = Constant.backgroundAlphaTo
            
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.alertView.center = targetView.center
                })
            }
        })
    }
    
    @objc func dismissAlert() {
        
    }
}
