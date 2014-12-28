//
//  ZSWaterLayout.h
//  02-瀑布流
//
//  Created by ZhuiYi on 14/12/27.
//  Copyright (c) 2014年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZSWaterLayout;

@protocol ZSWaterLayoutDelegate <NSObject>
/**
 *  返回四周的间距(默认为10)
 *
 *  @param waterLayout 布局
 *
 *  @return 四周的间距
 */
- (UIEdgeInsets)insetsInWaterLayout:(ZSWaterLayout *)waterLayout;
/**
 *  返回有多少列(默认为3)
 *
 *  @param waterLayout 布局
 *
 *  @return 有多少列
 */
- (NSInteger)columNumberInwaterLayout:(ZSWaterLayout *)waterLayout;
/**
 *  返回每列的间距(默认为10)
 *
 *  @param waterLayout 布局
 *
 *  @return 每列的间距
 */
- (CGFloat)columInsetInWaterLayout:(ZSWaterLayout *)waterLayout;
/**
 *  返回每行的间距(默认为10)
 *
 *  @param waterLayout 布局
 *
 *  @return 每行的间距
 */
- (CGFloat)rowInsetInWaterLayout:(ZSWaterLayout *)waterLayout;
@required
/**
 *  返回每个cell的高度
 *
 *  @param waterLayout 布局
 *  @param indexPath   cell的位置
 *  @param width       cell的宽度
 *
 *  @return 根据宽度来算出cell的高度
 */
- (CGFloat)waterLayout:(ZSWaterLayout *)waterLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath width:(CGFloat)width;
@end

@interface ZSWaterLayout : UICollectionViewLayout

@property (nonatomic, weak) id<ZSWaterLayoutDelegate> delegate;

@end
