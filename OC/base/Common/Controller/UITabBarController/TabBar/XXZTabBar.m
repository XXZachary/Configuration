//
//  XXZTabBar.m
//  Zachary
//
//  Created by Zachary on 2018/6/9.
//  Copyright © 2018年 Zachary. All rights reserved.
//

#import "XXZTabBar.h"
#import "XXZTabBarButton.h"

@interface XXZTabBar ()

//设置之前选中的按钮
@property (nonatomic, weak) XXZTabBarButton *selectedBtn;

@end

@implementation XXZTabBar

- (NSArray<UITabBarItem *> *)items {
    return @[];
}

// 重写，空实现
- (void)setItems:(NSArray<UITabBarItem *> *)items {
    
}

- (void)setItems:(NSArray<UITabBarItem *> *)items animated:(BOOL)animated {
    
}

#if 0
//在这个方法里写控件初始化的东西, 调用init方法时会调用
- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
      //添加按钮
      for (int i = 0; i < 5; i++) { //取消掉特定的数字
          //UIButton *btn = [[UIButton alloc] init];
          XXZTabBarButton *btn = [[XXZTabBarButton alloc] init];

          NSString *imageName = [NSString stringWithFormat:@"bt2"];
          NSString *imageNameSel = [NSString stringWithFormat:@"bt"];

          [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
          [btn setImage:[UIImage imageNamed:imageNameSel] forState:UIControlStateSelected];

          [self addSubview:btn];

          btn.tag = i; //设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图

          //带参数的监听方法记得加"冒号"
          [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];

          if (0 == i) {
              [self clickBtn:btn];
          }
      }
  }
  return self;
}
#endif

#pragma mark -
- (void)addButtonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    XXZTabBarButton *btn = [[XXZTabBarButton alloc] init];
    
    btn.img.image = image; //未选的图标
    btn.img.highlightedImage = selectedImage; //已选的图标
    btn.title.text = [self returnTabBarTitleName][self.tag]; //标签栏标题
    btn.title.textColor = [self deselectColor];
    
    [self addSubview:btn];
    
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //选中第一个
    if (self.subviews.count == 1) {
        [self clickBtn:btn];
    }
}

/**专门用来布局子视图*/
- (void)layoutSubviews {
    [super layoutSubviews];
    
    int count = (int)self.subviews.count;
    for (int i = 0; i < count; i++) {
        //取得按钮
        UIButton *btn = self.subviews[i];
        btn.tag = i; //设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图
        
        CGFloat x = i * self.bounds.size.width / count;
        CGFloat y = 0;
        CGFloat width = self.bounds.size.width / count;
        CGFloat height = self.bounds.size.height;
        btn.frame = CGRectMake(x, y, width, height);
    }
}

#pragma mark - action
//自定义TabBar的按钮点击事件
- (void)clickBtn:(XXZTabBarButton *)button {
    //1.先将之前选中的按钮设置为未选中
    self.selectedBtn.selected = NO;
    self.selectedBtn.img.highlighted = NO;
    self.selectedBtn.title.textColor = [self deselectColor];
    
    //2.再将当前按钮设置为选中
    button.selected = YES;
    button.img.highlighted = YES;
    button.title.textColor = [self selectColor];
    
    //3.最后把当前按钮赋值为之前选中的按钮
    self.selectedBtn = button;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag to:button.tag];
    }
    
    //4.跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
    //self.selectedIndex = button.tag;
}

#pragma mark - build layout
- (void)buildLayout {
    
}

#pragma mark - loading


#pragma mark - getter


#pragma mark - setter


#pragma mark - dealloc
- (void)dealloc {
    
}

#pragma mark - other
- (NSArray *)returnTabBarTitleName {
    return @[@"首页", @"预约", @"我的"];
}

- (UIColor *)selectColor {
    return UICOLOR_FROM(@"#303030");
}

- (UIColor *)deselectColor {
    return UICOLOR_FROM(@"#a3a3a3");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
