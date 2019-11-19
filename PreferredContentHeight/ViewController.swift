//
//  ViewController.swift
//  PreferredContentHeight
//
//  Created by Martin Prot on 13/11/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func open(_ sender: UIButton) {
        let viewController = ContentViewController()
        let nav = UINavigationController(rootViewController: viewController)
        nav.isNavigationBarHidden = true
        let popup = PopupViewController(embeddedController: nav)
        self.present(popup, animated: true, completion: nil)
    }

    @IBAction func openCustom(_ sender: UIButton) {
        let viewController = ContentViewController()
        let nav = WorkingNavigationController(rootViewController: viewController)
        nav.isNavigationBarHidden = true
        let popup = PopupViewController(embeddedController: nav)
        self.present(popup, animated: true, completion: nil)
    }

}

/// Seems to be a bug in UINavigationController's preferredContentSizeDidChange implementation:
/// it never decrease its height. Using a custom one to fix the problem
fileprivate class WorkingNavigationController: UINavigationController {
    override public func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        if self.navigationBar.isHidden {
            self.preferredContentSize = container.preferredContentSize
        }
        else {
            var size = container.preferredContentSize
            size.height += self.navigationBar.bounds.height
            self.preferredContentSize = size
        }
    }
}
