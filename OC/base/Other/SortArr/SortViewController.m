//
//  SortViewController.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 15/12/1.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import "SortViewController.h"
#import "ChineseString.h"

NSString *const xMyNeedContentNotification = @"xMyNeedContentNotification";

#define RATIOWIDTH self.view.frame.size.width/320
#define SHOW_HINT_INTERNAL 0.5
#define HEADER_SECTION_HEIGHT 20*RATIOWIDTH

@interface SortViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *sortTable;
@property (nonatomic, assign) NSInteger requireType; //标识数据的类型
@property (nonatomic, strong) NSString *navigationTitle; //标题
@property (nonatomic, strong) NSMutableArray *sortArray; //数据源

@end

@implementation SortViewController {
    NSMutableArray *_headerSectionArr;
    NSIndexPath *_needIndexPath;
    UIBarButtonItem *_submitItem;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildLayout];
}

#pragma mark -
#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sortArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_sortArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //coding...
    
//    NSLog(@"section = %ld, row = %ld", indexPath.section, indexPath.row);
//    NSLog(@"---section = %ld, ---row = %ld", _needIndexPath.section, _needIndexPath.row);
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (_needIndexPath.section == indexPath.section && _needIndexPath.row == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    cell.textLabel.text = [_sortArray[indexPath.section] objectAtIndex:indexPath.row];
    cell.tag = indexPath.row;
    
    return cell;
}

//头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *indexLbl = [[UILabel alloc] init];
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, self.view.frame.size.width, HEADER_SECTION_HEIGHT);
    view.backgroundColor = [UIColor colorWithWhite:0.875 alpha:1.000];
    
    indexLbl.frame = CGRectMake(10, 0, self.view.frame.size.width, HEADER_SECTION_HEIGHT);
    indexLbl.textAlignment = NSTextAlignmentLeft;
    indexLbl.font = [UIFont systemFontOfSize:14.0*RATIOWIDTH];
    indexLbl.textColor = [UIColor blackColor];
    [view addSubview:indexLbl];
    
    if (_headerSectionArr.count) {
        if (_headerSectionArr.count == 1) {
            return nil;
        }
        
        indexLbl.text = _headerSectionArr[section];
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_headerSectionArr.count == 1) {
        return 0;
    }
    
    return HEADER_SECTION_HEIGHT;
}

//添加索引列
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (_headerSectionArr.count == 1) {
        return nil;
    }
    
    return _headerSectionArr;
}

//响应点击索引时的委托方法
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    UILabel *hint = [self.view viewWithTag:1029];
    hint.hidden = NO;
    hint.text = title;
    [self performSelector:@selector(hideHintAction:) withObject:hint afterDelay:SHOW_HINT_INTERNAL];
    
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
     atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    return index;
}

- (void)hideHintAction:(UILabel *)lbl {
    lbl.hidden = YES;
}

//选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        _needIndexPath = indexPath;
        [self submitResult];
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self removeSubmitItem];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}

#pragma mark - action
- (void)loadHintView {
    UILabel *hint = [[UILabel alloc] init];
    hint.frame = CGRectMake(0, 0, 100*RATIOWIDTH, 100*RATIOWIDTH);
    hint.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    hint.textColor = [UIColor whiteColor];
    hint.clipsToBounds = YES;
    hint.layer.cornerRadius = 5.0;
    hint.backgroundColor = [UIColor blackColor];
    hint.textAlignment = NSTextAlignmentCenter;
    hint.font = [UIFont systemFontOfSize:60.0*RATIOWIDTH];
    hint.hidden = YES;
    hint.tag = 1029;
    [self.view addSubview:hint];
}

//确定
- (void)submitItemAction {
    //选择的内容以及内容类型
    NSDictionary *needDict = @{@"content":_sortArray[_needIndexPath.section][_needIndexPath.row], @"type":@(_requireType)};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:xMyNeedContentNotification object: needDict];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - build layout
- (void)buildLayout {
    _headerSectionArr = [NSMutableArray array];
    _sortArray = [NSMutableArray array];
    _needIndexPath = [NSIndexPath indexPathForRow:-1 inSection:-1];
//    NSLog(@"section = %ld, row = %ld", _needIndexPath.section, _needIndexPath.row);
    
    [self.view addSubview:self.sortTable];
    
    [self loadHintView];
//    [self submitResult];
}

//确定选择的结果
- (void)submitResult {
    _submitItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(submitItemAction)];
    self.navigationItem.rightBarButtonItem = _submitItem;
}

//移除提交按钮
- (void)removeSubmitItem {
    self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark - getter
- (UITableView *)sortTable {
    if (_sortTable == nil) {
        _sortTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _sortTable.delegate = self;
        _sortTable.dataSource = self;
        
        _sortTable.showsHorizontalScrollIndicator = NO;
        _sortTable.showsVerticalScrollIndicator = NO;
        _sortTable.allowsSelection=YES;
        _sortTable.sectionIndexColor = [UIColor blueColor];
        _sortTable.sectionIndexBackgroundColor = [UIColor clearColor];
        
        _sortTable.tableFooterView = [[UIView alloc] init];
    }
    return _sortTable;
}

#pragma mark - source
- (BOOL)sortWithArray:(NSArray *)sortArray title:(NSString *)navigatioinTitle type:(NSInteger)requrieType {
    if (!sortArray.count || !navigatioinTitle.length || requrieType < 0) {
        NSLog(@"排序分组的参数填写不完整..");
        return NO;
    }
    
    self.navigationItem.title = navigatioinTitle; //标题
    _requireType = requrieType; //数据类型
    _sortArray = [NSMutableArray arrayWithArray:sortArray]; //数据源
    [self sortArray:_sortArray]; //排序分组
    
    return YES;
}

//数据源
- (void)sortArray:(NSMutableArray *)sortArray {
    if (!sortArray.count) return;
    
    //排序分组(0 内容和1 索引)
    NSArray *needArr = [ChineseString sortArray:sortArray];
    
    if (needArr.count == 2) {
        _sortArray = [ChineseString letterSortArray:needArr[0]];
        _headerSectionArr = needArr[1];
        
#if 1
        //若有'#',放在最后一位
        if ([_headerSectionArr[0] isEqualToString:@"#"]) {
            //首尾对调
            NSArray *firstArr = [_sortArray firstObject];
            [_sortArray removeObjectAtIndex:0];
            [_sortArray addObject:firstArr];
            
            NSString *firstArr1 = [_headerSectionArr firstObject];
            [_headerSectionArr removeObjectAtIndex:0];
            [_headerSectionArr addObject:firstArr1];
        }
#endif
        
        [_sortTable reloadData];//更新数据
    }
    else {
        NSLog(@"没有数据源..请检查!");
    }
}

#pragma mark - dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:xMyNeedContentNotification object:nil];
}

#pragma mark - other
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
