//
//  FunctionIntroduceView.m
//  发发啦
//
//  Created by gxtc on 2017/8/14.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "FunctionIntroduceView.h"
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation FunctionIntroduceView


- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
    }

    return self;

}


- (void)drawRect:(CGRect)rect{


    [self addMask];
    
    
    UILabel * label = [[UILabel alloc]initWithFrame: CGRectMake(20, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_WIDTH/15)];
    label.text = @"新功能在这里哦！";
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    
    
    UILabel * label1 = [[UILabel alloc]initWithFrame: CGRectMake(20, SCREEN_HEIGHT/2 + SCREEN_WIDTH * 2/15, SCREEN_WIDTH, SCREEN_WIDTH/15)];
    label1.text = @"我知道啦！";
    label1.textColor = [UIColor whiteColor];
    [self addSubview:label1];
}


- (void)addMask{
    
    
    /*
    之前理解错误，mask不是遮罩，不是add到layer上的另一个layer，而是控制layer本身渲染的一个layer。
    效果是：比如imageLayer有一个maskLayer作为mask（注意maskLayer可以不跟imageLayer大小一样），
    那maskLayer透明的地方，imageLayer就不会渲染，而是变透明，显示出imageLayer之后的内容，
    maskLayer不透明的地方，imageLayer就会正常渲染，显示出imageLayer本来的内容
    如果maskLayer比imageLayer要小，那默认的maskLayer之外的地方都是透明的，都不会渲染。
    
    注意：作为mask的layer不能有superLayer或者subLayer！
    
    */
    
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.frame = self.bounds;
        backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        [self addSubview:backgroundView];
    
        // 创建一个全屏大的path
         UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
         // 创建一个圆形path
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x/2, self.center.y *3/2)radius:SCREEN_WIDTH/5 startAngle:0 endAngle:2 * M_PI clockwise:NO];
    
    
    //　UIBezierPath 有个原生的方法- (void)appendPath:(UIBezierPath *)bezierPath, 这个方法作用是俩个路径有叠加的部分则会镂空.
    //  这个方法实现原理应该是path的FillRule 默认是FillRuleEvenOdd(CALayer 有一个fillRule属性的规则就有kCAFillRuleEvenOdd), 而EvenOdd 是一个奇偶规则,奇数则显示,偶数则不显示.叠加则是偶数故不显示
    
         [path appendPath:circlePath];
    
         CAShapeLayer *shapeLayer = [CAShapeLayer layer];
         shapeLayer.path = path.CGPath;
    
         backgroundView.layer.mask = shapeLayer;

    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{


    [self removeFromSuperview];
}

@end
