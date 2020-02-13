//
//  XXZNavigationController.m
//  Zachary
//
//  Created by Zachary on 2017/4/27.
//  Copyright © 2017年 Zachary. All rights reserved.
//

#import "XXZNavigationController.h"

@interface XXZNavigationController ()

@end

@implementation XXZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIBarButtonItem *back = [[UIBarButtonItem alloc] init];
    back.title = @"";
    viewController.navigationItem.backBarButtonItem = back;
    
    self.navigationBar.tintColor = UICOLOR_DARK;
    [self.navigationBar setTitleTextAttributes: @{
                                                  NSFontAttributeName:FONT_S(16),
                                                  NSForegroundColorAttributeName:UICOLOR_DARK}];
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    return [super popToViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [super popToRootViewControllerAnimated:animated];
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
