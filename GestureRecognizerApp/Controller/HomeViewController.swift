//
//  ViewController.swift
//  GestureRecognizerApp
//
//  Created by Azzam R Alrashed on 13/12/2020.
//

import UIKit

enum SwipeDirection {
    case right
    case left
    case up
    case down
}

class HomeViewController: UIViewController {

    @IBOutlet weak var FrontImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var likeIcon: UIImageView!
    var posts = [#imageLiteral(resourceName: "image3"),#imageLiteral(resourceName: "image5"),#imageLiteral(resourceName: "image1"),#imageLiteral(resourceName: "image2"),#imageLiteral(resourceName: "image4"),#imageLiteral(resourceName: "image6")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupViews()
    }
    
    func setupViews() {
        
        FrontImage.image = posts[0]
        backImage.image = posts[1]
        
        FrontImage.layer.cornerRadius = 10
        backImage.layer.cornerRadius = 10
        fingerTrackerView.layer.cornerRadius = fingerTrackerView.frame.width / 2
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
        
    }
    

    
    // MARK: home content
    
    @IBAction func didDoubleTap(_ sender: Any) {
        let likeIconOriginalSize = likeIcon.frame.size
        let likeIconOriginalPoint = likeIcon.center
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
            self.likeIcon.alpha = 0.8
            self.likeIcon.frame.size = CGSize(width: 200, height: 200)
            self.likeIcon.center = likeIconOriginalPoint
        } completion: { (_) in
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
                self.likeIcon.alpha = 0
                self.likeIcon.frame.size = likeIconOriginalSize
                self.likeIcon.center = likeIconOriginalPoint
            } completion: { (_) in
                //user did like the photo
            }
        }
    }
    
    @IBAction func didSwipeRight(_ sender: Any) {
        showNewImageAnimation(swipe: .right)
    }
    
    @IBAction func didSwipeLeft(_ sender: Any) {
        showNewImageAnimation(swipe: .left)
    }
    
    @IBAction func didSwipeUp(_ sender: Any) {
        showNewImageAnimation(swipe: .up)
    }
    @IBAction func didSwipeDown(_ sender: Any) {
        showNewImageAnimation(swipe: .down)
    }
    
    var postIndex = 2
    func showNewImageAnimation(swipe: SwipeDirection) {
        let backimageOriginalSize = backImage.frame.size
        let backimageOriginalPoint = backImage.center
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            self.FrontImage.transform = CGAffineTransform.identity.rotated(by: .pi )
            switch swipe {
            case .right: self.FrontImage.center = CGPoint(x: self.view.frame.maxX * 1.5, y: self.view.frame.midY - 200)
            case .left: self.FrontImage.center = CGPoint(x: -self.view.frame.maxX * 1.5, y: self.view.frame.midY - 200)
            case .up: self.FrontImage.center = CGPoint(x: self.view.frame.midX , y: -self.view.frame.maxY * 1.5)
            case .down: self.FrontImage.center = CGPoint(x: self.view.frame.midX , y: self.view.frame.maxY * 1.5)
            }
            self.backImage.frame.size = self.FrontImage.frame.size
            self.backImage.center = self.view.center
        } completion: { (_) in
            self.FrontImage.transform = CGAffineTransform.identity
            self.FrontImage.image = self.backImage.image
            
            if self.postIndex < self.posts.count {
            self.backImage.image = self.posts[self.postIndex]
            self.postIndex += 1
            } else {
                self.backImage.image = nil
            }
            
            self.FrontImage.center = self.view.center
            self.backImage.frame.size = backimageOriginalSize
            self.backImage.center = backimageOriginalPoint
            
        }
    }

    
    @IBAction func didZoomGesture(_ sender: UIPinchGestureRecognizer) {
        let imageWidth = sender.scale * FrontImage.frame.width
        switch sender.state {
        case .began, .changed:
            if imageWidth >= backImage.frame.width  {
                FrontImage.transform = FrontImage.transform.scaledBy(x: sender.scale, y: sender.scale)
            }
            sender.scale = 1
        case .ended:
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
                self.FrontImage.transform = CGAffineTransform.identity
            }

        default:
            print("error")
        }
        
    }
    
    
    @IBAction func didLongPress(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
                self.FrontImage.transform = CGAffineTransform.identity.rotated(by: .pi )
            }
        case .ended:
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
                self.FrontImage.transform = CGAffineTransform.identity
            }

        default:
            print("error")
        }
    }
    
    
    // MARK: home button
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var fingerTrackerView: UIView!
    @IBOutlet weak var navigationViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet var navigationImages: [UIImageView]!
    
    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: navigationView)
        let navigationViewOriginalCenterPoint = navigationView.center
        
        switch sender.state {
        case .began, .changed:
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
                self.fingerTrackerView.alpha = 0.7
                self.navigationViewWidthConstraint.constant = 200
                self.navigationView.layer.cornerRadius = self.navigationViewWidthConstraint.constant / 2
                self.navigationView.center = navigationViewOriginalCenterPoint
                self.view.layoutIfNeeded()
            }
            fingerTrackerView.center = CGPoint(x: fingerTrackerView.center.x + translation.x, y: fingerTrackerView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: navigationView)
        case .ended:
            
            if fingerTrackerView.frame.intersects(navigationImages[0].frame) {
                print("presint the profile view Controller")
                navigationImages[0].alpha = 1
                navigationImages[1].alpha = 0.5
                navigationImages[2].alpha = 0.5
            } else if fingerTrackerView.frame.intersects(navigationImages[1].frame) {
                print("presint the chat view Controller")
                navigationImages[0].alpha = 0.5
                navigationImages[1].alpha = 1
                navigationImages[2].alpha = 0.5
            } else if fingerTrackerView.frame.intersects(navigationImages[2].frame) {
                print("presint the explore view Controller")
                print("what ?")
                navigationImages[0].alpha = 0.5
                navigationImages[1].alpha = 0.5
                navigationImages[2].alpha = 1
            }
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
                self.fingerTrackerView.alpha = 0
                self.navigationViewWidthConstraint.constant = 10
                self.navigationView.layer.cornerRadius = self.navigationViewWidthConstraint.constant / 2
                self.navigationView.center = navigationViewOriginalCenterPoint
                self.view.layoutIfNeeded()
            }
        default:
            break
        }
    }
    
    
    func setGradientBackground() {
        let colorTop =  #colorLiteral(red: 0.2274509804, green: 0.5490196078, blue: 0.8352941176, alpha: 1).cgColor
        let colorBottom = #colorLiteral(red: 0, green: 0.8235294118, blue: 1, alpha: 1).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
        
    }
    
}


