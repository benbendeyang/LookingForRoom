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
}
