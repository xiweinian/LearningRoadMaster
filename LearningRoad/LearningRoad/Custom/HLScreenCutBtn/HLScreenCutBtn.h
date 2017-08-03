//
//  HLScreenCutBtn.h
//  Quartz2d
//
//  Created by CH10 on 15/11/9.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define btnX self.frame.origin.x
#define btnY self.frame.origin.y
#define btnWidth self.frame.size.width
#define btnHeight self.frame.size.height

@protocol HLScreenCutBtnDelegate <NSObject>

-(void)saveImageSuccess;

@end


@interface HLScreenCutBtn : UIButton
@property(nonatomic,assign)id<HLScreenCutBtnDelegate>delegate;
@property (nonatomic,assign) CGFloat offsetY;
+(HLScreenCutBtn *)shareZHLScreenCutBtn;
@end
