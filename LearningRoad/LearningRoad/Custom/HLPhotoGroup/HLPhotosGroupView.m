//
//  HLPhotosGroupView.m
//  WeiboCellDemo
//
//  Created by CH10 on 16/3/31.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HLPhotosGroupView.h"
#import "HLPGCollectionViewCell.h"
#import "CTPhotoModel.h"

@interface HLPhotosGroupView ()<UICollectionViewDataSource,UICollectionViewDelegate,HLPGCollectionViewCellDelegate>
@property (nonatomic,weak)UICollectionView *groupCollectionView;
@property (nonatomic,strong)NSMutableArray <CTPhotoModel*> *dataArray;
@property (nonatomic,assign)NSInteger hCount;
@property(nonatomic,assign)NSInteger countMax;
@end

@implementation HLPhotosGroupView
-(instancetype)initWithFrame:(CGRect)frame andHCount:(NSInteger)hcount andCountMax:(NSInteger)countMax{
    self = [super initWithFrame:frame];
    if (self) {

        _hCount = hcount;
        _countMax = countMax;
        _dataArray = [[NSMutableArray alloc] init];
        CGFloat x=0,y=0,w= (PhotosGroupViewWidth-2*EdgeWidth-space*(hcount-1))/hcount,h=(PhotosGroupViewWidth-2*EdgeWidth-space*(hcount-1))/hcount;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [layout setItemSize:CGSizeMake(w, h)];
        layout.minimumLineSpacing = space;
        
        w=frame.size.width-2*EdgeWidth,h= frame.size.height-2*EdgeWidth;
        UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(x, y, w, h) collectionViewLayout:layout];
        collection.scrollEnabled = NO;
        collection.backgroundColor = [UIColor clearColor];
        collection.delegate = self;
        collection.dataSource = self;
        [collection registerClass:[HLPGCollectionViewCell class] forCellWithReuseIdentifier:@"cellIDs"];
        [self addSubview:collection];
        self.groupCollectionView = collection;
        
    }
    return self;
}
#pragma mark - setter methods
-(void)setDataArrayWithPhotoModelArray:(NSArray<CTPhotoModel *> *)photoModels{
    if (self.dataArray.count>0) {
        [self.dataArray removeAllObjects];
    }else{
        self.dataArray = [[NSMutableArray alloc] init];
    }
    [self.dataArray addObjectsFromArray:photoModels];
    [self updateDataAndUI];
}
-(void)setDataArrayWithImgUrlStrArray:(NSArray<NSString *> *)urlStrs{
    NSMutableArray <CTPhotoModel*>*photoModels = [[NSMutableArray alloc] init];
    for (NSString *urlStr in urlStrs) {
        
        CTPhotoModel *model = [[CTPhotoModel alloc] init];
        model.type = @"0";
        model.thumbnailImgUrl = urlStr;
        model.deleteBtnHidden = YES;
        [photoModels addObject:model];
    }
    [self setDataArrayWithPhotoModelArray:photoModels];
}
-(void)setDataArrayWithImgArray:(NSArray<UIImage *> *)imgs{
    NSMutableArray <CTPhotoModel*>* photoModels = [[NSMutableArray alloc] init];
    for (UIImage *img in imgs) {
        CTPhotoModel *model = [[CTPhotoModel alloc] init];
        model.type = @"1";
        model.thumbnailImage = img;
        model.deleteBtnHidden = YES;
        [photoModels addObject:model];
    }
    [self setDataArrayWithPhotoModelArray:photoModels];
}


#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count>_countMax?_countMax:_dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HLPGCollectionViewCell *cell = [HLPGCollectionViewCell PhotoCollectionViewCellWithCollectionView:collectionView IndexPath:indexPath];
    __weak HLPhotosGroupView *this = self;

    [cell setDeleteBtnClick:^(NSInteger index) {

        if (this.dataArray.count>index) {
            [this.dataArray removeObjectAtIndex:index];
            [this updateDataAndUI];
        }
        if ([this.delegate respondsToSelector:@selector(photoGroup:deleteBtnClickedAtIndex:)]) {
            [this.delegate photoGroup:this deleteBtnClickedAtIndex:index];
        }
    }];
    if (_dataArray.count) {
        CTPhotoModel *model = [_dataArray objectAtIndex:indexPath.row];
        cell.model = model;
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CTPhotoModel *model = [self.dataArray lastObject];
    
    BOOL flag = (indexPath.row == self.dataArray.count-1&&model.isAdd)?YES:NO;
    if ([self.delegate respondsToSelector:@selector(photoGroup:photoClickedAtIndex:isAddBtn:)]) {
        [self.delegate photoGroup:self photoClickedAtIndex:indexPath.row isAddBtn:flag];
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(EdgeWidth, EdgeWidth, EdgeWidth, EdgeWidth);
}
#pragma mark - private methods
-(void)updateDataAndUI{
    CTPhotoModel *model = [self.dataArray lastObject];
    if (model.isAdd == NO) {
        CTPhotoModel *model = [[CTPhotoModel alloc] init];
        model.thumbnailImage = [UIImage imageNamed:@"imgGroupAdd"];
        model.deleteBtnHidden = YES;
        model.type = @"1";
        model.isAdd = YES;
        [self.dataArray addObject:model];
    }
    [self updateFrame];
    [self.groupCollectionView reloadData];
}
-(void)updateFrame{
    NSInteger count     = self.dataArray.count;
    NSInteger realCount = count>self.countMax?self.countMax:count;
    NSInteger hang      = realCount/self.hCount;
    NSInteger lie       = realCount%self.hCount;
    CGFloat itemWidth   = (PhotosGroupViewWidth-2*EdgeWidth-space*(self.hCount-1))/self.hCount;
    CGRect frame        = self.frame;
    CGFloat h,w;
    if (hang>0) {
        if (lie>0) {
            hang+=1;
        }
        w = PhotosGroupViewWidth,
        h = itemWidth*hang+space*(hang-1)+2*EdgeWidth;
        frame.size.width  = w;
        frame.size.height = h;
    }else{
        if (lie == 0) {
            frame.size.height = 0;
        }else{
            w = itemWidth*lie+space*(lie-1)+2*EdgeWidth;
            h = itemWidth+2*EdgeWidth;
            frame.size.width  = w;
            frame.size.height = h;
        }
    }
    self.frame = frame;
    self.groupCollectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
-(NSArray<CTPhotoModel *> *)getPhotoModelArray{
    CTPhotoModel *model = [self.dataArray lastObject];
    NSInteger count = self.dataArray.count;
    if (model.isAdd == YES) {
        count = self.dataArray.count - 1;
    }
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<count; i++) {
        CTPhotoModel *model = [self.dataArray objectAtIndex:i];
        [resultArr addObject:model];
    }
    return resultArr;
}

@end
