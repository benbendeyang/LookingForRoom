//
//  UIView+Extension.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/11/28.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  UIView扩展

import UIKit
import MBProgressHUD

// MARK: - 圆角设置
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
}

// MARK: - toast扩展
extension UIView {
    
    @discardableResult
    public func showHUD(_ text: String? = nil, mode: MBProgressHUDMode = .indeterminate, animated: Bool = true) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: self, animated: animated)
        hud.label.text = text ?? ""
        hud.mode = mode
        hud.contentColor = UIColor.white
        hud.bezelView.color = UIColor.black.withAlphaComponent(0.5)
        hud.bezelView.style = .solidColor
        return hud
    }
    
    public func hideHUD(_ animated: Bool = true) {
        MBProgressHUD.hide(for: self, animated: animated)
    }
    
    func toast(_ message: String? = nil, details: String? = nil, image: UIImage? = nil, duration: TimeInterval, alpha: CGFloat = 0.8, animated: Bool = true) {
        
        let hud = MBProgressHUD.showAdded(to: self, animated: animated)
        hud.isUserInteractionEnabled = false
        
        // style
        hud.mode = .customView
        hud.customView = UIImageView(image: image)
        if let _ = image {
            hud.isSquare = true
        }
        
        hud.contentColor = UIColor.white
        hud.bezelView.color = UIColor.black.withAlphaComponent(0.5)
        hud.bezelView.style = .solidColor
        
        // data
        if  image == nil && details == nil {
            hud.detailsLabel.text = message ?? ""
            hud.detailsLabel.font = hud.label.font
        } else {
            hud.label.text = message ?? ""
            hud.detailsLabel.text = details ?? ""
        }
        
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: duration)
    }
    
    func toast(_ message: String? = nil, details: String? = nil, image: UIImage? = nil, alpha: CGFloat = 0.8, animated: Bool = true) {
        
        let actualDuration: TimeInterval = {
            
            let text = [message, details].compactMap({ $0 }).joined(separator: "")
            let unit: TimeInterval = 0.2
            let duration = unit * TimeInterval(text.count)
            
            return max(min(duration, 5.0), 1.0)
        }()
        
        toast(message, details: details, image: image, duration: actualDuration, alpha: alpha, animated: animated)
    }
    
    func toast(_ message: String) {
        toast(message, details: nil, image: nil, alpha: 0.8, animated: true)
    }
}
