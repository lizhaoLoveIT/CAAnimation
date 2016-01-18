//
//  ViewController.m
//  CAAnimation
//
//  Created by 李朝 on 16/1/17.
//  Copyright © 2016年 lizhao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) CALayer *layer;
@property (weak, nonatomic) IBOutlet UIView *purpleView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 图片数组 */
@property (strong, nonatomic) NSArray *imageNames;
/** 当前图片的索引 */
@property (assign, nonatomic) NSInteger index;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *lastButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setupLayer];
    
//    [self setupCATransition];
    
//    [self setupCAAnimationGroup];
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}



#pragma mark - CAAnimationGroup

- (void)setupCAAnimationGroup
{
    self.imageView.hidden = YES;
    //    self.purpleView.hidden = YES;
    self.nextButton.hidden = YES;
    self.lastButton.hidden = YES;
}
- (void)CAAnimationGroup
{
    // 同时缩放，平移，旋转
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.toValue = @0.5;
    
    CABasicAnimation *rotation = [CABasicAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.toValue = @(arc4random_uniform(M_PI));
    
    CABasicAnimation *position = [CABasicAnimation animation];
    position.keyPath = @"position";
    position.toValue = [NSValue valueWithCGPoint:CGPointMake(arc4random_uniform(200), arc4random_uniform(200))];
    
    group.animations = @[scale,rotation,position];
    
    [self.purpleView.layer addAnimation:group forKey:nil];
}



#pragma mark - CATransition

- (void)setupCATransition
{
    // CATransition
    self.purpleView.hidden = YES;
    
    self.imageNames = @[@"1", @"2", @"3", @"4",@"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
    self.imageView.image = [UIImage imageNamed:self.imageNames[0]];
    self.index = 0;
}

- (IBAction)lastPicture:(id)sender {
    self.index--;
    if (self.index < 0) {
        self.index = self.imageNames.count - 1;
    }
    self.imageView.image = [UIImage imageNamed:self.imageNames[self.index]];
    
    // 转场动画
    CATransition *animation = [CATransition animation];
    
    animation.type = @"moveIn";
    
    // subtype 控制转场方向：
    /*
     kCATransitionFade: 
     kCATransitionFromBottom: 从上往下
     kCATransitionFromTop: 从下往上
     kCATransitionFromLeft: 从左往右
     kCATransitionFromRight: 从右往左
     */
    animation.subtype = kCATransitionFromBottom;
    
    animation.duration = 0.5;
    
    // 动画进度，从动画的百分之80开始执行动画
    animation.startProgress = 0;
    // 从 startProgress 开始 以 endProgress 结束
    // 以动画的百分之 startProgress 开始 以 动画的 endProgress 结束
    animation.endProgress = 0.6;
    
    [self.imageView.layer addAnimation:animation forKey:nil];
}
- (IBAction)nextPicture:(id)sender {
    // 取出当前索引
    self.index++;
    if (self.index > self.imageNames.count - 1) {
        self.index = 0;
    }
    self.imageView.image = [UIImage imageNamed:self.imageNames[self.index]];
    
    // 转场动画
    CATransition *animation = [CATransition animation];
    
    
    animation.type = @"cube";
    // subtype 控制转场方向：
    animation.subtype = kCATransitionFromTop;
    
    animation.duration = 0.5;
    [self.imageView.layer addAnimation:animation forKey:nil];
}



#pragma mark - CAKeyframeAnimation

- (void)path
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    
    // 绘制路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 100, 200, 200));
    
    animation.path = path;
    CGPathRelease(path);
    
    // 用 quartz2D 绘制路径
    
    animation.duration = 2.0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    // 设置动画的执行节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [self.purpleView.layer addAnimation:animation forKey:nil];
}

- (void)move
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"position";
    
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointZero];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
    NSValue *v5 = [NSValue valueWithCGPoint:CGPointMake(300, 200)];
    NSValue *v6 = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    
    animation.values = @[v1, v2, v3, v4, v5, v6];
    
    animation.duration = 2.0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    // 控制每一帧的时间 表示第一帧用 1s，后面每一帧都用 0.2s
    //    animation.keyTimes = @[@0.5, @0.1, @0.1, @0.1, @0.1, @0.1];
    
    [self.purpleView.layer addAnimation:animation forKey:nil];
}

#pragma mark - CABasicAnimation


- (void)setupLayer
{
    self.imageView.hidden = YES;
    self.purpleView.hidden = YES;
    self.nextButton.hidden = YES;
    self.lastButton.hidden = YES;
    
    CALayer *layer = [CALayer layer];
    layer.position = CGPointMake(100, 100);
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    self.layer = layer;
    [self.view.layer addSublayer:layer];
}

/**
 * 平移动画
 */
- (void)transition
{
    // 1.创建动画对象
    CABasicAnimation *animation = [CABasicAnimation animation];
    // 2.设置动画属性
    
    // keyPath 决定了执行怎样的动画，调整哪个属性来执行动画
    animation.keyPath = @"position";
    
    // 如果没有 fromValue 属性，表示从当前位置开始 类型 id 意味着只能传入对象
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
    
    // byValue 表示递增值，表示在自己的基础上增加多少值
    animation.byValue;
    animation.duration = 2.0;
    // 如果只写到这里，做完动画会返回原样
    
    animation.removedOnCompletion = NO; // 完成时会移除动画，默认值为 YES
    
    // fillMode 动画执行完毕后的绘制模式
    // kCAFillModeForwards 当动画结束后，layer会一直保持着动画最新的状态
    // kCAFillModeBackwards 这个和kCAFillModeForwards是相对应的，就是在动画开始前，你只要将动画加入了一个layer，layer便立即进入动画的初始状态并等待动画开始。你可以这样设定测试代码，将一个动画加入一个layer的时候延迟5秒执行。然后就会发现在动画没有开始的时候，只要动画被加入了layer，layer便处于动画初始状态
    // kCAFillModeRemoved 这个是默认值，动画开始前和动画结束后，动画对layer都没有影响，动画结束后，layer会恢复到之前的状态
    // kCAFillModeBoth 动画加入后开始之前，layer便处于动画初始状态，动画结束后layer保持动画最后的状态。
    animation.fillMode = kCAFillModeForwards;
    // 3.添加动画
    [self.layer addAnimation:animation forKey:nil];
}

/**
 * 缩放
 */
- (void)scale
{
    // 1.创建动画对象
    CABasicAnimation *animation = [CABasicAnimation animation];
    // 2.设置动画属性
    
    // keyPath 决定了执行怎样的动画，调整哪个属性来执行动画
    animation.keyPath = @"bounds";
    
    // 如果没有 fromValue 属性，表示从当前位置开始 类型 id 意味着只能传入对象
    //    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 300)];
    animation.duration = 2.0;
    // 如果只写到这里，做完动画会返回原样
    
    animation.removedOnCompletion = NO; // 完成时会移除动画，默认值为 YES
    animation.fillMode = kCAFillModeForwards;
    // 3.添加动画
    [self.layer addAnimation:animation forKey:nil];
}

/**
 * transform3D
 */
- (void)transform3D
{
    // 1.创建动画对象
    CABasicAnimation *animation = [CABasicAnimation animation];
    // 2.设置动画属性
    
    // keyPath 决定了执行怎样的动画，调整哪个属性来执行动画
    animation.keyPath = @"transform";
    
    // 如果没有 fromValue 属性，表示从当前位置开始 类型 id 意味着只能传入对象
    //    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, -1, 0)];
    animation.duration = 2.0;
    // 如果只写到这里，做完动画会返回原样
    
    animation.removedOnCompletion = NO; // 完成时会移除动画，默认值为 YES
    animation.fillMode = kCAFillModeForwards;
    // 3.添加动画
    [self.layer addAnimation:animation forKey:nil];
}

/**
 * rotation
 */
- (void)rotation
{
    // 1.创建动画对象
    CABasicAnimation *animation = [CABasicAnimation animation];
    // 2.设置动画属性
    
    // keyPath 决定了执行怎样的动画，调整哪个属性来执行动画
    animation.keyPath = @"transform.rotation";
    
    // 如果没有 fromValue 属性，表示从当前位置开始 类型 id 意味着只能传入对象
    //    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    animation.toValue = @(M_PI_2);
    animation.duration = 2.0;
    // 如果只写到这里，做完动画会返回原样
    
    animation.removedOnCompletion = NO; // 完成时会移除动画，默认值为 YES
    animation.fillMode = kCAFillModeForwards;
    // 3.添加动画
    [self.layer addAnimation:animation forKey:nil];
}

@end
