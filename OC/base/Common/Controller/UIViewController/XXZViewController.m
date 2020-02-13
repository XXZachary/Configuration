//
//  XXZViewController.m
//  Zachary
//
//  Created by Zachary on 2017/4/12.
//  Copyright © 2017年 Zachary. All rights reserved.
//

#import "XXZViewController.h"

@interface XXZViewController ()

@end

@implementation XXZViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initData];
    }
    
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initData];
    }
    
    return self;
}

- (void)initData {
    self.needHiddenBackButton = NO; //默认不隐藏
    
    [[UITableView appearance] setSectionFooterHeight:0.01];
    [[UITableView appearance] setSectionHeaderHeight:0.01];
}

#pragma mark - Zachary - view will appear & disappear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //coding...
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //coding...
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildKinBaseLayout];
}


#pragma mark - Zachary -


#pragma mark - Zachary - notification action


#pragma mark - Zachary - action
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Zachary - build layout
- (void)buildKinBaseLayout {
    if(!self.needHiddenBackButton){
        [self customBackBtn];
    }
}

#pragma mark - Zachary - loading
- (void)customBackBtn {
    //自定义返回按钮
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage qmui_imageWithShape:QMUIImageShapeNavBack size:CGSizeMake(9, 16) tintColor:BLACK_COLOR] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
}

#pragma mark - Zachary - getter


#pragma mark - Zachary - setter


#pragma mark - Zachary - method
- (void)showAlertWithTitle:(NSString *)title content:(NSString *)content action1Title:(NSString *)action1Title action2Title:(NSString *)action2Title action1Block:(void (^)(void))action1Block action2Block:(void (^)(void))action2Block {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    if (!action1Title.length && !action2Title.length) {
        return;
    }
    if (action1Title.length) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:action1Title style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            action1Block();
        }];
        [alert addAction:action1];
    }
    if (action2Title.length) {
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:action2Title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            action2Block();
        }];
        [alert addAction:action2];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

//- (void)showQMUIAlertWithTitle:(NSString *)title content:(NSString *)content action1Title:(NSString *)action1Title action2Title:(NSString *)action2Title action1Block:(void (^)(void))action1Block action2Block:(void (^)(void))action2Block {
//    QMUIAlertController *alert = [QMUIAlertController alertControllerWithTitle:title message:content preferredStyle:QMUIAlertControllerStyleAlert];
//    if (!action1Title.length && !action2Title.length) {
//        return;
//    }
//    if (action1Title.length) {
//
//        QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:action1Title style:QMUIAlertActionStyleCancel handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action) {
//            action1Block();
//        }];
//        [alert addAction:action1];
//    }
//    if (action2Title.length) {
//        QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:action2Title style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action) {
//            action2Block();
//        }];
//        [alert addAction:action2];
//    }
//    [alert showWithAnimated:YES];
//}

#pragma mark - Zachary - server


#pragma mark - Zachary - system


#pragma mark - Zachary - dealloc
- (void)dealloc {
    
}

#pragma mark - Zachary - other
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
