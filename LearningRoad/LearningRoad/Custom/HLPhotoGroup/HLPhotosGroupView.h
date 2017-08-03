//
//  HLPhotosGroupView.h
//  WeiboCellDemo
//
//  Created by CH10 on 16/3/31.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTPhotoModel.h"
//间隔
#define space 10
//九宫格整体宽度
#define PhotosGroupViewWidth [UIScreen mainScreen].bounds.size.width
//边界宽度
#define EdgeWidth 10
#define MaxPicCount 9
#define MaxPicHangCount 3
@protocol CTPhotoGroupViewDelegate;

/** 图片九宫格排列 */
@interface HLPhotosGroupView : UIView
@property(nonatomic,assign)id<CTPhotoGroupViewDelegate> delegate;

/**
 * hcount:横向的item最大个数
 * countMax:item总数的最大值
 */
-(instancetype)initWithFrame:(CGRect)frame andHCount:(NSInteger)hcount andCountMax:(NSInteger)countMax;

-(void)setDataArrayWithPhotoModelArray:(NSArray<CTPhotoModel *> *)photoModels;
-(void)setDataArrayWithImgArray:(NSArray<UIImage*>*)imgs;
-(void)setDataArrayWithImgUrlStrArray:(NSArray<NSString *> *)urlStrs;
-(NSArray<CTPhotoModel*>*)getPhotoModelArray;

@end

@protocol CTPhotoGroupViewDelegate <NSObject>
@optional
-(void)photoGroup:(HLPhotosGroupView*)groupView photoClickedAtIndex:(NSInteger)index isAddBtn:(BOOL)flag;
-(void)photoGroup:(HLPhotosGroupView*)groupView deleteBtnClickedAtIndex:(NSInteger)index;
@end
