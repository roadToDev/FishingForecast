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
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var fishImage: UIImageView!
    
    @IBOutlet weak var month1: UIImageView!
    @IBOutlet weak var month2: UIImageView!
    @IBOutlet weak var month3: UIImageView!
    @IBOutlet weak var month4: UIImageView!
    @IBOutlet weak var month5: UIImageView!
    @IBOutlet weak var month6: UIImageView!
    @IBOutlet weak var month7: UIImageView!
    @IBOutlet weak var month8: UIImageView!
    @IBOutlet weak var month9: UIImageView!
    @IBOutlet weak var month10: UIImageView!
    @IBOutlet weak var month11: UIImageView!
    @IBOutlet weak var month12: UIImageView!    
    
    var fish : Fish?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.separatorStyle = .none
        
        
        
        if let fish = fish {
            fishImage.image = getImage(by: fish.name)
            for name in Constants.fishNames {
                if fish.name == name.key {
                    self.navigationItem.title = name.value
                }
            }
        }
        
        
        addAttributesToNavigatorBar()
        pinBackground(to: seasonsStackView)
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        drawTable(seasonsStackView.frame.size.width, seasonsStackView.frame.size.height, backgroundView)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.setSeasonStars()
        })
    }
    
    @IBAction func getInfo(_ sender: UIButton) {
        
        print("Info bar tapped")
        
    }
    
    func addAttributesToNavigatorBar() {
        
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
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 1
        shapeLayer.add(animation, forKey: "MyAnimation")
        
        view.layer.addSublayer(shapeLayer)
    }

    
    // MARK: - Navigation
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Draw Bite Level Stars
    func setSeasonStars() {
        
        fish?.goodMonthsOfBiting.forEach({ month in
            getSeasonMonths(month, #imageLiteral(resourceName: "one_star"))
        })
        fish?.theBestMonthsOfBiting.forEach({ month in
            getSeasonMonths(month, #imageLiteral(resourceName: "two_stars"))
        })
    }
    
    func getSeasonMonths(_ month: Int, _ image1: UIImage){
        switch month {
        case 1:
            month1.image = image1
        case 2:
            month2.image = image1
        case 3:
            month3.image = image1
        case 4:
            month4.image = image1
        case 5:
            month5.image = image1
        case 6:
            month6.image = image1
        case 7:
            month7.image = image1
        case 8:
            month8.image = image1
        case 9:
            month9.image = image1
        case 10:
            month10.image = image1
        case 11:
            month11.image = image1
        case 12:
            month12.image = image1
        default: break
        }
    }
    
}
// MARK: - TableView
extension FishInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FishInfoTableViewCell
        if indexPath.row == 0 {
            cell.infoDescrLabel.text = "Описание"
        } else {
            cell.infoDescrLabel.text = "Способы ловли и наживка"
        }
        if let description = fish?.description[indexPath.row] {
            cell.descriptionLabel.text = description + "\n"
            cell.descriptionLabel.textColor = .white
        }
        
        return cell
    }
    
    // MARK: - Fish Image
    
    func getImage(by name: String) -> UIImage {
        switch name {
        case "karas":
            return #imageLiteral(resourceName: "karas_r")
        case "krasnoperka":
            return #imageLiteral(resourceName: "krasnoperka_r")
        case "karp":
            return #imageLiteral(resourceName: "karp_r")
        case "leshch":
            return #imageLiteral(resourceName: "leshch_r")
        case "plotva":
            return #imageLiteral(resourceName: "plotva_r")
        case "sazan":
            return #imageLiteral(resourceName: "sazan_r")
        case "amur":
            return #imageLiteral(resourceName: "amur_r")
        case "lin":
            return #imageLiteral(resourceName: "lin_r")
        case "tolstolob":
            return #imageLiteral(resourceName: "tolstolob_r")
        case "podust":
            return #imageLiteral(resourceName: "podust_r")
        case "golavl":
            return #imageLiteral(resourceName: "golavl_r")
        case "elec":
            return #imageLiteral(resourceName: "elec_r")
        case "shchuka":
            return #imageLiteral(resourceName: "shchuka_r")
        case "sudak":
            return #imageLiteral(resourceName: "sudak_r")
        case "okun":
            return #imageLiteral(resourceName: "okun_r")
        case "som":
            return #imageLiteral(resourceName: "som_r")
        case "forel":
            return #imageLiteral(resourceName: "forel_r")
        case "nalim":
            return #imageLiteral(resourceName: "nalim_r")
        case "jereh":
            return #imageLiteral(resourceName: "jereh_r")
        case "yaz":
            return #imageLiteral(resourceName: "yaz_r")
        default:
            return #imageLiteral(resourceName: "forel_r")
        }
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
