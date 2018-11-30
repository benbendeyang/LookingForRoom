//
//  String+Extension.swift
//  Pastime
//
//  Created by 🐑 on 2018/11/27.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  String扩展

import Foundation
import UIKit

extension String {
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
    
    /// 使用正则表达式替换
    func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
    
    /// 是否为空
    func isBlank() -> Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

// MARK: - 字符串宽度计算
extension String {
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintedSize = CGSize(width: width, height: 999)
        let size = (self as NSString).boundingRect(with: constraintedSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return size.height.aligned
    }

    func width(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintedSize = CGSize(width: 999, height: height)
        let size = (self as NSString).boundingRect(with: constraintedSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return size.width.aligned
    }

    func height(_ width: CGFloat, fontSize: CGFloat) -> CGFloat {
        return self.height(width: width, font: UIFont.systemFont(ofSize: fontSize))
    }

    func height(_ width: CGFloat, boldFontSize: CGFloat) -> CGFloat {
        return self.height(width: width, font: UIFont.boldSystemFont(ofSize: boldFontSize))
    }

    func heightInPaddingToScreen(_ paddingToLeftOrRight: CGFloat, fontSize: CGFloat) -> CGFloat {
        return self.height(width: UIScreen.main.bounds.width - 2 * paddingToLeftOrRight, font: UIFont.systemFont(ofSize: fontSize))
    }

    func heightInTotalHorizontalPaddingToScreen(_ totalPadding: CGFloat, fontSize: CGFloat) -> CGFloat {
        return self.height(width: UIScreen.main.bounds.width - totalPadding, font: UIFont.systemFont(ofSize: fontSize))
    }

    func width(fontSize: CGFloat) -> CGFloat {
        return self.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width.aligned
    }

    func size(maxWidth: CGFloat, maxHeight: CGFloat, fontSize: CGFloat) -> CGSize {
        let constraintedSize = CGSize(width: maxWidth, height: maxHeight)
        var rect = self.boundingRect(with: constraintedSize, options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)], context: nil)
        rect.size.height = rect.size.height.aligned
        rect.size.width = rect.size.width.aligned
        return rect.size
    }
}
