//
//  StarsView.swift
//  StarsView
//
//  Created by iOS on 2018/4/27.
//  Copyright © 2018年 weiman. All rights reserved.
//

import UIKit

class StarsView: UIView {
    
    // 设置星星的初始值，最后显示大小是根据父view的宽高计算的
    private var starWidth: CGFloat = 16
    private var starHeight: CGFloat = 16
    
    private var totalStar: Int = 0
    private var currentStar: Int = 0
    private var fullView = UIView()
    private var lastRowView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// 设置星星数
    ///
    /// - Parameters:
    ///   - totalStars: 星星总数
    ///   - currentStars: 当前显示星星数
    ///   - eachRowStars: 每一行显示星星个数
    func setup(totalStars: Int, currentStars: Int, eachRowStars: Int) {
        
        self.totalStar = totalStars
        self.currentStar = currentStars
        
        let arguments = calculateArgument(totalStars: totalStars,
                                          eachRowStars: eachRowStars)
        
        fullView = addFullView(arguments: arguments,
                                   eachRowStars: eachRowStars)
        addSubview(fullView)
        
        // 最后一行
        lastRowView = addLastRowView(arguments: arguments,
                                     eachRowStars: eachRowStars)
        let tempY = lastRowView.center.y
        lastRowView.center = CGPoint.init(x: fullView.center.x, y: tempY)
        addSubview(lastRowView)
        
        // 设置亮星星
        setLightStar(currentStar: currentStars, view: fullView)
        setLightStar(currentStar: currentStars, view: lastRowView)
    }
    
    func addStarAnimation(changeStar: Int) {
        
        guard currentStar + changeStar <= totalStar else {
            return
        }
        
        if totalStar - (currentStar + changeStar) >= lastRowView.subviews.count {
            fullView.subviews.forEach { (view) in
                guard let button = view as? UIButton else {
                    return
                }
                changeStarAdd(button: button, changeStar: changeStar)
                
            }
        } else {
            lastRowView.subviews.forEach { (view) in
                guard let button = view as? UIButton else {
                    return
                }
                changeStarAdd(button: button, changeStar: changeStar)
            }
        }
        
        currentStar = currentStar + changeStar
    }
    
    func reduceStarAnimation(changeStar: Int) {
        
        guard currentStar - changeStar >= 0 else {
            return
        }
        
        if totalStar - (currentStar - changeStar) > lastRowView.subviews.count {
            fullView.subviews.forEach { (view) in
                guard let button = view as? UIButton else {
                    return
                }
                changeStarReduce(button: button, changeStar: changeStar)
                
            }
        } else {
            lastRowView.subviews.forEach { (view) in
                guard let button = view as? UIButton else {
                    return
                }
                changeStarReduce(button: button, changeStar: changeStar)
            }
        }
        
        currentStar = currentStar - changeStar
    }
    

}

/// 添加子view
extension StarsView {
    
    /// 计算需要的参数
    ///
    /// - Parameters:
    ///   - totalStars: 星星总数
    ///   - eachRowStars: 每一行显示星星数
    /// - Returns: （能够整行显示的行数，最后一行的星星数）
    private func calculateArgument(
        totalStars: Int,
        eachRowStars: Int) -> (rows: Int, lastRowNum: Int) {
        // 计算能够整行显示的行数
        let rows = totalStars / eachRowStars
        // 计算整行显示后，最后一行剩余星星数
        let lastRowNum = totalStars % eachRowStars
        
        // 计算一颗星星所占的宽
        starWidth = bounds.size.width / CGFloat(eachRowStars)
        if lastRowNum > 0 {
            starHeight = bounds.size.height / CGFloat((rows+1))
        } else {
            starHeight = bounds.size.height / CGFloat(rows)
        }
        return (rows,lastRowNum)
    }
    
    /// 添加整行的view
    ///
    /// - Parameters:
    ///   - arguments: 参数
    ///   - eachRowStars: 每一行的星星数
    /// - Returns: 整行view
    private func addFullView(
        arguments: (rows: Int, lastRowNum: Int),
        eachRowStars: Int) -> UIView {
        let fullView = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: bounds.size.width,
                                            height: bounds.size.height-starHeight))
        addStars(superV: fullView,
                 starsNum: arguments.rows * eachRowStars,
                 eachRowStars: eachRowStars,
                 tagStarNum: 0)
        
        
        return fullView
    }
    
    /// 添加最后一行的view
    ///
    /// - Parameter arguments: 参数
    /// - Returns: 最后一行的view
    private func addLastRowView(
        arguments: (rows: Int, lastRowNum: Int),
        eachRowStars: Int) -> UIView {
        let lastRowViewX: CGFloat = 0
        let lastRowViewY = bounds.size.height-starHeight
        let lastRowViewWidth = CGFloat(arguments.lastRowNum) * starWidth
        let lastRowViewHeight = starHeight
        
        let lastRowView = UIView(frame: CGRect(x: lastRowViewX,
                                               y: lastRowViewY,
                                               width: lastRowViewWidth,
                                               height: lastRowViewHeight))
        
        addStars(superV: lastRowView,
                 starsNum: arguments.lastRowNum,
                 eachRowStars: arguments.lastRowNum,
                 tagStarNum: arguments.rows * eachRowStars)
        
        return lastRowView
    }
    
    /// 添加星星
    ///
    /// - Parameters:
    ///   - superV: 要添加星星的view
    ///   - starsNum: 星星总数量
    ///   - eachRowStars: 每一行星星的数量
    private func addStars(superV: UIView,
                          starsNum: Int,
                          eachRowStars: Int,
                          tagStarNum: Int) {
        for i in 0..<starsNum {
            
            let row: CGFloat = CGFloat(i / eachRowStars)
            let col: CGFloat = CGFloat(i % eachRowStars)
            
            let button = UIButton(type: .custom)
            superV.addSubview(button)
            button.tag = i+1 + tagStarNum

            let X: CGFloat = col * starWidth
            let Y: CGFloat = row * starHeight
            button.frame = CGRect(x: X, y: Y, width: starWidth, height: starHeight)
            button.setImage(#imageLiteral(resourceName: "battles_single_star_purple"), for: .normal)
            button.setImage(#imageLiteral(resourceName: "battles_single_star_yellow"), for: .selected)
        }
    }
}

/// 设置星星
extension StarsView {
    
    private func setLightStar(currentStar: Int, view: UIView) {
        
        view.subviews.forEach { (view) in
            guard let button = view as? UIButton else {
                return
            }
            button.isSelected = button.tag <= currentStar ? true : false
        }
    }
}

/// 动画
extension StarsView {
    
    private func changeStarAdd(button: UIButton, changeStar: Int) {
        for i in 1...changeStar {
            let tag = currentStar + i
            if button.tag == tag {
                starAddAnimation(button: button)
            }
        }
    }
    
    private func changeStarReduce(button: UIButton, changeStar: Int) {
        for i in 0..<changeStar {
            let tag = currentStar - i
            if button.tag == tag {
                starReduceAnimation(button: button)
            }
        }
    }
    
    /// 星星增加动画
    private func starAddAnimation(button: UIButton) {
        guard let superview = button.superview else {
            return
        }
        
        let animationButton = UIButton(type: .custom)
        superview.addSubview(animationButton)
        animationButton.frame = button.frame
        animationButton.setImage(#imageLiteral(resourceName: "battles_single_star_yellow"), for: .normal)
        
        // 暗星星先放大
        let transformPurple = CGAffineTransform(scaleX: 1.5, y: 1.5)
        UIView.animate(withDuration: 0.16, animations: {
            button.transform = transformPurple
        })
        UIView.animate(withDuration: 0.16, delay: 0.1, animations: {
            button.transform = .identity
        })
        
        // 动画按钮缩小
        let transformSmall = CGAffineTransform(scaleX: 0.01, y: 0.01)
        animationButton.transform = transformSmall
        
        // 动画按钮变大
        let transform = CGAffineTransform(scaleX: 2, y: 2)
        
        UIView.animate(withDuration: 0.4, animations: {
            animationButton.transform = transform
        })
        UIView.animate(withDuration: 0.4, delay: 0.25, animations: {
            animationButton.transform = .identity
        }) { _ in
            button.isSelected = true
            //移除动画按钮
            animationButton.removeFromSuperview()
        }
    }
    
    /// 星星减少的动画
    private func starReduceAnimation(button: UIButton) {
        guard let superview = button.superview else {
            return
        }
        
        button.isSelected = false
        
        let animationButton = UIButton(type: .custom)
        superview.addSubview(animationButton)
        animationButton.frame = button.frame
        animationButton.setImage(#imageLiteral(resourceName: "battles_single_star_yellow"), for: .normal)
        
        // 黄色星星变大
        UIView.animate(withDuration: 0.16, animations: {
            animationButton.transform = CGAffineTransform(scaleX: 2, y: 2)
        })
        UIView.animate(withDuration: 0.25, delay: 0.1, animations: {
            animationButton.transform = .identity
        })
        
        // 黄色星星变小至消失
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            animationButton.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }) { _ in
            animationButton.removeFromSuperview()
        }
        
        // 紫色星星放大
        UIView.animate(withDuration: 0.75, animations: {
            button.transform = CGAffineTransform(scaleX: 2, y: 2)
        })
        
        // 紫色星星恢复原状
        UIView.animate(withDuration: 0.75, delay: 0.1, animations: {
            button.transform = .identity
        })
    }
    
    
}










