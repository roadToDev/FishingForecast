//
//  FishInfoViewController.swift
//  FishingForecast
//
//  Created by Alex on 3/21/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class FishInfoViewController: UIViewController {

    @IBOutlet weak var seasonsStackView: UIStackView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addAttributesToNavigatorBar()
        pinBackground(to: seasonsStackView)
    
    }
    
    private func pinBackground(to stackView: UIStackView) {
        let backgroundView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.darkGray
            view.alpha = 0.5
            view.layer.cornerRadius = 10.0
            return view
        }()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(backgroundView, at: 0)
        backgroundView.pin(to: stackView)
    }
    
    
    
    @IBAction func getInfo(_ sender: UIButton) {
        
        print("Info bar tapped")
        
    }
    
    func addAttributesToNavigatorBar() {
        self.navigationItem.title = "Белый-Амур"
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        
        let infoBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "info_button"), style: .plain, target: self, action: #selector(getInfo))
        self.navigationItem.setRightBarButton(infoBarButton, animated: true)
    }
    
    // MARK: - Navigation
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
public extension UIView {
    public func pin(to view: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}
