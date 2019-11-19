//
//  PopupViewController.swift
//  Chanel TRY ON
//
//  Created by Martin Prot on 16/10/2019.
//  Copyright © 2019 Pictime. All rights reserved.
//

import UIKit

public class PopupViewController: UIViewController {

    private let embeddedController: UIViewController
    private let blackView: UIView
    private let containerView: UIView
	private let quitCallback: (() -> Void)?

	public init(embeddedController: UIViewController, onQuit: (() -> Void)? = .none) {
        self.embeddedController = embeddedController
        self.blackView = UIView()
        self.containerView = UIView()
		self.quitCallback = onQuit
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.blackView)
        self.blackView.frame = self.view.bounds
        self.blackView.backgroundColor = UIColor.black.withAlphaComponent(0.8) // TODO: Constants
        self.blackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.updateContainerSize(animated: false)
        self.view.addSubview(self.containerView)
        self.containerView.backgroundColor = .white
        self.containerView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        self.embed(viewController: self.embeddedController, in: self.containerView)
		
		// closing stuff
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onQuit(_:)))
		self.blackView.addGestureRecognizer(tapGesture)

		let closeButton = UIButton()
		closeButton.tintColor = .white
		closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(closeButton)
        let contraints: [NSLayoutConstraint] = [closeButton.leadingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: 0),
                                                closeButton.bottomAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 0),
                                                closeButton.widthAnchor.constraint(equalToConstant: 40),
                                                closeButton.heightAnchor.constraint(equalToConstant: 40)]  // TODO: Constants
        contraints.forEach { $0.isActive = true }
        closeButton.setTitle("ⓧ", for: .normal)
        closeButton.addTarget(self, action: #selector(onQuit(_:)), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateContainerSize(animated: Bool) {
        let size = embeddedController.preferredContentSize
        UIView.animate(withDuration: animated ? 0.2 : 0, delay: 0, options: .curveEaseOut, animations: {
            self.containerView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            self.containerView.center = self.blackView.center
			self.view.layoutIfNeeded()
        })
    }

    override public func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        self.updateContainerSize(animated: true)
    }

	@objc func onQuit(_ sender: Any) {
		if let quit = self.quitCallback {
			quit()
		}
		else {
			self.dismiss(animated: true, completion: nil)
		}
	}
}

fileprivate extension UIViewController {

    /// Embed the given view controller to sender, in the given view. The view in parameter must be a descendent
    /// of the sender main view. The view controller takes the given view bounds as frame, and automatically
    /// resizes its width and height
    func embed(viewController: UIViewController?, in view: UIView?) {
        guard let view = view, let viewController = viewController else { return }
        viewController.willMove(toParent: self)
        self.addChild(viewController)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
}

class CustomNavigationController: UINavigationController {
    override public func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        print("NAV UPDATING CONTENT SIZE")
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
