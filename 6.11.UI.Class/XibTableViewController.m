//
//  XibTableViewController.m
//  6.11.UI.Class
//
//  Created by rimi on 15/6/11.
//  Copyright (c) 2015年 rectinajh. All rights reserved.
//

#import "XibTableViewController.h"
#import "CustomTableViewCell.h"
@interface XibTableViewController () <UITableViewDataSource>

@property(strong,nonatomic) NSArray      *dataSource;
@property(nonatomic,strong) UITableView     *tableView;

@end
static NSString  *identifier = @"XIBCELL";

@implementation XibTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //进行数据源创建
    self.dataSource = @[@{@"imageName":@"header.jpg",
                          @"name":@"Q1501A",
                          @"content":@"帮忙",
                          @"time":@"上午 9：30"},
                          @{@"imageName":@"header.jpg",
                            @"name":@"Q1501A",
                            @"content":@"帮忙",
                            @"time":@"上午 9：30"},
                          @{@"imageName":@"header.jpg",
                            @"name":@"Q1501A",
                            @"content":@"帮忙",
                            @"time":@"上午 9：30"},];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80;
    [self.view addSubview:self.tableView];
    
    //xib文件注册
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    //取出具体某行的字典
    NSDictionary *dic = self.dataSource[indexPath.row];
    //取出字典的元素
    NSString *imageName = dic[@"imageName"];
    NSString *name = dic[@"name"];
    NSString *content = dic[@"content"];
    NSString *time = dic[@"time"];
    //配置到cell中
    cell.headerImageView.image = [UIImage imageNamed:imageName];
    cell.nameLabel.text = name;
    cell.contentLabel.text = content;
    cell.timeLabel.text = time;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
