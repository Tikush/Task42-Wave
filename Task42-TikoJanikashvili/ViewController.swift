//
//  ViewController.swift
//  Task42-TikoJanikashvili
//
//  Created by Tiko on 29.06.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    
    private weak var displayLink: CADisplayLink?
    private var startTime: CFTimeInterval = 0
    
    private let shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 3
        return shapeLayer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.layer.addSublayer(shapeLayer)
        startDisplayLink()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopDisplayLink()
    }
    
    private func startDisplayLink() {
        startTime = CACurrentMediaTime()
        self.displayLink?.invalidate()
        let displayLink = CADisplayLink(target: self, selector:#selector(handleDisplayLink(_:)))
        displayLink.add(to: .main, forMode: .common)
        self.displayLink = displayLink
    }
    
    private func stopDisplayLink() {
        displayLink?.invalidate()
    }
    
    @objc func handleDisplayLink(_ displayLink: CADisplayLink) {
        let elapsed = CACurrentMediaTime() - startTime
        shapeLayer.path = wave(at: elapsed).cgPath
    }

    private func wave(at elapsed: Double) -> UIBezierPath {
        let elapsed = CGFloat(elapsed)
        let heightY = backView.bounds.height + self.view.frame.height * 1 / 2
        let amplitude = 50 - abs(elapsed.remainder(dividingBy: 3)) * 40

        func f(_ x: CGFloat) -> CGFloat {
            return sin((x + elapsed) * 4 * .pi) * amplitude + heightY
        }

        let path = UIBezierPath()
        let steps = Int(view.bounds.width / 10)

        path.move(to: CGPoint(x: 0, y: f(0)))
        for step in 1 ... steps {
            let x = CGFloat(step) / CGFloat(steps)
            path.addLine(to: CGPoint(x: x * view.bounds.width, y: f(x)))
        }

        return path
    }
    
    
    @IBAction func onNext(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(identifier: "SecondViewController") as? SecondViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}




