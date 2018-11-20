//
//  GeneralUtils.swift
//  Verifica_Luca_Bonin
//
//  Created by Leo Luca Bonin on 20/11/2018.
//  Copyright © 2018 developer.llb. All rights reserved.
//

import UIKit

class GeneralUtils: NSObject {
    
    static let share = GeneralUtils()
    
    func alertError(title: String?, message: String?, closeAction: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Error", style: .default, handler: { action in
            closeAction()
        })
        alert.addAction(ok)
        return alert
    }
    
    func reloadGenericViewController(storyboard : UIStoryboard, inViewController viewController : UIViewController) {
        guard let setViewController = storyboard.instantiateInitialViewController() else { return }
        viewController.present(setViewController, animated: true, completion: nil)
    }
}
