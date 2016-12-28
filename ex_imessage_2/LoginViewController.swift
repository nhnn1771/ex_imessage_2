//
//  LoginViewController.swift
//  ex_imessage_2
//
//  Created by nguyen hoang ngoc ngan on 12/26/16.
//  Copyright © 2016 nguyen hoang ngoc ngan. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //press Sign In
    
    @IBAction func userSignInButtonTapped(_ sender: Any) {
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        //check email & password
        if (userEmail != "" && userPassword != "") {
            FIRAuth.auth()?.signIn(withEmail: userEmail!, password: userPassword!, completion: { (user, error) in
                if let user = FIRAuth.auth()?.currentUser {
                    if !user.isEmailVerified{
                        let alertVC = UIAlertController(title: "Error", message: "Sorry. Your email address has not yet been verified. Do you want us to send another verification email to \(userEmail).", preferredStyle: .alert)
                        let alertActionOkay = UIAlertAction(title: "Okay", style: .default) {
                            (_) in
                            user.sendEmailVerification(completion: nil)
                        }
                        let alertActionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                        alertVC.addAction(alertActionOkay)
                        alertVC.addAction(alertActionCancel)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                }
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                else {
                    self.performSegue(withIdentifier: "signInChat", sender: nil)
                }
            })
        }
        else {
            self.displayAlertMessage ("Please to verify the email message before log in")
            return
        }
       // self.performSegue(withIdentifier: "signIn", sender: nil)
    }
//    @IBAction func userSignIn(_ sender: Any) {
//
//        //check email and pass is correct
//        
//        self.performSegue(withIdentifier: "signIn", sender: nil)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func displayAlertMessage (_ userMessage:String) {
        let myAlert = UIAlertController (title:"Alert", message:userMessage,preferredStyle:UIAlertControllerStyle.alert)
        let okAction = UIAlertAction (title:"OK", style:UIAlertActionStyle.default,handler:nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert,animated:true,completion:nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let navVc = segue.destination as! UINavigationController // 1
        let channelVc = navVc.viewControllers.first as! ChannelListTableViewController // 2
        
        channelVc.senderDisplayName = userEmailTextField?.text // 3
    }
}
