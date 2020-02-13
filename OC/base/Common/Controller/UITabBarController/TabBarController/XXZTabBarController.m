//
//  XXZTabBarController.m
//  Zachary
//
//  Created by Zachary on 2018/6/9.
//  Copyright © 2018年 Zachary. All rights reserved.
//

#import "XXZTabBarController.h"

//#import "XXZTabBarButton.h"
#import "XXZTabBar.h"

@interface XXZTabBarController () <XXZTabBarDelegate>

//设置之前选中的按钮
@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation XXZTabBarController

#pragma mark - Zachary - view will appear & disappear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //coding...
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    for (UIView *child in self.tabBar.subviews) {
        if (![child isKindOfClass:[XXZTabBar class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //根据有多少个子视图控制器来进行添加按钮 self.viewControllers.count
    [self loadTabBarWithCount];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //coding...
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildLayout];
}

#pragma mark - build layout
- (void)buildLayout {
    
}

#pragma mark - custom tabr bar controller
#pragma mark - XXZTabBarDelegate
- (void)tabBar:(XXZTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;
}

#pragma mark - action
#if 0
//自定义TabBar的按钮点击事件
- (void)clickBtn:(UIButton *)button {
    //1.先将之前选中的按钮设置为未选中
    self.selectedBtn.selected = NO;
    //2.再将当前按钮设置为选中
    button.selected = YES;
    //3.最后把当前按钮赋值为之前选中的按钮
    self.selectedBtn = button;
    
    //4.跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
    self.selectedIndex = button.tag;
}
#endif

#pragma mark - loading
- (void)loadTabBarWithCount {
    NSInteger count = [[self selectImage] count];
    
    //删除现有的tabBar
    CGRect rect = self.tabBar.bounds;
    rect.size.height+=Safe_Bottom_H;
    
//    [self.tabBar removeFromSuperview];  //移除TabBarController自带的标签栏
//    [self.tabBar.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //去掉线
    [self.tabBar setShadowImage:[XXZImageColor imageByColor:ClearColor size:CGSizeMake(SCREEN_WIDTH, 1)]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    
    //测试添加自己的视图
    _tabBarView = [[XXZTabBar alloc] init];
    [self.tabBar addSubview:_tabBarView];
    
    _tabBarView.frame = rect;
    _tabBarView.delegate = self;
    _tabBarView.backgroundColor = [UIColor whiteColor];
    ViewShadow(_tabBarView, 0.3, [BlackColor colorWithAlphaComponent:0.2], 5, CGSizeMake(0, -5));
    
    //为控制器添加按钮
    for (int i=0; i<count; i++) {
        _tabBarView.tag = i;
        
        NSString *imageName = [self selectImage][i]; //[NSString stringWithFormat:@"bt2"];
        NSString *imageNameSel = [self deselectImage][i]; //[NSString stringWithFormat:@"bt"];
        
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *imageSel = [UIImage imageNamed:imageNameSel];
        
        //传入已选和未选的图片
        [_tabBarView addButtonWithImage:image selectedImage:imageSel];
    }
}

#pragma mark - getter


#pragma mark - setter
- (void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed {
    self.tabBarView.hidden = hidesBottomBarWhenPushed;
}

#pragma mark - dealloc
- (void)dealloc {
    
}

#pragma mark - other
- (NSArray *)selectImage {
    NSArray *arr = @[@"bt2", @"bt2", @"bt2"];
    
    return arr;
}

- (NSArray *)deselectImage {
    NSArray *arr = @[@"bt", @"bt", @"bt"];
    
    return arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
