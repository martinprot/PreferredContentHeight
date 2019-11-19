//
//  ContentViewController.swift
//  PreferredContentHeight
//
//  Created by Martin Prot on 13/11/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        self.preferredContentSize = CGSize(width: 100, height: 300)
        // Do any additional setup after loading the view.
    }

    @IBAction func width150(_ sender: UIButton) {
        self.preferredContentSize = CGSize(width: 150, height: self.preferredContentSize.height)
    }
    @IBAction func width200(_ sender: UIButton) {
        self.preferredContentSize = CGSize(width: 200, height: self.preferredContentSize.height)
    }
    @IBAction func width300(_ sender: UIButton) {
        self.preferredContentSize = CGSize(width: 300, height: self.preferredContentSize.height)
    }
    @IBAction func height300(_ sender: UIButton) {
        self.preferredContentSize = CGSize(width: self.preferredContentSize.width, height: 300)
    }
    @IBAction func height400(_ sender: UIButton) {
        self.preferredContentSize = CGSize(width: self.preferredContentSize.width, height: 400)
    }
    @IBAction func height500(_ sender: UIButton) {
        self.preferredContentSize = CGSize(width: self.preferredContentSize.width, height: 500)
    }

}
