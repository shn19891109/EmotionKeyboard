//
//  ViewController.m
//  表情键盘
//
//  Created by 苏浩楠 on 16/1/24.
//  Copyright © 2016年 苏浩楠. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
#import "HMTextView.h"
#import "HMComposeToolBar.h"

@interface ViewController ()<UITextViewDelegate,HMComposeToolBarDelegate>
@property (nonatomic, weak) HMTextView *textView;
@property (nonatomic, weak) HMComposeToolBar *toolbar;

/**
 *  是否正在切换键盘
 */
@property (nonatomic, assign, getter = isChangingKeyboard) BOOL changingKeyboard;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加工具条
    [self setupToolbar];
    // 添加输入控件
    [self setupTextView];

}
- (void)setupToolbar {
    //1.创建
    HMComposeToolBar *toolBar = [[HMComposeToolBar alloc] init];
    self.toolbar = toolBar;
    toolBar.width = self.view.width;
    toolBar.delegate = self;
    toolBar.height = 44;
    toolBar.y = self.view.height - toolBar.height;
    [self.view addSubview:toolBar];
}
// 添加输入控件
- (void)setupTextView
{
    //1.创建输入控件
    HMTextView *textView = [[HMTextView alloc] init];
    // 垂直方向上拥有有弹簧效果
    textView.alwaysBounceVertical = YES;
    textView.frame = CGRectMake(0, 100, self.view.width, 200);
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    //2.设置提醒文字
    textView.placehoder = @"请输入你的内容。。。。";
    // 3.设置字体
    textView.font = [UIFont systemFontOfSize:15];
    // 4.监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  view显示完毕的时候再弹出键盘，避免显示控制器view的时候会卡住
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 成为第一响应者（叫出键盘）
    [self.textView becomeFirstResponder];
}
#pragma mark - 键盘处理
/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    //1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    //2.动画
    [UIView animateWithDuration:duration animations:^{
        //取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardH);
    }];
}

/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    if (self.isChangingKeyboard) {
        return;
    }
    //1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    //2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
