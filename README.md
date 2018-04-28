# StarsView
这是一个简单的封装等级中加星星减星星动画的view.

1.支持自定义星星总数，当前显示星星数，每一次增加和减少星星个数，每一行显示星星个数；
2.星星的大小是根据父view的大小计算得来的
3.支持自定义星星图片

使用：

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


如果要自定义图片的话，只需要把亮星星命名成 starlight ，把暗星星命名成 stardark就可以了。

![Alt text](https://github.com/weiman152/StarsView/tree/master/ScreenShots/img.gif)


