//
//  ViewController.swift
//  moveCircleTheScreen
//
//  Created by Даниэл Лабецкий on 1.07.22.
//

import UIKit

class ViewController: UIViewController {
    
    let viewCircle: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.layer.cornerRadius = view.frame.width / 2
        view.backgroundColor = .orange
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCircle.center = view.center
        view.addSubview(viewCircle)
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveCircle(_:)))
        viewCircle.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func moveCircle(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == UIGestureRecognizer.State.ended {
            let velocity = recognizer.velocity(in: self.view)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 200
            let slideFactor = 0.1 * slideMultiplier
            var finalPoint = CGPoint(x:recognizer.view!.center.x + (velocity.x * slideFactor),
                                     y:recognizer.view!.center.y + (velocity.y * slideFactor))
            finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
            finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
        }
    }
}

