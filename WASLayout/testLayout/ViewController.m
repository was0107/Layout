//
//  ViewController.m
//  testLayout
//
//  Created by Micker on 16/3/31.
//  Copyright © 2016年 micker. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewControllerViewController.h"

static NSString *titles[] = {
    @"流式布局",
    @"边框布局",
    @"卡片布局",
    @"表格布局",
    @"盒式布局",
    @"嵌套布局"};

static NSString *classes[] = {
    @"DetailViewControllerViewControllerFlow",
    @"DetailViewControllerViewControllerBorder",
    @"DetailViewControllerViewControllerCard",
    @"DetailViewControllerViewControllerGrid",
    @"DetailViewControllerViewControllerBox",
    @"DetailViewControllerViewControllerAll"};

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"布局控件";
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *) tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    cell.textLabel.text = titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewControllerViewController *controller = [[NSClassFromString(classes[indexPath.row]) alloc] init];
    controller.title = titles[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
