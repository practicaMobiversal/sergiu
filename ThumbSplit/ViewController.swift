//
//  ViewController.swift
//  ThumbSplit
//
//  Created by Sierra on 9/25/17.
//  Copyright © 2017 Sierra. All rights reserved.
//

import UIKit
import Alamofire
import Unbox

class ViewController: UIViewController {
    
    @IBOutlet weak var emaiLoginField: UIView!
    
    @IBOutlet weak var passwordLoginView: UIView!
    
    @IBOutlet weak var passwordLogin: UITextField!
    
    @IBOutlet weak var emailLoginTextField: UITextField!
    
    let URL_USER_REGISTER = "http://52.14.245.160:4096/login"
    
    //class URLRegister:URLRequestConvertible{
      //  func asURLRequest() throws -> URLRequest {
        //    return  URL(string: "http://52.14.245.160:4096/login")!
        //}
    //}
    
    
    class URLRegister:URLConvertible{
        func asURL() throws -> URL {
            return  URL(string: "http://52.14.245.160:4096/login")!
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        		super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
   
    @IBAction func loginButton(_ sender: Any) {
        
        let parameters: Parameters=[
            "email": emailLoginTextField.text ?? "",
            "password": passwordLogin.text ?? ""]
        
        Alamofire.request(URLRegister(), method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseData { (response) in
            
                switch response.result {
                        case .success:
                            print("Validation Successful")
                    
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            
                            
                            
                            let registerResponse: RegisterResponse = try! unbox(data: response.data!)
                            
                            
                            
                    
                            let loginController = storyboard.instantiateViewController(withIdentifier: "MessageController") as! MessageViewController
                    
                            loginController.jwt = registerResponse.jwt
                    
                            self.navigationController?.pushViewController(loginController, animated: true)
                    
                        case .failure(let error):
                            print(error)
                        }
                }
        
        
        }
    
}
struct RegisterResponse {
    let jwt: String
}

extension RegisterResponse: Unboxable {
    init(unboxer: Unboxer) throws {
        
        self.jwt = try unboxer.unbox(key: "jwt")
    }
}


