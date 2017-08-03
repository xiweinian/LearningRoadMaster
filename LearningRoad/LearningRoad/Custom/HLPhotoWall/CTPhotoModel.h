//
//  CTPhotoModel.h
//  HandicapWin
//
//  Created by Zhl on 16/5/25.
//  Copyright © 2016年 赢盘. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CTPhotoModel : NSObject

@property(nonatomic,assign)BOOL isAdd;
/**
 type: 0-url 1-image
 */
@property(nonatomic,assign)NSString *type;

#pragma mark - 用于缩略图photoGroupView

/**略缩图网址*/
@property(nonatomic,copy)NSString *thumbnailImgUrl;
/**略缩图*/
@property(nonatomic,strong)UIImage *thumbnailImage;
/**是否隐藏删除按钮*/
@property(nonatomic,assign)BOOL deleteBtnHidden;

#pragma mark - 用于大图浏览photoWall
/**大图网址*/
@property(nonatomic,copy)NSString *largeImgUrl;
/**大图*/
@property(nonatomic,strong)UIImage *largeImage;


@end
