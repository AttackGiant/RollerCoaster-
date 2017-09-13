//
//  ViewController.m
//  demo_bj
//
//  Created by attackGiant on 2017/9/7.
//  Copyright © 2017年 attackGiant. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>


#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height


#define kScreenWidth2  [UIScreen mainScreen].bounds.size.height
#define kScreenHeight2  [UIScreen mainScreen].bounds.size.width
@interface ViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) WKWebView * wkView;

@property (nonatomic, strong) UIWebView *webView;


@property (nonatomic, strong) NSCache *cache;

@property (nonatomic, strong) UIButton *clickBtn;

@property (nonatomic, strong) UIButton *checkBtn;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) CAShapeLayer *yellow;


@property (nonatomic, strong) UIView *backV;




//用来做背景颜色的渲染工作，CAGradientLayer是用来生成两种或更多颜色平滑渐变的。相比于Core Graphics来说CAGradientLayer的真正好处在于绘制使用了硬件加速。这说明通过CAGradientLayer来绘制渐变的效果比用Core Graphics的效率更高。我们通过CAGradientLayer来实现这个项目中的背景
@property (nonatomic, strong) CAGradientLayer *CAGLayer;

//绘制草坪和过山车等,CAShapeLayer是一个通过矢量图形而不是bitmap来绘制的图层子类。你指定诸如颜色和线宽等属性，用CGPath来定义想要绘制的图形，最后CAShapeLayer就自动渲染出来了。当然，你也可以用Core Graphics直接向原始的CALyer的内容中绘制一个路径，相比直下，使用CAShapeLayer有以下一些优点：
//1.渲染快速。CAShapeLayer使用了硬件加速，绘制同一图形会比用Core Graphics快很多。
//2.高效使用内存。一个CAShapeLayer不需要像普通CALayer一样创建一个寄宿图形，所以无论有多大，都不会占用太多的内存。
//3.不会被图层边界剪裁掉。一个CAShapeLayer可以在边界之外绘制。你的图层路径不会像在使用Core Graphics的普通CALayer一样被剪裁掉（如我们在第二章所见）。
//4.不会出现像素化。当你给CAShapeLayer做3D变换时，它不像一个有寄宿图的普通图层一样变得像素化。
@property (nonatomic, strong) CAShapeLayer *shapeLayer;





@end

@implementation ViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
//    int a = 10, b = 8;
//    
//    a = a + b;
//    b = a - b;
//    a = a - b;
//    NSLog(@"a= %d,b = %d",a,b);
   
    //WKWebView对内存消耗较少
//     self.wkView = [[WKWebView alloc] initWithFrame:self.view.bounds];
//    self.wkView.UIDelegate = self;
//    self.wkView.navigationDelegate = self;
//    [self.wkView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
//    [self.view addSubview:self.wkView];
    
    
    
    //UIWebview对内存消耗较大，容易造成内存泄漏
//     self.webView  = [[UIWebView alloc]initWithFrame:self.view.bounds];
//     [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
//     [self.view addSubview:self.webView];
    
//    self.clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.clickBtn.frame = CGRectMake(50, 100, 70, 20);
//    self.clickBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    self.clickBtn.backgroundColor = [UIColor colorWithRed:106/255.0 green:213/255.0 blue:249/255.0 alpha:1];
//    [self.clickBtn setTitle:@"添加数据" forState:UIControlStateNormal];
//    [self.clickBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.clickBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//    [self.clickBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.clickBtn];
//    
//    
//    self.checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.checkBtn.frame = CGRectMake(50, 200, 70, 20);
//    self.checkBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    self.checkBtn.backgroundColor = [UIColor colorWithRed:106/255.0 green:213/255.0 blue:249/255.0 alpha:1];
//    [self.checkBtn setTitle:@"查看数据" forState:UIControlStateNormal];
//    [self.checkBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//    [self.checkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.checkBtn addTarget:self action:@selector(checkBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.checkBtn];
//    
//    
//    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.deleteBtn.frame = CGRectMake(50, 300, 70, 20);
//    self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    self.deleteBtn.backgroundColor = [UIColor colorWithRed:106/255.0 green:213/255.0 blue:249/255.0 alpha:1];
//    [self.deleteBtn setTitle:@"删除数据" forState:UIControlStateNormal];
//    [self.deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//    [self.deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.deleteBtn addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.deleteBtn];
    
    
    
    
    
    
    NSLog(@"width=%f------height=%f",kScreenWidth,kScreenHeight);
    
    NSLog(@"width=%f------height=%f",kScreenWidth2,kScreenHeight2);

    self.backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight, kScreenWidth )];
    [self.view addSubview:self.backV];
    
    //初始化 背景
    
     self.CAGLayer = [CAGradientLayer layer];
     self.CAGLayer.frame = self.backV.bounds;
    //设置渐变的颜色
     self.CAGLayer.colors = @[(id)[UIColor colorWithRed:178.0/255.0 green:226.0/255.0 blue:248.0/255.0 alpha:1.0].CGColor,
                              (id)[UIColor colorWithRed:232.0/255.0 green:244.0/255.0 blue:193.0/255.0 alpha:1.0].CGColor];
    //设置渐变的方向 自左上到右下
     self.CAGLayer.startPoint = CGPointMake(0, 0);
     self.CAGLayer.endPoint = CGPointMake(1, 1);
    [self.backV.layer addSublayer: self.CAGLayer];
    
    
    //添加第一座山上半部分
    
    CAShapeLayer *moutain = [CAShapeLayer layer];
    UIBezierPath *moutainOne = [UIBezierPath bezierPath];
    [moutainOne moveToPoint:CGPointMake(0, kScreenHeight2 - 120)];
    [moutainOne addLineToPoint:CGPointMake(100, 100)];
    [moutainOne addLineToPoint:CGPointMake(kScreenWidth2 / 3, kScreenHeight2 - 100)];
    [moutainOne addLineToPoint:CGPointMake(kScreenWidth2 / 1.5, kScreenHeight2 - 50)];
    
    [moutainOne moveToPoint:CGPointMake(0, kScreenHeight2)];
    moutain.path = moutainOne.CGPath;
    moutain.fillColor = [UIColor whiteColor].CGColor;
    [self.backV.layer addSublayer:moutain];
    
    //第一座山下半部分
    CAShapeLayer *mountainOneLayer = [CAShapeLayer layer];
    UIBezierPath *pathLayerOne = [UIBezierPath bezierPath];
    [pathLayerOne moveToPoint:CGPointMake(0, kScreenHeight2 - 120)];
    CGFloat pathOneHeight = [self getPoint:CGPointMake(0, kScreenHeight2 - 120) :CGPointMake(100, 100) :55];
    CGFloat pathTwoHeight = [self getPoint:CGPointMake(100, 100) :CGPointMake(kScreenWidth2 / 3, kScreenHeight2 - 100) :160];
    
    [pathLayerOne addLineToPoint:CGPointMake(55, pathOneHeight)];
    [pathLayerOne addLineToPoint:CGPointMake(70, pathOneHeight + 15)];
    [pathLayerOne addLineToPoint:CGPointMake(90, pathOneHeight)];
    [pathLayerOne addLineToPoint:CGPointMake(110, pathOneHeight + 25)];
    [pathLayerOne addLineToPoint:CGPointMake(130, pathOneHeight - 5)];
    [pathLayerOne addLineToPoint:CGPointMake(160, pathTwoHeight)];
    
    [pathLayerOne addLineToPoint:CGPointMake(kScreenWidth2 / 3 , kScreenHeight2 -100)];
    [pathLayerOne addLineToPoint:CGPointMake(kScreenWidth2 / 1.5 , kScreenHeight2 -50)];
    [pathLayerOne addLineToPoint:CGPointMake(0, kScreenHeight2)];
    mountainOneLayer.path = pathLayerOne.CGPath;
    mountainOneLayer.fillColor = [UIColor colorWithRed:104.0/255.0 green:92.0/255.0 blue:157.0/255.0 alpha:1].CGColor;
    [self.backV.layer addSublayer:mountainOneLayer];
    
    //第二座山上半部分
    CAShapeLayer *mountainTwoLayer = [CAShapeLayer layer];
    UIBezierPath *pathLayerOneTwo = [UIBezierPath bezierPath];
    [pathLayerOneTwo moveToPoint:CGPointMake(kScreenWidth2 /4, kScreenHeight2 - 90)];

    [pathLayerOneTwo addLineToPoint:CGPointMake(kScreenWidth2 /2.7, 200)];
    [pathLayerOneTwo addLineToPoint:CGPointMake(kScreenWidth2 /1.8, kScreenHeight2 - 85)];
    [pathLayerOneTwo addLineToPoint:CGPointMake(kScreenWidth2 /1.6, kScreenHeight2 - 125)];
    [pathLayerOneTwo addLineToPoint:CGPointMake(kScreenWidth2 /1.35, kScreenHeight2 - 70)];
    [pathLayerOneTwo addLineToPoint:CGPointMake(0, kScreenHeight2)];
    mountainTwoLayer.path = pathLayerOneTwo.CGPath;
    mountainTwoLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.backV.layer insertSublayer:mountainTwoLayer below:moutain];

    //第二座山下半部分
    CAShapeLayer *mountainTwoLayer2 = [CAShapeLayer layer];
    UIBezierPath *pathLayerOneTwo2 = [UIBezierPath bezierPath];
    [pathLayerOneTwo2 moveToPoint:CGPointMake(0, kScreenHeight2)];
    [pathLayerOneTwo2 addLineToPoint:CGPointMake(kScreenWidth2 /4, kScreenHeight2 - 90)];
    pathOneHeight = [self getPoint:CGPointMake(kScreenWidth2 /4, kScreenHeight2 -90) :CGPointMake(kScreenWidth2 /2.7, 200) :kScreenWidth2 / 4+50];
    pathTwoHeight = [self getPoint:CGPointMake(kScreenWidth2 /1.8, kScreenHeight2 -85) :CGPointMake(kScreenWidth2 /2.7, 200) :kScreenWidth2 /2.2];
    
    CGFloat pathThreeHeight = [self getPoint:CGPointMake(kScreenWidth2 /1.8, kScreenHeight2 -85) :CGPointMake(kScreenWidth2 /1.6, kScreenHeight2 -125) :kScreenWidth2 / 1.67];
    CGFloat pathFourHeight = [self getPoint:CGPointMake(kScreenWidth2 /1.35, kScreenHeight2 -70) :CGPointMake(kScreenWidth2 /1.6, kScreenHeight2 -125) :kScreenWidth2 /1.50];
    [pathLayerOneTwo2 addLineToPoint:CGPointMake(kScreenWidth2 /4+50, pathOneHeight)];
    [pathLayerOneTwo2 addLineToPoint:CGPointMake(kScreenWidth2 /4+70, pathOneHeight + 15)];
    [pathLayerOneTwo2 addLineToPoint:CGPointMake(kScreenWidth2 /4+90, pathOneHeight)];
    [pathLayerOneTwo2 addLineToPoint:CGPointMake(kScreenWidth2 /4+110, pathOneHeight + 15)];
    [pathLayerOneTwo2 addLineToPoint:CGPointMake(kScreenWidth2 /2.2, pathTwoHeight)];
    [pathLayerOneTwo2 addLineToPoint:CGPointMake(kScreenWidth2 /1.8, kScreenHeight2 - 85)];
     [pathLayerOneTwo2 addLineToPoint:CGPointMake(kScreenWidth2 /1.67, pathThreeHeight)];
     [pathLayerOneTwo2 addLineToPoint:CGPointMake(kScreenWidth2 /1.65, pathThreeHeight +5)];
     [pathLayerOneTwo2 addLineToPoint:CGPointMake(kScreenWidth2 /1.60, pathThreeHeight - 2)];
     [pathLayerOneTwo2 addLineToPoint:CGPointMake(kScreenWidth2 /1.58, pathFourHeight + 2)];
    [pathLayerOneTwo2 addLineToPoint:CGPointMake(kScreenWidth2 /1.55, pathFourHeight  - 5)];
    [pathLayerOneTwo2 addLineToPoint:CGPointMake(kScreenWidth2 /1.50, pathFourHeight)];
    [pathLayerOneTwo2 addLineToPoint:CGPointMake(kScreenWidth2 /1.35,kScreenHeight2  - 70)];
    [pathLayerOneTwo2 addLineToPoint:CGPointMake(0, kScreenHeight2)];
    mountainTwoLayer2.path = pathLayerOneTwo2.CGPath;
    mountainTwoLayer2.fillColor = [UIColor colorWithRed:75.0/255.0 green:65.0/255.0 blue:111.0/255.0 alpha:1].CGColor;
    [self.backV.layer insertSublayer:mountainTwoLayer2 below:moutain];
    //初始化 草坪
    
    //第一块草坪
    self.shapeLayer = [CAShapeLayer layer];
    //通过贝塞尔曲线绘制路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, kScreenWidth - 20)];//设置曲线的起点
    [path addLineToPoint:CGPointMake(0, kScreenWidth - 100)];//连线到某点
    [path addQuadCurveToPoint:CGPointMake(kScreenHeight / 3.0, kScreenWidth - 20) controlPoint:CGPointMake(kScreenHeight / 6.0, kScreenWidth - 100)];//设置终点和控制点,控制点越小绘制的图形越大越高
    
    self.shapeLayer.path = path.CGPath;
    self.shapeLayer.fillColor = [UIColor colorWithRed:82.0/255.0 green:177.0/255.0 blue:44.0/255.0 alpha:1.0].CGColor;//设置填充色
    [self.backV.layer addSublayer:self.shapeLayer];
    
    //第二块草坪
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(0, kScreenWidth - 20)];
    [path2 addQuadCurveToPoint:CGPointMake(kScreenHeight, kScreenWidth - 60) controlPoint:CGPointMake(kScreenHeight / 2.0, kScreenWidth - 150)];
    [path2 addLineToPoint:CGPointMake(kScreenHeight, kScreenWidth - 20)];
    shapeLayer2.path = path2.CGPath;

    shapeLayer2.fillColor = [UIColor colorWithRed:92.0/255.0 green:195.0/255.0 blue:52.0/255.0 alpha:1.0].CGColor;
    [self.backV.layer addSublayer:shapeLayer2];
    
    
    
    //初始化大地
    CALayer *layerLand = [CALayer layer];
    layerLand.frame = CGRectMake(0, kScreenHeight2 - 20, kScreenWidth2, 20);
    layerLand.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"land"]].CGColor;//注：如果给CALayer设置color或imaeg属性时，需要将color转换为CGColor，image转换为CGImage，不然图片或颜色不显示---
    [self.backV.layer addSublayer:layerLand];
    
    //初始化黄色轨道
    
    self.yellow = [CAShapeLayer layer];
    self.yellow.backgroundColor = [UIColor redColor].CGColor;
    self.yellow.lineWidth = 5;
    self.yellow.strokeColor = [UIColor colorWithRed:210.0/255.0 green:179.0/255.0 blue:54.0/255.0 alpha:1].CGColor;
    UIBezierPath *yellowPath = [UIBezierPath bezierPath];
    [yellowPath moveToPoint:CGPointMake(0, kScreenHeight2 - 70)];
    [yellowPath addCurveToPoint:CGPointMake(kScreenWidth2 / 1.5, 200) controlPoint1:CGPointMake(kScreenWidth2 / 6, kScreenHeight2 - 200) controlPoint2:CGPointMake(kScreenWidth2 / 2.5, kScreenHeight2 + 50)];
    [yellowPath addQuadCurveToPoint:CGPointMake(kScreenWidth2 +10, kScreenHeight2 / 3) controlPoint:CGPointMake(kScreenWidth2 - 100, 50)];
    [yellowPath addLineToPoint:CGPointMake(kScreenWidth2 + 10, kScreenHeight2 + 10)];
    [yellowPath addLineToPoint:CGPointMake(0, kScreenHeight2 + 10)];
    self.yellow.fillColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"yellow"]].CGColor;
    self.yellow.path = yellowPath.CGPath;
    [self.backV.layer insertSublayer:self.yellow below:layerLand];
    
    CAShapeLayer *yellowLine = [CAShapeLayer layer];
    
    yellowLine.lineCap = kCALineCapRound;
    yellowLine.strokeColor = [UIColor whiteColor].CGColor;
    yellowLine.lineDashPattern = @[[[NSNumber alloc] initWithInt:INT32_C(1)],[[NSNumber alloc] initWithInt:INT32_C(5)]];
//    [NSNumber.init(value: 1 as Int32),NSNumber.init(value: 5 as Int32)]
    yellowLine.lineWidth = 2;
    yellowLine.fillColor = [UIColor clearColor].CGColor;
    yellowLine.path = yellowPath.CGPath;
    [self.yellow addSublayer:yellowLine];
    
    //初始化蓝色轨道
    
    CAShapeLayer *blue = [CAShapeLayer layer];
    blue.backgroundColor = [UIColor redColor].CGColor;
    blue.lineWidth = 5;
    blue.strokeColor = [UIColor colorWithRed:0.0/255.0 green:147.0/255.0 blue:163.0/255.0 alpha:1].CGColor;
    blue.fillRule =  kCAFillRuleEvenOdd;//even-odd 奇偶判断规则，从任意一点出发 与边界交点个数为 奇数则表示在圆或者说图形内，如果为偶数表示在圆外或者说图形外
    
    UIBezierPath *bluePath  = [UIBezierPath bezierPath];
    bluePath.lineCapStyle = kCGLineCapRound;
    bluePath.lineJoinStyle = kCGLineCapRound;
    [bluePath  moveToPoint:CGPointMake(kScreenWidth2 +10, kScreenHeight2)];
    [bluePath addLineToPoint:CGPointMake(kScreenWidth2 + 10, kScreenHeight2 - 70)];
    [bluePath addQuadCurveToPoint:CGPointMake(kScreenWidth2 / 1.8, kScreenHeight2 - 70) controlPoint:CGPointMake(kScreenWidth2 - 120, 200)];
    [bluePath addArcWithCenter:CGPointMake(kScreenWidth2 / 1.9, kScreenHeight2 - 140) radius:70 startAngle:0.5*M_PI endAngle:2.5*M_PI clockwise:true];
    
    [bluePath addCurveToPoint:CGPointMake(0, kScreenHeight2 - 100) controlPoint1:CGPointMake(kScreenWidth2 /1.8 - 60, kScreenHeight2 - 60) controlPoint2:CGPointMake(150, kScreenHeight2 /2.3)];
    [bluePath addLineToPoint:CGPointMake(-100, kScreenHeight2 +10)];
    blue.fillColor = [UIColor clearColor].CGColor;
    blue.path = bluePath.CGPath;
    [self.backV.layer insertSublayer:blue below:layerLand];
//    [self.backV.layer addSublayer:blue];
    
    
    CAShapeLayer *blue2 = [CAShapeLayer layer];
    blue2.lineWidth = 5;
    blue2.strokeColor = [UIColor colorWithRed:0.0/255.0 green:147.0/255.0 blue:163.0/255.0 alpha:1].CGColor;
    blue2.fillRule =  kCAFillRuleEvenOdd;//even-odd 奇偶判断规则，从任意一点出发 与边界交点个数为 奇数则表示在圆或者说图形内，如果为偶数表示在圆外或者说图形外
    
    UIBezierPath *bluePath2  = [UIBezierPath bezierPath];
    bluePath2.lineCapStyle = kCGLineCapRound;
    bluePath2.lineJoinStyle = kCGLineCapRound;
    [bluePath2  moveToPoint:CGPointMake(kScreenWidth2 +10, kScreenHeight2)];
    [bluePath2 addLineToPoint:CGPointMake(kScreenWidth2 + 10, kScreenHeight2 - 70)];
    [bluePath2 addQuadCurveToPoint:CGPointMake(kScreenWidth2 / 1.8, kScreenHeight2 - 70) controlPoint:CGPointMake(kScreenWidth2 - 120, 200)];
    [bluePath2 addCurveToPoint:CGPointMake(0, kScreenHeight2 - 100) controlPoint1:CGPointMake(kScreenWidth2 /1.8 - 60, kScreenHeight2 - 60) controlPoint2:CGPointMake(150, kScreenHeight2 /2.3)];
    [bluePath2 addLineToPoint:CGPointMake(-100, kScreenHeight2 +10)];
    blue2.fillColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"green"]].CGColor;
    blue2.path = bluePath2.CGPath;
    [self.backV.layer insertSublayer:blue2 below:blue];
    
    CAShapeLayer *blueLine = [CAShapeLayer layer];
    
    blueLine.lineCap = kCALineCapRound;
    blueLine.strokeColor = [UIColor whiteColor].CGColor;
    blueLine.lineDashPattern = @[[[NSNumber alloc] initWithInt:INT32_C(1)],[[NSNumber alloc] initWithInt:INT32_C(5)]];
    //    [NSNumber.init(value: 1 as Int32),NSNumber.init(value: 5 as Int32)]
    blueLine.lineWidth = 2;
    blueLine.fillColor = [UIColor clearColor].CGColor;
    blueLine.path = bluePath2.CGPath;
    [blue addSublayer:blueLine];
    
    //添加黄色轨道和蓝色轨道的动画
    for (int i = 0; i <4;  i++) {
        NSLog(@"i================%d",i);

        [self addBlueAnimation:CACurrentMediaTime() + 0.07 * (long double )i];
        [self addYellowAnimation:CACurrentMediaTime() + 0.07 * (long double )i];
        
    }
    
    
    //初始化云朵
    CALayer *cloudLayer = [CALayer layer];
    cloudLayer.frame = CGRectMake(0, 0, 63, 20);
    UIImage *image = [UIImage imageNamed:@"cloud"];
    CGImageRef imageRef = image.CGImage;
    cloudLayer.contents = (__bridge id _Nullable)(imageRef);
//    cloudLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:cloudLayer];
    
    UIBezierPath *cloudPath = [UIBezierPath bezierPath];
    [cloudPath moveToPoint:CGPointMake(kScreenWidth2 + 63, 40)];
    [cloudPath addLineToPoint:CGPointMake(-63, 40)];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = cloudPath.CGPath;
    animation.duration = 40;
    animation.autoreverses = false;
    animation.repeatCount = MAXFLOAT;
    animation.calculationMode = kCAAnimationPaced;
    [cloudLayer addAnimation:animation forKey:@"position"];
    
    
    //添加太阳
    CALayer *sunLayer = [CALayer layer];
    sunLayer.frame = CGRectMake(50, 50, 50, 50);
    UIImage *sunImage = [UIImage imageNamed:@"太阳"];
    CGImageRef ref = sunImage.CGImage;
    sunLayer.contents = (__bridge id _Nullable) (ref);
    [self.view.layer addSublayer:sunLayer];
    
    
    //添加树
    
    
    NSArray *arr =   @[@5,@55,@75,@(kScreenWidth2/3+15),@(kScreenWidth2/3+25),@(kScreenWidth2-160)];
    NSArray *arr2 =  @[@10,@60,@(kScreenWidth2/3),@(kScreenWidth2-150)];
    NSArray *arr3 =  @[@(kScreenWidth2 - 210),@(kScreenWidth2-50)];
    NSArray *arrY3 = @[@(kScreenWidth2 - 750),@(kScreenWidth2-80)];
    for (int i = 0; i < 6; i++) {
        CALayer *treeLayer = [CALayer layer];
        
        CGFloat x =   [arr[i] floatValue];
        treeLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"tree"].CGImage);
        treeLayer.frame = CGRectMake(x, kScreenHeight2 - 43, 13, 23);
        [self.view.layer addSublayer:treeLayer];
    }
    for (int i = 0; i < 4; i++) {
        CALayer *treeLayer = [CALayer layer];
        
        CGFloat x =   [arr2[i] floatValue];
        treeLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"tree"].CGImage);
        treeLayer.frame = CGRectMake(x, kScreenHeight2 - 52, 18, 32);
        [self.view.layer addSublayer:treeLayer];
    }

    for (int i = 0; i < 2; i++) {
        CALayer *treeLayer = [CALayer layer];
        
        CGFloat x =   [arr3[i] floatValue];
        CGFloat y =   [arrY3[i] floatValue];
        treeLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"tree"].CGImage);
        treeLayer.frame = CGRectMake(x, y, 18, 32);
        [self.view.layer addSublayer:treeLayer];
    }
    
   }

-(CGFloat)getPoint:(CGPoint)pointOne :(CGPoint)pointTwo :(CGFloat)referenceX{

    CGFloat x1 = pointOne.x;
    CGFloat y1 = pointOne.y;
    CGFloat x2 = pointTwo.x;
    CGFloat y2 = pointTwo.y;
    CGFloat a,b;
    a = (y2 - y1)/(x2 - x1);
    b = y1 - a*x1;
    CGFloat y = a*referenceX+b;

    
    return y;
}



//添加蓝色轨迹动画
-(void)addBlueAnimation:(CFTimeInterval) begintime{
    
    NSLog(@"begintime===%f",begintime);

    CALayer *carLayer = [CALayer layer];
    carLayer.frame = CGRectMake(0, 0, 17, 11);
    UIImage *image = [UIImage imageNamed:@"othercar"];
    CGImageRef imageRef = image.CGImage;
    carLayer.contents = (__bridge id _Nullable)(imageRef);

    UIBezierPath *bluePath  = [UIBezierPath bezierPath];
    bluePath.lineCapStyle = kCGLineCapRound;
    bluePath.lineJoinStyle = kCGLineCapRound;
    [bluePath  moveToPoint:CGPointMake(kScreenWidth2 +10, kScreenHeight2 - 7)];
    [bluePath addLineToPoint:CGPointMake(kScreenWidth2 + 10, kScreenHeight2 - 77)];
    [bluePath addQuadCurveToPoint:CGPointMake(kScreenWidth2 / 1.8, kScreenHeight2 - 77) controlPoint:CGPointMake(kScreenWidth2 - 120, 193)];
    [bluePath addArcWithCenter:CGPointMake(kScreenWidth2 / 1.9, kScreenHeight2 - 140) radius:63 startAngle:0.5*M_PI endAngle:2.5*M_PI clockwise:true];
    
    [bluePath addCurveToPoint:CGPointMake(0, kScreenHeight2 - 107) controlPoint1:CGPointMake(kScreenWidth2 /1.8 - 60, kScreenHeight2 - 67) controlPoint2:CGPointMake(150, kScreenHeight2 /2.3 -7)];
    [bluePath addLineToPoint:CGPointMake(-100, kScreenHeight2 +7)];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];//简单的创建一个带路径的动画效果，比较粗糙
    animation.path = bluePath.CGPath;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];//CAMediaTiming协议定义了在一段动画内用来控制逝去时间的属性的集合，CALayer和CAAnimation都实现了这个协议，所以时间可以被任意基于一个图层或者一段动画的类控制。
    //      速度控制函数(CAMediaTimingFunction)
    //    1.kCAMediaTimingFunctionLinear（线性）：匀速，给你一个相对静态的感觉
    //    2.kCAMediaTimingFunctionEaseIn（渐进）：动画缓慢进入，然后加速离开
    //    3.kCAMediaTimingFunctionEaseOut（渐出）：动画全速进入，然后减速的到达目的地
    //    4.kCAMediaTimingFunctionEaseInEaseOut（渐进渐出）：动画缓慢的进入，中间加速，然后减速的到达目的地。这个是默认的动画行为。
    animation.duration = 6;//动画持续时间
    animation.beginTime = begintime;
    animation.repeatCount = MAXFLOAT;//循环次数
    animation.autoreverses =false;//自动翻转
    animation.calculationMode = kCAAnimationCubicPaced;//自动计算
    animation.rotationMode = kCAAnimationRotateAuto;//动画角度自动调整
    [self.view.layer addSublayer:carLayer];
    [carLayer addAnimation:animation forKey:@"carAnimation"];




}



 //添加黄色轨迹动画
-(void)addYellowAnimation:(CFTimeInterval )beginTime{

    
   
    CALayer *carLayer = [CALayer layer];
    carLayer.frame = CGRectMake(0, 0, 17, 11);
    carLayer.affineTransform = CGAffineTransformTranslate(carLayer.affineTransform, 0, -7);
    UIImage *image = [UIImage imageNamed:@"car"];
    CGImageRef imageRef = image.CGImage;
    carLayer.contents = (__bridge id _Nullable)(imageRef);
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];//简单的创建一个带路径的动画效果，比较粗糙
    animation.path = self.yellow.path;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];//CAMediaTiming协议定义了在一段动画内用来控制逝去时间的属性的集合，CALayer和CAAnimation都实现了这个协议，所以时间可以被任意基于一个图层或者一段动画的类控制。
    //      速度控制函数(CAMediaTimingFunction)
    //    1.kCAMediaTimingFunctionLinear（线性）：匀速，给你一个相对静态的感觉
    //    2.kCAMediaTimingFunctionEaseIn（渐进）：动画缓慢进入，然后加速离开
    //    3.kCAMediaTimingFunctionEaseOut（渐出）：动画全速进入，然后减速的到达目的地
    //    4.kCAMediaTimingFunctionEaseInEaseOut（渐进渐出）：动画缓慢的进入，中间加速，然后减速的到达目的地。这个是默认的动画行为。
    animation.duration = 6;//动画持续时间
    animation.beginTime = beginTime;
    animation.repeatCount = MAXFLOAT;
    animation.autoreverses =false;
    animation.calculationMode = kCAAnimationCubicPaced;//自动计算
    animation.rotationMode = kCAAnimationRotateAuto;//旋转
    [self.view.layer addSublayer:carLayer];
    [carLayer addAnimation:animation forKey:@"carAnimation"];
}

-(void)clickBtn:(UIButton *)sender{
  
    
    
    for (int i = 0; i < 10; i++) {
        NSString *str = [NSString stringWithFormat:@"这是添加的第%d个数据！！！！",i];
        [self.cache setObject:str forKey:@(i)];
        
    }

}

-(void)checkBtn:(UIButton *)sender{


    for (int i = 0; i <self.cache.totalCostLimit; i++) {
        NSString *str = [self.cache objectForKey:@(i)];
        NSLog(@"缓存的数据为----%d-----%@",i,str);
    }

}
-(void)deleteBtn:(UIButton *)sender{
    
    
    [self.cache removeAllObjects];
    
}


#pragma mark - wkwebview 代理方法
//页面开始加载调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"--------开始加载----------thread=%@",[NSThread currentThread]);
    
    
}
//当内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"--------开始返回----------");

}
//页面加载完成时调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"--------加载完成----------");

}
//页面加载失败时调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"--------加载失败----------error=%@",error);


}
//接收到服务器请求跳转
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"--------跳转----------");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSCache *)cache{

    if (!_cache) {
        _cache = [[NSCache alloc]init];
        _cache.totalCostLimit = 10;
    }
 
    return _cache;

}
@end
