//
//  ViewController.m
//  LayoutMain
//
//  Created by allen.wang on 12/4/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewControllerViewController.h"
static NSString *titles[] = {@"流式布局",@"边框布局",@"卡片布局",@"表格布局",@"盒式布局",@"嵌套布局"};


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewController
@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"布局控件";
    self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] autorelease ];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    cell.textLabel.text = titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            DetailViewControllerViewControllerFlow *detail = [[[DetailViewControllerViewControllerFlow alloc] init] autorelease];
            detail.title = titles[indexPath.row];
            [self.navigationController   pushViewController:detail animated:YES];
        }
            break;
        case 1:
        {
            DetailViewControllerViewControllerBorder *detail = [[[DetailViewControllerViewControllerBorder alloc] init] autorelease];
            detail.title = titles[indexPath.row];
            [self.navigationController   pushViewController:detail animated:YES];
        }
            break;
        case 2:
        {
            
            DetailViewControllerViewControllerCard *detail = [[[DetailViewControllerViewControllerCard alloc] init] autorelease];         
            detail.title = titles[indexPath.row];
            
            [self.navigationController   pushViewController:detail animated:YES];
        }
            break;
        case 3:
        {
            
            DetailViewControllerViewControllerGrid *detail = [[[DetailViewControllerViewControllerGrid alloc] init] autorelease];         
            detail.title = titles[indexPath.row];
            
            [self.navigationController   pushViewController:detail animated:YES];
        }
            break;
        case 4:
        {
            DetailViewControllerViewControllerBox *detail = [[[DetailViewControllerViewControllerBox alloc] init] autorelease];
            detail.title = titles[indexPath.row];
            [self.navigationController   pushViewController:detail animated:YES];
        }
            break;
        case 5:
        {
            DetailViewControllerViewControllerAll *detail = [[[DetailViewControllerViewControllerAll alloc] init] autorelease];
            detail.title = titles[indexPath.row];
            [self.navigationController   pushViewController:detail animated:YES];
        }
            break;
            
        default:
        {
        }
            break;
    }
}

@end
