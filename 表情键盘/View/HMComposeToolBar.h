//
//  HMComposeToolBar.h
//  表情键盘
//
//  Created by 苏浩楠 on 16/1/25.
//  Copyright © 2016年 苏浩楠. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HMComposeToolbarButtonTypeCamera, // 照相机
    HMComposeToolbarButtonTypePicture, // 相册
    HMComposeToolbarButtonTypeMention, // 提到@
    HMComposeToolbarButtonTypeTrend, // 话题
    HMComposeToolbarButtonTypeEmotion // 表情
    
}HMComposeToolBarButtonType;

@class HMComposeToolBar;

@protocol HMComposeToolBarDelegate <NSObject>

@optional
- (void)composeTool:(HMComposeToolBar *)toolBar didClickedButton:(HMComposeToolBarButtonType)buttonType;

@end

@interface HMComposeToolBar : UIView

@property (nonatomic,weak) id<HMComposeToolBarDelegate> delegate;
/**
 *  是否要显示表情按钮
 */
@property (nonatomic,assign,getter=isShowEmotionButton) BOOL showEmotionButton;
@end
