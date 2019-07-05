//
//  ViewController.swift
//  GuaGuaLeDemo
//
//  Created by 谢伟 on 2019/7/5.
//  Copyright © 2019 谢伟. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.image = UIImage(named: "gray")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        // 下面的图片
        let belowImg = UIImage(named: "ten")
        let belowImgView = UIImageView(image: belowImg)
        belowImgView.frame = CGRect(x: 0, y: 0, width: belowImg?.size.width ?? 0, height: belowImg?.size.height ?? 0)
        belowImgView.center = view.center
        view.addSubview(belowImgView)
        
        // 灰色图片
        imageView.frame = belowImgView.frame
        view.addSubview(imageView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        // 触摸位置在图片上的坐标
        let cententPoint = touch?.location(in: imageView) ?? CGPoint.zero
        // 设置清除点的大小
        let rect = CGRect(x: cententPoint.x, y: cententPoint.y, width: 30.0, height: 30.0)
        // 默认是去创建一个透明的视图
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0)
        // 获取上下文(画板)
        guard let ref = UIGraphicsGetCurrentContext() else {
            return
        }
        // 把imageView的layer映射到上下文中
        imageView.layer.render(in: ref)
        
        // 清除划过的区域
        ref.clear(rect)
        
        // 获取图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 结束图片的画板, (意味着图片在上下文中消失)
        UIGraphicsEndImageContext()
        imageView.image = image
    }
}

