//
//  CanvasViewController.swift
//  Canvas
//
//  Created by SongYuda on 4/12/17.
//  Copyright © 2017 SongYuda. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    
    var newlyCreatedFaceOriginalCenter: CGPoint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayDownOffset = 160
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + trayDownOffset)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        var velocity = sender.velocity(in: view)
        
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
        }
        
        if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        }
        
        if sender.state == .ended {
            if(velocity.y < 0) {
                UIView.animate(withDuration: 0.4, animations: { 
                    self.trayView.center.y = self.trayUp.y
                })
            }
            if(velocity.y > 0) {
                UIView.animate(withDuration: 0.4, animations: {
                    self.trayView.center.y = self.trayDown.y
                })
            }
        }
        
        
        
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            var imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            let pan = UIPanGestureRecognizer(target: self, action: #selector(panning(_:)))
            newlyCreatedFace.addGestureRecognizer(pan)
            
            UIView.animate(withDuration: 0.1, animations: { 
                self.newlyCreatedFace.transform = self.newlyCreatedFace.transform.scaledBy(x: 2, y: 2)
            })
        }
        
        if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        
        if sender.state == .ended {
            UIView.animate(withDuration: 0.1, animations: {
                self.newlyCreatedFace.transform = self.newlyCreatedFace.transform.scaledBy(x: 0.5, y: 0.5)
            })

        }
    }
    
    func panning(_ sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            newlyCreatedFaceOriginalCenter = sender.view?.center
            UIView.animate(withDuration: 0.1, animations: {
               sender.view?.transform = (sender.view?.transform.scaledBy(x: 2, y: 2))!
            })
        }
        
        if sender.state == .changed {
            sender.view?.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y:newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        
        if sender.state == .ended {
            UIView.animate(withDuration: 0.1, animations: {
                sender.view?.transform = (sender.view?.transform.scaledBy(x: 0.5, y: 0.5))!
            })
        }
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
