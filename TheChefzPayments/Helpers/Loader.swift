//
//  Loader.swift
//  Tania
//
//  Created by mohamed-shaat on 9/18/17.
//  Copyright © 2017 ibtikar. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Loader: NSObject {
    
    static var shared = Loader()
    
    private var loaderColor = UIColor.mediumJungleGreen
    private var animationFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100))
    private var animationView: NVActivityIndicatorView
    
    override init() {
        self.animationView = NVActivityIndicatorView(frame: animationFrame, type: .ballScaleMultiple, color:loaderColor, padding: 10)
    }
    
    var heartbeatingAnimation: CAAnimationGroup = {
        
        let beatAnimation = CASpringAnimation(keyPath: "transform.scale")
        beatAnimation.duration = 0.5
        beatAnimation.fromValue = 1.0
        beatAnimation.toValue = 1.2
        beatAnimation.autoreverses = true
        beatAnimation.initialVelocity = 0.5
        beatAnimation.damping = 0.8
        
        let opacityAnimation = CASpringAnimation(keyPath: "opacity")
        opacityAnimation.duration = 0.5
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.90
        opacityAnimation.autoreverses = true
        opacityAnimation.initialVelocity = 0.5
        opacityAnimation.damping = 0.8
        
        let heartbeating = CAAnimationGroup()
        heartbeating.duration = 1.5
        heartbeating.repeatCount = 1000
        heartbeating.animations = [beatAnimation , opacityAnimation]
        
        return heartbeating
    }()
    
    func showProgress(viewController: UIViewController , userInteractionEnabled: Bool = false, type: NVActivityIndicatorType = .ballTrianglePath, width: Float = 50, height: Float = 50){
        
        if !animationView.isAnimating {
            let window: UIView = viewController.view.window ?? UIWindow()
            window.isUserInteractionEnabled = userInteractionEnabled
            animationView.type = type
            animationView.frame.size.width = CGFloat(width)
            animationView.frame.size.height = CGFloat(height)
            animationView.center = window.center
            window.addSubview(self.animationView)
            animationView.startAnimating()
        }
        
    }
    
    func hidePrgoress(viewController: UIViewController){
        
        let window: UIView = viewController.view.window ?? UIWindow()
        animationView.stopAnimating()
        animationView.removeFromSuperview()
        window.isUserInteractionEnabled = true
        
    }
    func showTopProgress(viewController: UIViewController ,userInteractionEnabled: Bool = false, type: NVActivityIndicatorType = .ballTrianglePath, width: Float = 50, height: Float = 50){
        
        if !animationView.isAnimating {
            let window: UIView = viewController.view.window ?? UIWindow()
            window.isUserInteractionEnabled = userInteractionEnabled
            animationView.type = type
            animationView.frame.size.width = CGFloat(width)
            animationView.frame.size.height = CGFloat(height)
            animationView.frame = CGRect(x: window.center.x - 20,y: 250,width: 50,height: 50)
            window.addSubview(self.animationView)
            animationView.startAnimating()
        }
        
    }
}

extension UIView {
    
    func hideAnimated( completion: (() -> Void)? = nil ) {
        
        if self.isHidden { return }
        if self.superview is UIStackView {
            UIView.animate(withDuration: 0.25, animations: {
                self.isHidden = true
            }, completion: { _ in
                completion?()
            })
            return
        }
        
        self.alpha = 1
        self.isHidden = false
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.alpha = 1
            self.isHidden = true
            completion?()
        })
    }
    
    func showupAnimated(_ completion:(() -> Void)? = nil) {
        
        if !self.isHidden { return }
        if self.superview is UIStackView {
            UIView.animate(withDuration: 0.25, animations: {
                self.isHidden = false
            }, completion: { _ in
                completion?()
            })
            return
        }
        self.alpha = 0
        self.isHidden = false
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1
        }, completion: { _ in
            completion?()
        })
    }
    
}

extension UIColor {
    class var mediumJungleGreen: UIColor {
        return UIColor(red: 36.0 / 255.0, green: 46.0 / 255.0, blue: 66.0 / 255.0, alpha: 1.0)
    }
}
