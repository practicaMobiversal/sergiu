//
//  RegisterViewController.swift
//  ThumbSplit
//
//  Created by Sierra on 9/26/17.
//  Copyright © 2017 Sierra. All rights reserved.
//

import UIKit
import Alamofire

struct What {
    var title: String
    var image: UIImage
}

class RegisterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TableView: UITableView!
    
    let fields = ["Username", "FullName", "Email", "Password", "RepeatPassword"]
    let images = [UIImage(named:"icUsername"), UIImage(named:"icFullName"), UIImage(named: "icEmail"), UIImage(named:"icPassword"), UIImage(named:"icRepeatPassword")]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //func populateModels() {
        //let firstModel = What(title: <#T##String#>, image: )
    
    //}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (fields.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
    
        
        
        cell.registerField.placeholder = fields[indexPath.row]
        cell.icPassword.image = images[indexPath.row]
        
        cell.registrationViews.layer.borderWidth = 0.5
        cell.registrationViews.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
        cell.registrationViews.layer.cornerRadius = 5

        
        return cell
    }
    
   let URL_USER_REGISTER = "http://52.14.245.160:4096/register"
    
    class URLRegister:URLConvertible{
        func asURL() throws -> URL {
            return  URL(string: "http://52.14.245.160:4096/register")!
        }
    }
    
    
    
    
    @IBAction func buttonRegister(_ sender: Any) {
        
       var indexPath = IndexPath(row: 0, section: 0)
        let cell1 = TableView.cellForRow(at: indexPath) as! ViewControllerTableViewCell
       
        
        indexPath = IndexPath(row: 1, section: 0)
        let cell2 = TableView.cellForRow(at: indexPath) as! ViewControllerTableViewCell
        
        
        indexPath = IndexPath(row: 2, section: 0)
        let cell3 = TableView.cellForRow(at: indexPath) as! ViewControllerTableViewCell
        
        indexPath = IndexPath(row: 3, section: 0)
        let cell4 = TableView.cellForRow(at: indexPath) as! ViewControllerTableViewCell
        

        /*for var i in 0...5 {
            var indexPath = [String]()
            indexPath[i] = IndexPath(row: i, section: 0)
            
        }*/
        
        let parameters: Parameters=[
                    "username": cell1.registerField.text ?? "",
                    "fullname": cell2.registerField.text ?? "",
                    "email": cell3.registerField.text ?? "",
                    "password": cell4.registerField.text ?? ""]
//
        
        Alamofire.request(URLRegister(), method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if let result = response.result.value  as? [String:Any] {
                print(result)
        }
            
        Alamofire.request(URLRegister())
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success:
                        print("Validation Successful")
                      
                    case .failure(let error):
                        print(error)
                    }
            }
        }

    
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be}≤
    }
}

