//
//  PopupController.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/12/4.
//  Copyright © 2018 Zhu. All rights reserved.
//

import UIKit

protocol PopupControllerDelegate: class {
    func popuoControllerDismiss()
}

class PopupContentView: UIView {
    weak var delegate: PopupControllerDelegate?
}

class PopupController: BaseViewController {
    
    var contentView: PopupContentView
    /// 浏览模式：点击背景关闭视图
    var isBrowseMode: Bool = true
    
    init(contentView: PopupContentView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
        self.contentView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func pop(on presentController: UIViewController, contentView: PopupContentView, browseMode: Bool = true) {
        let popupController = PopupController(contentView: contentView)
        popupController.modalPresentationStyle = .custom
        popupController.isBrowseMode = browseMode
        presentController.present(popupController, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        }
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 8, animations: {
            self.contentView.center = self.view.center
        })
    }
}

// MARK: - 私有方法
private extension PopupController {
    /// 初始化
    private func initController() {
        view.backgroundColor = UIColor(white: 0, alpha: 0)
        
        let backgroundButton = UIButton(frame: UIScreen.main.bounds)
        backgroundButton.backgroundColor = .clear
        backgroundButton.addTarget(self, action: #selector(clickBackground), for: .touchUpInside)
        view.addSubview(backgroundButton)
        
        var contentStarCenter = view.center
        contentStarCenter.y += UIScreenHeight/2
        contentView.center = contentStarCenter
        view.addSubview(contentView)
    }
    
    @objc func clickBackground() {
        if isBrowseMode {
            popuoControllerDismiss()
        }
    }
}

// MARK: - 协议
extension PopupController: PopupControllerDelegate {
    
    func popuoControllerDismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = UIColor(white: 0, alpha: 0)
            self.contentView.center.y += UIScreenHeight
        }) { [weak self] _ in
            self?.dismiss(animated: false)
        }
    }
}
