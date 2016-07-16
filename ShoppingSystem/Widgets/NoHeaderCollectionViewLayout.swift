//
//  NoHeaderCollectionViewLayout.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/13.
//  Copyright © 2016年 fanzz. All rights reserved.
//

import UIKit

protocol NoHeaderCollectionViewLayoutDelegate {
    func flowLayout(layout:NoHeaderCollectionViewLayout,heightForWidth width:CGFloat,atIndexPath indexPath:NSIndexPath) ->CGFloat
    
}
class NoHeaderCollectionViewLayout: UICollectionViewLayout {


    
    var columnMargin:CGFloat
    var rowMargin:CGFloat
    
    var columnsCount:Int
    
    var sectionInset:UIEdgeInsets
    
    var delegate:NoHeaderCollectionViewLayoutDelegate?
    
    
    var maxYDict:NSMutableDictionary
    
    var attributeArray:[UICollectionViewLayoutAttributes]
    
    override init()
    {
        columnMargin = 15
        rowMargin = 10
        columnsCount = 2
        sectionInset = UIEdgeInsetsMake(10,10,10,10)
        maxYDict = NSMutableDictionary()
        attributeArray = [UICollectionViewLayoutAttributes]()
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        return attributeArray
        
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath:NSIndexPath)->UICollectionViewLayoutAttributes {
        
        // 1.计算尺寸
        
        let wid = self.collectionView!.frame.size.width - self.sectionInset.left - self.sectionInset.right - CGFloat(self.columnsCount - 1) * CGFloat(self.columnMargin)
        let width = wid / CGFloat(self.columnsCount)
        // 代理计算传入高的值
        let height = self.delegate!.flowLayout(self,heightForWidth:width,atIndexPath:indexPath)
        
        var minColumn:Int = 0
        for (index,item) in maxYDict {
            
            if CGFloat(item as! NSNumber) < CGFloat(maxYDict[minColumn] as! NSNumber) {
                minColumn = index as! Int
            }
        }
        
        
        let x = self.sectionInset.left + (self.columnMargin + width) * CGFloat(minColumn)
        let y = CGFloat(self.maxYDict[minColumn] as! NSNumber) + rowMargin
     
        
        self.maxYDict[minColumn] = y + height
        // 3.创建属性
        let attrs = UICollectionViewLayoutAttributes(forCellWithIndexPath:indexPath)
        
        attrs.frame = CGRectMake(x, y, width, height)
        return attrs;
        
    }
    override func prepareLayout() {
        super.prepareLayout()
        
        for i in 0..<columnsCount {
            self.maxYDict[i] = self.sectionInset.top
        }
        self.attributeArray.removeAll()
        
        let count = self.collectionView!.numberOfItemsInSection(0)
        
        for j in 0..<count{
            let attris = self.layoutAttributesForItemAtIndexPath(NSIndexPath(forRow: j, inSection: 0))
            self.attributeArray.append(attris)
            
        }
        
    }
    
   
    
    
    
    override func collectionViewContentSize() -> CGSize {
        var maxColumn = 0
        for (index,item) in maxYDict {
            
            if CGFloat(item as! NSNumber) > CGFloat(maxYDict[maxColumn] as! NSNumber) {
                maxColumn = index as! Int
            }
        }
        return CGSize(width: 0, height: (self.maxYDict[maxColumn] as! CGFloat)+self.sectionInset.bottom)
    }
}
