//
//  ViewController.m
//  6.11.UI.Class
//
//  Created by rimi on 15/6/11.
//  Copyright (c) 2015年 rectinajh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(strong, nonatomic) NSMutableArray            *dataSource;        //表格式图的数据源
@property(strong, nonatomic) UITableView               *tableView;         //表格视图

- (void)initializeDataSource;
- (void)initializeUserInterface;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initializeDataSource];
    [self initializeUserInterface];
}

#pragma mark - tabview的增删改查
- (void)initializeDataSource
{
//    //1,获取数据源
    self.dataSource = [[UIFont familyNames]mutableCopy];
//    //2,进行排序
    //[self.dataSource sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];//排好后放到另外数组
    [self.dataSource sortUsingSelector:@selector(caseInsensitiveCompare:)];
}


- (void)initializeUserInterface
{
    //1,创建tableview
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
    //2,设置属性
    
    self.tableView.dataSource = self;                                        //2.1 设置数据源
    self.tableView.delegate = self;                                          //2.6 设置代理
    
    //编辑状态下允许选择
    self.tableView.allowsSelectionDuringEditing = YES;
    
    //3,添加到父视图
    [self.view addSubview:self.tableView];
    
}


#pragma mark - UITableViewDataSource


//指定section中的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;//默认1
}

//指定一个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *indenty = @"CELL";                                             //1. 指定一个重用标识符，重用机制
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenty];  //2. 从重用队列中取出相应地cell
    
    //2.1  如果cell不存在
    if (!cell) {
        NSLog(@"%s",__func__);
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1      //2.2  创建一个以当前重用标识符的cell
                                     reuseIdentifier:indenty];
    }

    cell.textLabel.text = self.dataSource[indexPath.row];
    
//    cell.imageView.image = [UIImage imageNamed:@"9.jpg"];
    
    // 返回cell
    return cell;
}

- (IBAction)handleAddEvent:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入字体名" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //提示框属性
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    //显示
    [alertView show];
    
}

- (IBAction)handleChangeEvent:(id)sender {
    //1,对tableView进行是否编辑处理
    self.tableView.editing = !self.tableView.editing;
    //2,配置导航栏按钮的标题
    self.navigationItem.leftBarButtonItem.title = self.tableView.editing ? @"Done":@"Edit";
}


#pragma mark - UITabkeViewDelegate
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - UITableViewDelegate
//配置默认删除按钮的标题
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
//默认编辑风格
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//获取编辑状态
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__func__);
    //1，判断编辑风格是否删除
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //必须首先删除数据，然后在进行表格试图更新
        //删除数据源数据
        [self.dataSource removeObjectAtIndex:indexPath.row];
        //进行表格删除
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 配置每一行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

//移动行的时候进行调用
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //判断当前是否能移动

}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //确定按钮点击时候
    if (buttonIndex == 1) {
        //添加操作：1，获取字符串；2，添加数据源；3，更新表格视图
        NSString *imputName = [alertView textFieldAtIndex:0].text;
        [self.dataSource addObject:imputName];
        [self.dataSource sortUsingSelector:@selector(caseInsensitiveCompare:)];
        //[self.tableView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.dataSource indexOfObject:imputName] inSection:0];
        //进行表格插入
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
@end
