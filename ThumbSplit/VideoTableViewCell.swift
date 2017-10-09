//
//  VideoTableViewCell.swift
//  ThumbSplit
//
//  Created by Sierra on 9/28/17.
//  Copyright © 2017 Sierra. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

protocol VideoTableViewCellDelegate: class {
    
    func passingLikes(cell: VideoTableViewCell)
    func passingDislikes(cell: VideoTableViewCell)
    func selectedButton(cell: VideoTableViewCell) -> Int
    
}

class VideoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        videoImage.clipsToBounds = true
        avatarImage.layer.cornerRadius = 26
        avatarImage.clipsToBounds = true
        likeButton.setImage(#imageLiteral(resourceName: "btnLike"), for: .normal)
        likeButton.setImage(#imageLiteral(resourceName: "btnLikeSelected"), for: .selected)
        cellView.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
        cellView.layer.borderWidth = 0.2
        
        dislikeButton.setImage(#imageLiteral(resourceName: "btnDislike"), for: .normal)
        dislikeButton.setImage(#imageLiteral(resourceName: "btnDislikeSelected"), for: .selected)
        
        

    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var videoLenght: UILabel!
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var videoImage: UIImageView!

    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var videoTitle: UILabel!

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var viewsButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var dislikeButton: UIButton!
    
    weak var delegate: VideoTableViewCellDelegate?
    
    func configureCell(video: Video, delegate: VideoTableViewCellDelegate) {
        self.delegate = delegate
        
        videoImage.af_setImage(withURL: video.thumbnail)
        avatarImage.af_setImage(withURL: video.user_image)
        
        videoTitle.text = video.title
        usernameLabel.text = video.username

        viewsButton.setTitle(video.views, for: .normal)
        let likeString = String(video.like_count)
        likeButton.setTitle(likeString, for: .normal)
        
        
        let dislikeString = String(video.dislike_count)
        dislikeButton.setTitle(dislikeString, for: .normal)
        
//        let lenghtString = String(video.video_lenght)
//        self.videoLenght.text = lenghtString
        
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let date = Date(timeIntervalSince1970: TimeInterval(video.created_at))
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateTime = dateFormatter.string(from: date)
        
        dateLabel.text = dateTime
        
        
    }
    
    @IBAction func likePressedButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if delegate?.selectedButton(cell: self) == 1{
            dislikeButton.isEnabled = false
       }
        else {
            dislikeButton.isEnabled = true
        }
        delegate?.passingLikes(cell: self)
    }
    
    @IBAction func dislikePressedButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if delegate?.selectedButton(cell: self) == 1{
            likeButton.isEnabled = false
        }
        else{
            likeButton.isEnabled = true
        }
        delegate?.passingDislikes(cell: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    deinit {
        print("video cell deinit")
    }
    
    }

