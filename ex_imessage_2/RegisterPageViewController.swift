//
//  RegisterPageViewController.swift
//  ex_imessage_2
//
//  Created by nguyen hoang ngoc ngan on 12/24/16.
//  Copyright © 2016 nguyen hoang ngoc ngan. All rights reserved.
//

import UIKit
import Firebase
class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    
    
    @IBOutlet weak var userPasswordTestField: UITextField!
    //@IBOutlet weak var userPasswordTestField: UITextField!
    @IBOutlet weak var userRepeatedPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func userRegisterButtonTapped(_ sender: Any) {
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTestField.text
        let userRepeatedPassword = userRepeatedPasswordTextField.text
        
        //check for empty field
        if (userEmail!.isEmpty || userPassword!.isEmpty || userRepeatedPassword!.isEmpty) {
            displayAlertMessage ("All field are required")
            return
        }
        //check if password match
        if (userPassword != userRepeatedPassword) {
            displayAlertMessage ("Passwords do not match")
            return
        }
        //store data (pass and user)
        FIRAuth.auth()?.createUser(withEmail: userEmail!, password: userPassword!) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            //send Email verification if no error
            FIRAuth.auth()?.currentUser!.sendEmailVerification(completion: { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            })
            //send a message to annouce completing register new account
            let myAlert = UIAlertController (title:"Alert", message:"Register is successfull, Please verify your account in your email",preferredStyle:UIAlertControllerStyle.alert)
            let okAction = UIAlertAction (title:"OK", style:UIAlertActionStyle.default) {action in
                self.dismiss(animated: true, completion: {})
            }
            
            myAlert.addAction(okAction)
            self.present(myAlert,animated:true,completion:nil)
        }
    }

    func displayAlertMessage (_ userMessage:String) {
        let myAlert = UIAlertController (title:"Alert", message:userMessage,preferredStyle:UIAlertControllerStyle.alert)
        let okAction = UIAlertAction (title:"OK", style:UIAlertActionStyle.default,handler:nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert,animated:true,completion:nil)
    }


}
