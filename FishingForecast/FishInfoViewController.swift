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
    
    
    // MARK: - Add Stack Background
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.alpha = 0.5
        view.layer.cornerRadius = 8.0
        return view
    }()
    private func pinBackground(to stackView: UIStackView) {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(backgroundView, at: 0)
        backgroundView.pin(to: stackView)
    }
    
    // MARK: - Draw Table(Vertical and Horizontal lines)
    override func viewDidAppear(_ animated: Bool) {
        drawTable(seasonsStackView.frame.size.width, seasonsStackView.frame.size.height, backgroundView)
    }
    
    func drawVerticalLines(_ width: CGFloat, _ height: CGFloat, _ view: UIView) {
        var xCoordinates : [CGFloat] {
            var array = [CGFloat]()
            let interval = width / 3
            var x : CGFloat = 0
            for _ in 0...1 {
                x += interval
                array.append(x)
            }
            return array
        }
        
        xCoordinates.forEach { xCoordinate in
            drawLineFromPoint(start: CGPoint(x: xCoordinate, y: 0), toPoint:  CGPoint(x: xCoordinate, y: height), ofColor: .black, inView: view)
        }
    }
    func drawHorizontalLines(_ width: CGFloat, _ height: CGFloat, _ view: UIView) {
        var yCoordinates : [CGFloat] {
            var array = [CGFloat]()
            let interval = height / 4
            var y : CGFloat = 0
            for _ in 0...2 {
                y += interval
                array.append(y)
            }
            return array
        }
        
        yCoordinates.forEach { yCoordinate in
            drawLineFromPoint(start: CGPoint(x: 0, y: yCoordinate), toPoint:  CGPoint(x: width, y: yCoordinate), ofColor: .black, inView: view)
        }
    }
    
    func drawTable(_ width: CGFloat, _ height: CGFloat, _ view: UIView) {
        drawVerticalLines(width, height, view)
        drawHorizontalLines(width, height, view)
    }
    
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView) {
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 1.0
        
        view.layer.addSublayer(shapeLayer)
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
