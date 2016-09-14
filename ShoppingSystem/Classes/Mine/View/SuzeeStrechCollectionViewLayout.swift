//
//  SuzeeStrechCollectionViewLayout.swift
//  ShoppingSystem
//
//  Created by fanzz on 16/7/17.
//  Copyright © 2016年 fanzz. All rights reserved.
//

/**
 $(PLATFORM_DIR)/Developer/Library/Frameworks $(PROJECT_DIR)/ThirdSDK/Bmob_SDK_iOS_v1.4.1
 
 
 
 */


import UIKit

protocol StrechDelete {
    func flowLayoutHeightForIndexPath(layout:SuzeeStrechCollectionViewLayout,atIndexPath:NSIndexPath)->CGFloat
    
    func flowLayoutAfterIsSeparatedForIndexPath(layout:SuzeeStrechCollectionViewLayout,atIndexPath:NSIndexPath)->Bool
}


class SuzeeStrechCollectionViewLayout: UICollectionViewLayout {
    
    var delegate:StrechDelete?
    
    var currentOriginY:CGFloat = 210
    
    var headerReferenceSize:CGSize?
    
    var attributeArray:[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    var insets:UIEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    
 
    
 
    
    override func prepareLayout() {
        super.prepareLayout()
        
        self.attributeArray.removeAll()
        
        let count = self.collectionView!.numberOfItemsInSection(0)
        
        for j in 0..<count{
            let attris = self.layoutAttributesForItemAtIndexPath(NSIndexPath(forRow: j, inSection: 0))
            self.attributeArray.append(attris)
            
        }
        headerReferenceSize = CGSizeMake(screenW,200)
        
        currentOriginY = (headerReferenceSize?.height)!+insets.top

    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }

    
    override func layoutAttributesForItemAtIndexPath(indexPath:NSIndexPath)->UICollectionViewLayoutAttributes {
        
        // 1.计算尺寸

        let width = screenW
        // 代理计算传入高的值
        let height = self.delegate?.flowLayoutHeightForIndexPath(self, atIndexPath: indexPath)
        
        let x:CGFloat = 0
       
        let y = currentOriginY
        
        
        // 3.创建属性
        let attrs = UICollectionViewLayoutAttributes(forCellWithIndexPath:indexPath)
        
        attrs.frame = CGRectMake(x, y, width, height!)
        
        let flag:Bool = (self.delegate?.flowLayoutAfterIsSeparatedForIndexPath(self, atIndexPath: indexPath))!
        if flag {
        currentOriginY += (height!+insets.top)
        }else{
            currentOriginY += height!
        }
        
        return attrs;
        
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray = [UICollectionViewLayoutAttributes]()
        
        attributesArray.appendContentsOf(attributeArray)
        
        let index2 = self.collectionView!.indexOfAccessibilityElement(UICollectionElementKindSectionHeader)
        
        let  attr2:UICollectionViewLayoutAttributes = self.collectionView!.layoutAttributesForSupplementaryElementOfKind(UICollectionElementKindSectionHeader, atIndexPath: NSIndexPath(forItem: index2, inSection: 0))!
        attributesArray.append(attr2)

        return attributesArray
        
    }
    
    
    
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, withIndexPath: indexPath)
        if elementKind == UICollectionElementKindSectionHeader {
            let width =  self.collectionView!.frame.width
            attribute.frame = CGRect(x: 0,y: 0 ,width:width,height: headerReferenceSize!.height)
            let offset = self.collectionView?.contentOffset
            if offset?.y < 0 { // 用户向下拉
                
                let deltay = fabs((offset?.y)!)
               
                    // 获取headView的frame
                    var rect = attribute.frame
                    // 改变headView的高度，y值
                    rect.size.height += deltay
                    rect.origin.y -= deltay
                    
                    attribute.frame = rect
                    
            }
            return attribute
            
        }else {
            
            
            return nil
        }
    }
    
    
    
    
    override func collectionViewContentSize() -> CGSize {
    
//        let height = CGFloat(self.collectionView?.numberOfItemsInSection(0)*)
        
            return CGSize(width: 0, height:screenH+200)
       
    }

    
  
}
