//
//  HLUNScrollSegmentControl.h
//  LearningRoad
//
//  Created by Zhl on 2017/7/25.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLUNScrollSegmentControlDelegate;

@interface HLUNScrollSegmentControl : UIView


@property (nonatomic,assign) BOOL showSlider;
@property (nonatomic,assign) BOOL moveAnimation;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,weak) id<HLUNScrollSegmentControlDelegate> delegate;
-(void)showRoundBadgeAtIndex:(NSInteger)index;

-(instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)items TextFont:(UIFont*)textFont AndDelegate:(id<HLUNScrollSegmentControlDelegate>)delegate;


@end

@protocol HLUNScrollSegmentControlDelegate <NSObject>
@optional
-(void)hlScrollSegmentControl:(HLUNScrollSegmentControl*)segControl SelectedIndex:(NSInteger)index;
-(void)setBasicPropertyOfHLScrollSegmentControl:(HLUNScrollSegmentControl*)control;
-(void)setBasicPropertyOfLeftIndicator:(UIView*)leftIndicator RightIndicator:(UIView*)rightIndicator;
-(void)setBasicPropertyOfBottomSlider:(UIView*)sliderView;
-(void)setBasicPropertyOfBtnItem:(UIButton*)btnItem;
@end
