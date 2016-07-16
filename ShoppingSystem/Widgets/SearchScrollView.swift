//
//  SearchScrollView.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/13.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

protocol TagViewDelegate {
    func getHeight(height:CGFloat)
    
    
    
}


class SearchScrollView: UIView,TagViewDelegate {
    @IBOutlet weak var topContentView: UIView!

    @IBOutlet weak var titleView: UIView!



    @IBOutlet weak var hotSearchView: UIView!

    var tagView:TagView!
    var texts = ["甜的","岁月是把杀猪刀","而你却不知道的事情，你可知道吗","北风吹过的季节，任岁月在冬月里飘落，你可知晓的岁月歌声，无法看透的歌者"]
    var array:NSArray = NSArray()
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        super.drawRect(rect)
        
        tagView = TagView(frame: CGRectMake(titleView.frame.origin.x,titleView.frame.height,titleView.frame.width,titleView.frame.height))
        topContentView.addSubview(tagView)
        
        
        tagView.tags = SearchHistoryTool.shareInstance.readHistory()

        tagView.delegate = self

        tagView.backgroundColor = UIColor.whiteColor()
    }
    
    func getHeight(height: CGFloat) {
        tagView.frame = CGRectMake(tagView.frame.origin.x, tagView.frame.origin.y, tagView.frame.width, height)
        
        topContentView.frame = CGRectMake(topContentView.frame.origin.x, topContentView.frame.origin.y, topContentView.frame.width, titleView.frame.height+height)
        
        print("height:\(height)")

        
        hotSearchView.frame.origin.y = topContentView.frame.origin.y+topContentView.frame.height + 20
        

    }
    func updateHistoryData(){
    
        tagView.tags = SearchHistoryTool.shareInstance.readHistory()
        tagView.updateLayout()
    }
    
        @IBAction func clearButtonClicked(sender: AnyObject) {
        
        
        
    }

}
