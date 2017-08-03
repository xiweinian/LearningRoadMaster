//
//  HLScrollSegmentControl.h
//  demo3
//
//  Created by Zhl on 2017/7/5.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLScrollSegmentControlDelegate;
@interface HLScrollSegmentControl : UIView

@property (nonatomic,assign) BOOL showSlider;
@property (nonatomic,assign) BOOL showIndicator;
@property (nonatomic,assign) BOOL moveAnimation;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,assign) CGFloat sliderWidth;
-(void)showRoundBadgeAtIndex:(NSInteger)index;
@property (nonatomic,weak) id<HLScrollSegmentControlDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)items TextFont:(UIFont*)textFont SpaceWidth:(CGFloat)spaceWidth AndDelegate:(id<HLScrollSegmentControlDelegate>)delegate;

@end





@protocol HLScrollSegmentControlDelegate <NSObject>
@optional
-(void)hlScrollSegmentControl:(HLScrollSegmentControl*)segControl SelectedIndex:(NSInteger)index;
-(void)setBasicPropertyOfHLScrollSegmentControl:(HLScrollSegmentControl*)control;
-(void)setBasicPropertyOfLeftIndicator:(UIView*)leftIndicator RightIndicator:(UIView*)rightIndicator;
-(void)setBasicPropertyOfBottomSlider:(UIView*)sliderView;
-(void)setBasicPropertyOfBtnItem:(UIButton*)btnItem;
@end
