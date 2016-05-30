//
//  ViewController.swift
//  CoreMotionExercise
//
//  Created by Alisa Belousova on 30/05/2016.
//  Copyright © 2016 Alisa Belousova. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    let motion: CMMotionManager = CMMotionManager()

    @IBOutlet weak var rollLabel: UILabel!
    @IBOutlet weak var pitchLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if motion.gyroAvailable {
            motion.gyroUpdateInterval = 0.5
            motion.startDeviceMotionUpdatesToQueue(.mainQueue()) {
                data, error in

                let roll: CGFloat = CGFloat((data?.attitude.roll)!)
                let pitch: CGFloat = CGFloat((data?.attitude.pitch)!)
                let yaw: CGFloat = CGFloat((data?.attitude.yaw)!)

                self.rollLabel.text = String(format: "%.2f", roll)
                self.pitchLabel.text = String(format: "%.2f", pitch)

                var rotation: CATransform3D = CATransform3DIdentity
                rotation = CATransform3DRotate(rotation, pitch - CGFloat(M_PI_2), 1, 0, 0);
                rotation = CATransform3DRotate(rotation, roll, 0, 1, 0);
                rotation = CATransform3DRotate(rotation, yaw, 0, 0, 1);

                self.avatar.layer.transform = rotation;
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}