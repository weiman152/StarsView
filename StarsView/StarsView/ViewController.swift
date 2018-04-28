//
//  ViewController.swift
//  StarsView
//
//  Created by iOS on 2018/4/27.
//  Copyright © 2018年 weiman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var starsView: StarsView!
    @IBOutlet weak var starsView2: StarsView!
    @IBOutlet weak var starsView3: StarsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        set()
    }
    
    private func set() {
        starsView.setup(totalStars: 8, currentStars: 4, eachRowStars: 5)
        starsView2.setup(totalStars: 10, currentStars: 3, eachRowStars: 5)
        starsView3.setup(totalStars: 14, currentStars: 2, eachRowStars: 4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reSet(_ sender: UIButton) {
        set()
    }

    @IBAction func addStar(_ sender: UIButton) {
        starsView.addStarAnimation(changeStar: 1)
        starsView2.addStarAnimation(changeStar: 1)
        starsView3.addStarAnimation(changeStar: 2)
    }
    
    
    @IBAction func jianStar(_ sender: UIButton) {
        starsView.reduceStarAnimation(changeStar: 1)
        starsView2.reduceStarAnimation(changeStar: 1)
        starsView3.reduceStarAnimation(changeStar: 2)
    }
    
    
}

