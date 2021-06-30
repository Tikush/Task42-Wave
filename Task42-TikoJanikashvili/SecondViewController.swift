//
//  SecondViewController.swift
//  Task42-TikoJanikashvili
//
//  Created by Tiko on 30.06.21.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var wavelabel: UILabel!
    
    var shapeView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        return v
    }()
    
    private let bezierPath = UIBezierPath()
    private let shapeLayer = CAShapeLayer()
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(self.shapeView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callButton.layer.cornerRadius = 15
        NSLayoutConstraint.activate([
            shapeView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            shapeView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            shapeView.bottomAnchor.constraint(equalTo: self.wavelabel.topAnchor, constant: 4),
            shapeView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: -105)
        ])
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addCurve(to: CGPoint(x: self.shapeView.bounds.maxX / 2, y: 25),
                      controlPoint1: CGPoint(x: self.shapeView.bounds.maxX / 4, y: 0),
                      controlPoint2: CGPoint(x:self.shapeView.bounds.maxX / 3, y: 25))
        path.addCurve(to: CGPoint(x: self.shapeView.bounds.maxX, y: 55),
                      controlPoint1: CGPoint(x: self.shapeView.bounds.maxX / 3, y: 0),
                      controlPoint2: CGPoint(x:self.shapeView.bounds.maxX / 4, y: 25))
        path.addLine(to: CGPoint(x: self.shapeView.bounds.maxX, y: self.shapeView.bounds.maxY))
        path.addLine(to: CGPoint(x: 0, y: self.shapeView.bounds.maxY))
        path.addLine(to: .zero)
        path.close()
        
        
        shapeLayer.path = path.cgPath
        
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeView.layer.mask = shapeLayer
        self.shapeView.layer.addSublayer(shapeLayer)
    }
}
