WaterLayout
===========

流水布局框架

提供丰富的代理方法来实现流水布局

返回四周的间距,默认为10
- (UIEdgeInsets)insetsInWaterLayout:(ZSWaterLayout *)waterLayout;

返回有多少列
- (NSInteger)columNumberInwaterLayout:(ZSWaterLayout *)waterLayout;

返回每列之间的间距
- (CGFloat)columInsetInWaterLayout:(ZSWaterLayout *)waterLayout;

返回每行之间的间距
- (CGFloat)rowInsetInWaterLayout:(ZSWaterLayout *)waterLayout;


@required
必选方法,提供item的位置和宽度,根据比例来返回高度
- (CGFloat)waterLayout:(ZSWaterLayout *)waterLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath width:(CGFloat)width;
