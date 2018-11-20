//
//  UserListViewController.swift
//  Verifica_Luca_Bonin
//
//  Created by Leo Luca Bonin on 20/11/2018.
//  Copyright © 2018 developer.llb. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    var userList : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.getUsers(completion: { users, success in
            if success {
                
//                self.userList = User.allSavedUser()
                self.userList = users
                for user in self.userList {
                    user.save()
                }
            }
            else {
                self.userList = User.allSavedUser()
            }
            
            self.tabelView.reloadData()
                
        })
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        NetworkManager.logout(completion: { success in
            if success {
                self.dismiss(animated: true, completion: {
                    GeneralUtils.share.reloadGenericViewController(storyboard: R.storyboard.main(), inViewController: self)
                })
                
            }
        })
    }
}

extension UserListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userCell, for: indexPath) as! UserCell
        
        cell.setup(user: userList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
