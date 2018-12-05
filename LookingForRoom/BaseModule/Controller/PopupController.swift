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
    
    init(contentView: PopupContentView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
        self.contentView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func pop(on presentController: UIViewController, contentView: PopupContentView) {
        let popupController = PopupController(contentView: contentView)
        popupController.modalPresentationStyle = .custom
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
    }
}

// MARK: - 私有方法
private extension PopupController {
    /// 初始化
    private func initController() {
        view.backgroundColor = UIColor(white: 0, alpha: 0)
        
        let backgroundButton = UIButton(frame: UIScreen.main.bounds)
        backgroundButton.backgroundColor = .clear
        backgroundButton.addTarget(self, action: #selector(popuoControllerDismiss), for: .touchUpInside)
        view.addSubview(backgroundButton)
        
        view.addSubview(contentView)
    }
}

// MARK: - 协议
extension PopupController: PopupControllerDelegate {
    
    @objc func popuoControllerDismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = UIColor(white: 0, alpha: 0)
        }) { [weak self] _ in
            self?.dismiss(animated: false)
        }
    }
}
