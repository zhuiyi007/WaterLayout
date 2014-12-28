//
//  ZSWaterLayout.m
//  02-瀑布流
//
//  Created by ZhuiYi on 14/12/27.
//  Copyright (c) 2014年 ZhuiYi. All rights reserved.
//

#import "ZSWaterLayout.h"
// 默认每行最多显示多少列
static NSInteger defaultMaxCol = 3;
// 默认每行的间距
static CGFloat  defaultRowInset = 10;
// 默认每列的间距
static CGFloat  defaultColInset = 10;
// 默认的四周的间距
static CGFloat  defaultInset = 10;

@interface ZSWaterLayout ()
// 最大Y值的数组,用于确定cell应该放在哪一列
@property (nonatomic, strong) NSMutableArray *maxYArray;
// 布局的数组
@property (nonatomic, strong) NSMutableArray *attributesArray;
@end

@implementation ZSWaterLayout
#pragma mark - 懒加载
- (NSMutableArray *)maxYArray
{
    if (!_maxYArray)
    {
        _maxYArray = [NSMutableArray array];
    }
    return _maxYArray;
}
- (NSArray *)attributesArray
{
    if (!_attributesArray) {
        _attributesArray = [[NSMutableArray alloc] init];
    }
    return _attributesArray;
}
#pragma mark - 有新的可见范围时就刷新
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
#pragma mark - 这个方法比下面的方法调用少,计算就放在这个方法中
- (void)prepareLayout
{
    [self.maxYArray removeAllObjects];
    for (NSInteger i = 0; i < [self getColumNumber]; i ++)
    {
        self.maxYArray[i] = @0.0;
    }
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i ++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributesArray addObject:attrs];
    }
}
#pragma mark - 可见范围内的cell布局
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesArray;
}
#pragma mark - 对应位置的cell的布局
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 四周的间距
    UIEdgeInsets inset = [self getInsets];
    // 每列的间距
    CGFloat colInset = [self getColumInset];
    // 每行的间距
    CGFloat rowInset = [self getRowInset];
    // 总列数
    NSInteger maxCol = [self getColumNumber];
    // collection的宽度
    CGFloat collectionWidth = self.collectionView.bounds.size.width;
    // 每个cell的宽高
    CGFloat cellWidth = (collectionWidth - inset.left - inset.right - (maxCol - 1) * colInset) / maxCol;
    CGFloat cellHeight = [self.delegate waterLayout:self heightForItemAtIndexPath:indexPath width:cellWidth];
    // 最小的Y值
    CGFloat minMaxY = [self.maxYArray[0] doubleValue];
    // 最小Y值的列号
    NSInteger minCol = 0;
    for (int i = 0; i < maxCol; i ++) {
        CGFloat maxY = [self.maxYArray[i] doubleValue];
        if (maxY < minMaxY) {
            minMaxY = maxY;
            minCol = i;
        }
    }
    CGFloat cellX = inset.left + (colInset + cellWidth) * minCol;
    CGFloat cellY = minMaxY + rowInset;
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.frame = CGRectMake(cellX, cellY, cellWidth, cellHeight);
    // 刷新Y值的高度
    self.maxYArray[minCol] = @(CGRectGetMaxY(attribute.frame));
    return attribute;
}
#pragma mark - cellectionView的滚动范围
- (CGSize)collectionViewContentSize
{
    if (self.maxYArray.count)
    {
        // 最大的Y值
        CGFloat maxMaxY = [self.maxYArray[0] doubleValue];
        for (int i = 0; i < [self getColumNumber]; i ++)
        {
            CGFloat maxY = [self.maxYArray[i] doubleValue];
            if (maxY > maxMaxY)
            {
                maxMaxY = maxY;
            }
        }
        return CGSizeMake(0, maxMaxY);
    }
    return CGSizeMake(0, 0);
}
#pragma mark - 根据代理得到列数
- (NSInteger)getColumNumber
{
    if ([self.delegate respondsToSelector:@selector(columNumberInwaterLayout:)])
    {
        return [self.delegate columNumberInwaterLayout:self];
    }
    return defaultMaxCol;
}
#pragma mark - 根据代理得到四周的间距
- (UIEdgeInsets)getInsets
{
    if ([self.delegate respondsToSelector:@selector(insetsInWaterLayout:)])
    {
        return [self.delegate insetsInWaterLayout:self];
    }
    return UIEdgeInsetsMake(defaultInset, defaultInset, defaultInset, defaultInset);
}
#pragma mark - 根据代理得到每列之间的间距
- (CGFloat)getColumInset
{
    if ([self.delegate respondsToSelector:@selector(columInsetInWaterLayout:)])
    {
        return [self.delegate columInsetInWaterLayout:self];
    }
    return defaultColInset;
}
#pragma mark - 根据代理得到每行之间的间距
- (CGFloat)getRowInset
{
    if ([self.delegate respondsToSelector:@selector(rowInsetInWaterLayout:)])
    {
        return [self.delegate rowInsetInWaterLayout:self];
    }
    return defaultRowInset;
}

@end
