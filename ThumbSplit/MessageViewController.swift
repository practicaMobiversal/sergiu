//
//  MessageViewController.swift
//  ThumbSplit
//
//  Created by Sierra on 9/27/17.
//  Copyright © 2017 Sierra. All rights reserved.
//

import UIKit
import Alamofire
import Unbox



class MessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var videos = [Video]()
    
    var tabTitles = ["Categories",
                     "Newest",
                     "Trending",
                     "Favourites"]
    
    
    var jwt: String!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBOutlet var OverallView: UIView!
    @IBOutlet weak var navScrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var videoTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (videos.count)
    }
    
    private func addSubviews(){
        
        for index in 0 ..< tabTitles.count
        {
            let button = UIButton()
            
            
            
        button.setTitle(tabTitles[index], for: .normal)
            
            button.setTitleColor(UIColor.magenta, for: .normal)
            button.titleLabel?.font = UIFont(name:"Gill Sans", size: 20)
            button.tag = index
            
            button.addTarget(self, action: #selector(topTabBarButtonPressed(sender:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            
            
        }
        
        
        
    }
    
    @objc private func topTabBarButtonPressed(sender: UIButton) {
        
        for view in stackView.subviews {
            if let button = view as? UIButton {
                if button.tag == sender.tag {
                    button.setTitleColor(UIColor.purple, for: .normal)
                    
                   // button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                    
                } else {
                    
                    button.titleLabel?.textColor = UIColor.magenta

                  // button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightRegular)
                 
                
                    
                }
                self.requestVideos(params: 2)
                
                
                               }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        
        cell.configureCell(video: videos[indexPath.row], delegate: self)
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let parameters = ["type" : 2]
        self.addSubviews()
        self.videoTableView.estimatedRowHeight = 30
        self.videoTableView.rowHeight = UITableViewAutomaticDimension
     
        
        //bottom border of the navScrollView
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: navScrollView.frame.size.height + 1, width: OverallView.frame.width, height: 0.5)
        
             bottomLine.backgroundColor = UIColor.lightGray.cgColor
        navScrollView.layer.addSublayer(bottomLine)
        
        let nib = UINib(nibName: "VideoTableViewCell", bundle: nil)
        self.videoTableView.register(nib, forCellReuseIdentifier: "VideoTableViewCell")
        
        
        self.requestVideos(params: 2)
        
//        
//        let headers = ["Authorization" : "Bearer " + self.jwt]
//       
//        Alamofire.request(URLRegister(), method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
//            print("juihgyhvbhuj")
//            print(String.init(data: response.data!, encoding: String.Encoding.nonLossyASCII))
//            
//           
//            let vid: Videos = try! unbox(data: response.data!)
//            
//            self.videos = vid.video
//            self.videoTableView.reloadData()
        
            
        }
    

    
    func requestVideos(params: Int){
        
        let headers = ["Authorization" : "Bearer " + self.jwt]
        
        let parameters = ["type" : params]
        
        Alamofire.request(URLRegister(), method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print("juihgyhvbhuj")
            print(String.init(data: response.data!, encoding: String.Encoding.nonLossyASCII) ?? "")
            
            
            do {
            
            let vid: Videos = try unbox(data: response.data!)
            self.videos = vid.video
            self.videoTableView.reloadData()
            
             } catch {}

          
    }
    
    
}
}



class URLRegister:URLConvertible{
    func asURL() throws -> URL {
        return  URL(string: "http://52.14.245.160:4096/v1/get-videos")!
    }
}



struct Video {
    
    let id: Int
    let title: String
    let thumbnail: URL
    let user_image: URL
    let username : String
    let views: String
    var like_count: Int
    var dislike_count: Int
    var like_status: Int
    //let video_lenght: Int
    let created_at:  Int
    
    
}
struct Videos: Unboxable {
    let video: [Video]
    init(unboxer: Unboxer) throws {
        self.video = try unboxer.unbox(keyPath: "data.videos")
    }
    
}

extension Video: Unboxable {
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.title = try unboxer.unbox(key: "title")
        self.thumbnail = try unboxer.unbox(key: "thumbnail")
        self.user_image = try unboxer.unbox(keyPath: "user.profile_image")
        self.username = try unboxer.unbox(keyPath: "user.username")
        self.views = try unboxer.unbox(key: "views")
        self.dislike_count = try unboxer.unbox(key: "dislike_count")
        self.like_count = try unboxer.unbox(key: "like_count")
        self.like_status = try unboxer.unbox(key: "like_status")
        //self.video_lenght = try unboxer.unbox(key: "video_lenght")
        self.created_at = try unboxer.unbox(key: "created_at")
    }
    
}

extension MessageViewController : VideoTableViewCellDelegate {
    

    func passingLikes(cell: VideoTableViewCell) {
        guard let indexPaht = videoTableView.indexPath(for: cell) else {return}
        if videos[indexPaht.row].like_status == 0 {
            videos[indexPaht.row].like_count += 1
            videos[indexPaht.row].like_status = 1
        }
        else {
            videos[indexPaht.row].like_count -= 1
            videos[indexPaht.row].like_status = 0
        }
        

        videoTableView.reloadData()
    }
    
    func passingDislikes(cell: VideoTableViewCell){
        guard let indexPath = videoTableView.indexPath(for: cell) else {return}
        
        if videos[indexPath.row].like_status == 0 {
            
            videos[indexPath.row].dislike_count += 1
            videos[indexPath.row].like_status = 1
        }
        else {
            videos[indexPath.row].dislike_count -= 1
            videos[indexPath.row].like_status = 0
            
        }
        
            videoTableView.reloadData()
    }
    func selectedButton(cell: VideoTableViewCell) -> Int {
        
        guard let indexPath = videoTableView.indexPath(for: cell) else {return 0}
        
        if videos[indexPath.row].like_status == 0 {
            return 1;
        }
        else{
            return 0;
        }
        
        
    }
}








