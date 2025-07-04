//
//  ShareViewController.swift
//  ShareNewsToNewsSaver
//
//  Created by 中村健介 on 2025/06/07.
//

import SwiftUI

class ShareViewController: UIHostingController<ShareView> {
    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: ShareView(context: nil))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView = ShareView(context: extensionContext)
    }
}
