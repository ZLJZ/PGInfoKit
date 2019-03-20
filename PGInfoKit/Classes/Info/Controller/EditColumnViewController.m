//
//  EditColumnViewController.m
//  PanGu
//  编辑栏目界面
//  Created by 吴肖利 on 16/9/18.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import "EditColumnViewController.h"
#import "EditColumnTableViewCell.h"
#import "InfoCalculate.h"
#import "PGInfo.h"


@interface EditColumnViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dateSource;
@property (nonatomic, strong) NSMutableArray *topDataSource;
@property (nonatomic, strong) NSMutableArray *bottomDataSource;
@property (nonatomic, strong) NSMutableArray *isSelected;
@property (nonatomic, strong) UIView *headView;


@end

@implementation EditColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isSelected = [[NSMutableArray alloc]init];
    _topDataSource = [[NSMutableArray alloc]init];
    _bottomDataSource = [[NSMutableArray alloc]init];
    
    NSArray *arr = [InfoCalculate queryNewEditColumnUserDefaults];
    
    if (arr.count != 0) {
        for (NSInteger i = 0; i < [arr[0] count]; i ++ ) {
            NSArray *titleArr = arr[0][i];
            if ([[titleArr objectNAtIndex:2] isEqualToString:@"1"]) {
                [_topDataSource addObject:titleArr];
            } else if ([[titleArr objectNAtIndex:2] isEqualToString:@"0"]) {
                [_bottomDataSource addObject:titleArr];
                [_isSelected addObject:arr[1][i]];
            }
        }
    } else {
        _topDataSource = @[@[@"要闻",@"1"],@[@"直播",@"2"],@[@"独家研报",@"3"],@[@"红珊瑚资讯",@"4"]].mutableCopy;
    }
    
    [self customUI];
    [self createHeadView];
    [self createTableView];    
    
}

- (void)customUI {
    [self addRightBtWithTitle:@"完成" color:TXSakuraColor(CommonPageLabelTextColor1) font:15 offSet:0];
    self.navigationItem.title = @"编辑栏目";
}

- (void)createTableView {
    _tableView = [UITableView addTableViewFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NAV_HEIGHT) style:UITableViewStyleGrouped delegate:self emptyDelegate:self superView:self.view];
    _tableView.tableHeaderView = _headView;
    _tableView.sakura.separatorColor(CommonSpaceLineUnfullColor);
    [_tableView setEditing:YES animated:YES];
}

- (void)createHeadView {
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 55*_topDataSource.count)];
    _headView.sakura.backgroundColor(CommonListContentContentBackColor);
    for (NSInteger i = 0; i < _topDataSource.count; i ++ ) {//i<3替换i<2
        UIView *view = [self topViewTopY:i*55 title:_topDataSource[i][0] subTitle:@""];
        [_headView addSubview:view];
    }
}

- (void)rightAction {
    
    NSArray *arr = [InfoCalculate queryNewEditColumnUserDefaults];
    
    if (arr.count != 0) {
        NSMutableArray *unselectedArr = [[NSMutableArray alloc]init];
        NSMutableArray *titleArr = [[NSMutableArray alloc]init];
        NSMutableArray *isSelectedArr = [[NSMutableArray alloc]init];
        
        for (NSInteger i = 0; i < _topDataSource.count; i ++ ) {
            [titleArr addObject:_topDataSource[i]];
            [isSelectedArr addObject:[NSNumber numberWithBool:YES]];
        }
        
        for (NSInteger i = 0; i < _bottomDataSource.count; i ++ ) {
            BOOL selectState = [[_isSelected objectAtIndex:i] boolValue];
            if (selectState == YES) {
                [titleArr addObject:_bottomDataSource[i]];//选中的title数组
                [isSelectedArr addObject:[NSNumber numberWithBool:YES]];//选中的图标
            } else {
                [unselectedArr addObject:_bottomDataSource[i]];//未选中的title数组
            }
        }
        for (NSInteger i = 0; i < unselectedArr.count; i ++ ) {
            [titleArr addObject:unselectedArr[i]];//存放选中和未选中的title数组
            [isSelectedArr addObject:[NSNumber numberWithBool:NO]];//存放选中和未选中的图标
        }
        NSMutableArray *titleAndIsSelectedArr = @[titleArr,isSelectedArr].mutableCopy;
        [InfoCalculate saveNewEditColumnUserDefaults:titleAndIsSelectedArr];
    }
    _EditBlock(YES);
    [self.navigationController popViewControllerAnimated:YES];    
}

- (void)userDefaults:(NSMutableArray *)arr {
    NSUserDefaults *editDefaults = [NSUserDefaults standardUserDefaults];
    [editDefaults setValue:arr forKey:NEWEditColumn];
    [editDefaults synchronize];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _bottomDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EditColumnTableViewCell *cell = [EditColumnTableViewCell editColumnTableViewCell:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.leftImageButton.selected = [_isSelected[indexPath.row] boolValue];
    cell.leftImageButton.tag = 77889977+indexPath.row;
    if (cell.leftImageButton.selected == NO) {
        cell.leftImageView.image = ImageNamed(@"duigouhuibig");
    } else {
        cell.leftImageView.image = ImageNamed(@"duigouhongbig");
    }
    [cell.leftImageButton addTarget:self action:@selector(clickLeftImageButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.topLabel.text = _bottomDataSource[indexPath.row][0];
    cell.rightButton.hidden = YES;
    return cell;
}

- (void)clickLeftImageButton:(UIButton *)sender {

    for (NSInteger i = 0 ;i < _isSelected.count;i ++) {
        if (i == sender.tag-77889977) {
            BOOL selectState = [[_isSelected objectAtIndex:sender.tag-77889977] boolValue];
            [_isSelected replaceObjectAtIndex:sender.tag-77889977 withObject:[NSNumber numberWithInt:!selectState]];
        }

    }

    [_tableView reloadData];
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return NO;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSArray *titleArray = _bottomDataSource[sourceIndexPath.row];
    NSNumber *temp = _isSelected[sourceIndexPath.row];

    [_bottomDataSource removeObjectAtIndex:sourceIndexPath.row];
    [_isSelected removeObjectAtIndex:sourceIndexPath.row];
    [_bottomDataSource insertObject:titleArray atIndex:destinationIndexPath.row];
    [_isSelected insertObject:temp atIndex:destinationIndexPath.row];

    [_tableView reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)topViewTopY:(CGFloat)topY title:(NSString *)title subTitle:(NSString *)subTitle{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, topY, kScreenWidth, 55)];
    view.sakura.backgroundColor(CommonListContentContentBackColor);
    UIButton *leftImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftImageButton.frame = CGRectMake(15, (55-19)/2, 19, 19);
    leftImageButton.hidden = YES;
    [leftImageButton setImage:ImageNamed(@"duigouhui") forState:UIControlStateNormal];
    [view addSubview:leftImageButton];
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftImageButton.right+10, 0, kScreenWidth-(leftImageButton.right+10+20), 55)];
    topLabel.sakura.textColor(CommonListContentRemarkTextColor);
    topLabel.text = title;
    topLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:topLabel];    
    UIView *singleView = [[UIView alloc]initWithFrame:CGRectMake(15, 55-KSINGLELINE_WIDTH, kScreenWidth-12, KSINGLELINE_WIDTH)];
    singleView.sakura.backgroundColor(CommonSpaceLineUnfullColor);
    [view addSubview:singleView];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
