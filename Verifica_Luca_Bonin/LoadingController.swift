//
//  LoadingController.swift
//  Verifica_Luca_Bonin
//
//  Created by Leo Luca Bonin on 20/11/2018.
//  Copyright © 2018 developer.llb. All rights reserved.
//

import UIKit

class LoadingController: UIViewController {

    override func viewDidAppear(_ animated: Bool)
     {
        super.viewDidAppear(animated)
        NetworkManager.checkLoggedUser(completion: { success in
            if success {
                self.performSegue(withIdentifier: R.segue.loadingController.toMainSegue, sender: self)
            } else {
                self.performSegue(withIdentifier: R.segue.loadingController.loginSegue, sender: self)
            }
        })

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
