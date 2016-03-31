//
//  DetailViewControllerViewController.m
//  LayoutMain
//
//  Created by allen.wang on 12/4/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "DetailViewControllerViewController.h"


@implementation DetailViewControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        UIBarButtonItem *item = [[[UIBarButtonItem alloc] initWithTitle:@"refresh" style:UIButtonTypeInfoDark target:self action:@selector(refresh:)] autorelease];
        self.navigationItem.rightBarButtonItem = item;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = YES;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (IBAction)refresh:(id)sender
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

@implementation DetailViewControllerViewControllerFlow


- (IBAction)refresh:(id)sender
{
    static int start = 0;
    static int gap = 100;
    WASFlowLayout *flowLayout = (WASFlowLayout *)self.container.layoutManager;

    [UIView animateWithDuration:0.25 
                     animations:^
     {
         flowLayout.newAlign = WASFlowLayout.RIGHT;
         flowLayout.newAlign = (++start) %5;
         flowLayout.hgap = flowLayout.vgap = (++gap) * (++gap) %30;
         [self.container layoutSubviews];
     } completion:^(BOOL finished) {
         UILabel *label = (UILabel *)[self.container getComponentAt:0];
         label.text = flowLayout.debugDescription;
     }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    WASFlowLayout *flowLayout = (WASFlowLayout *)self.container.layoutManager;
    
    flowLayout.newAlign = WASFlowLayout.CENTER;
    flowLayout.hgap = flowLayout.vgap = 1;   
    
    UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)] autorelease];
    UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 40, 100, 40)] autorelease];
    UILabel *label3 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 80, 200, 40)] autorelease];
    UILabel *label4 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 120, 100, 40)] autorelease];
    UILabel *label5 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 160, 100, 40)] autorelease];
    label1.textAlignment = UITextAlignmentCenter;
    label2.textAlignment = UITextAlignmentCenter;
    label3.textAlignment = UITextAlignmentCenter;
    label4.textAlignment = UITextAlignmentCenter;
    label5.textAlignment = UITextAlignmentCenter;
    label1.backgroundColor = [UIColor redColor];
    label2.backgroundColor = [UIColor whiteColor];
    label3.backgroundColor = [UIColor blueColor];
    label4.backgroundColor = [UIColor orangeColor];
    label5.backgroundColor = [UIColor purpleColor];

    
    label1.text = @"流式1";
    label2.text = @"流式2";
    label3.text = @"流式3";
    label4.text = @"流式4";
    label5.text = @"流式5";
    
    
    [self.container  add:label1];
    [self.container  add:label2];
    [self.container  add:label3];
    [self.container  add:label4];
    [self.container  add:label5];
	// Do any additional setup after loading the view.
}


@end

@implementation DetailViewControllerViewControllerBorder

- (IBAction)refresh:(id)sender
{
    static int gap = 100;
    
    [UIView animateWithDuration:0.25 
                     animations:^
     {
         WASBorderLayout *flowLayout = (WASBorderLayout *)self.container.layoutManager;
         flowLayout.hgap = flowLayout.vgap = (++gap) * (++gap) %30 + 1;
         [self.container layoutSubviews];
     }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    WASBorderLayout *borderLayout =  [[WASBorderLayout alloc] init];
    [self.container setLayoutManager:borderLayout];
    borderLayout.hgap = borderLayout.vgap = 1;   
    
    UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)] autorelease];
    UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 40, 100, 60)] autorelease];
    UILabel *label3 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 80, 50, 30)] autorelease];
    UILabel *label4 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 120, 50, 22)] autorelease];
    UILabel *label5 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 160, 70, 50)] autorelease];
    label1.textAlignment = UITextAlignmentCenter;
    label2.textAlignment = UITextAlignmentCenter;
    label3.textAlignment = UITextAlignmentCenter;
    label4.textAlignment = UITextAlignmentCenter;
    label5.textAlignment = UITextAlignmentCenter;
    label1.backgroundColor = [UIColor redColor];
    label2.backgroundColor = [UIColor whiteColor];
    label3.backgroundColor = [UIColor blueColor];
    label4.backgroundColor = [UIColor orangeColor];
    label5.backgroundColor = [UIColor purpleColor];

    
    label1.text = @"北1";
    label2.text = @"南2";
    label3.text = @"东3";
    label4.text = @"西4";
    label5.text = @"中5";
    
    [self.container  add:WASBorderLayout.NORTH withComponet:label1];
    [self.container  add:WASBorderLayout.SOURTH withComponet:label2];
    [self.container  add:WASBorderLayout.EAST withComponet:label3];
    [self.container  add:WASBorderLayout.WEST withComponet:label4];
    [self.container  add:WASBorderLayout.CENTER withComponet:label5];
	// Do any additional setup after loading the view.
}


@end

@implementation DetailViewControllerViewControllerCard

- (IBAction)refresh:(id)sender
{    
    [UIView animateWithDuration:0.25 
                     animations:^
     {
         WASCardLayout *flowLayout = (WASCardLayout *)self.container.layoutManager;
         [flowLayout next:self.container];
     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WASCardLayout *cardLayout =  [[WASCardLayout alloc] init];
    [self.container setLayoutManager:cardLayout];
    
    UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)] autorelease];
    UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 40, 100, 60)] autorelease];
    UILabel *label3 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 80, 230, 30)] autorelease];
    UILabel *label4 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 120, 50, 22)] autorelease];
    UILabel *label5 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 160, 70, 50)] autorelease];
    label1.textAlignment = UITextAlignmentCenter;
    label2.textAlignment = UITextAlignmentCenter;
    label3.textAlignment = UITextAlignmentCenter;
    label4.textAlignment = UITextAlignmentCenter;
    label5.textAlignment = UITextAlignmentCenter;
    label1.backgroundColor = [UIColor redColor];
    label2.backgroundColor = [UIColor whiteColor];
    label3.backgroundColor = [UIColor blueColor];
    label4.backgroundColor = [UIColor orangeColor];
    label5.backgroundColor = [UIColor purpleColor];

    
    label1.text = @"卡片1";
    label2.text = @"卡片2";
    label3.text = @"卡片3";
    label4.text = @"卡片4";
    label5.text = @"卡片5";
    
    
    [self.container  add:label1];
    [self.container  add:label2];
    [self.container  add:label3];
    [self.container  add:label4];
    [self.container  add:label5];
	// Do any additional setup after loading the view.
}


@end

@implementation DetailViewControllerViewControllerGrid

- (IBAction)refresh:(id)sender
{    
    [UIView animateWithDuration:0.25 
                     animations:^
     {
         if ([self.container countComponents] < 6) {
             [self addcomponent:5];
             [self.view layoutSubviews];
         } else {
             [self.container removeComponentAt:0];
         }
     }];
}

- (void) addcomponent:(int ) count
{
    for (int i = 0 ; i < count; i++) {
        UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 40)] autorelease];
        label1.textAlignment = UITextAlignmentCenter;
        label1.text = [NSString stringWithFormat:@"单元%d",i];
        [self.container  add:label1];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad]; 

    WASGridLayout *gridLayout =  [[WASGridLayout alloc] initWithRows:5 columns:0 hGap:2 vGap:2];
    [self.container setLayoutManager:gridLayout];
    [self addcomponent:10];
}


@end

@implementation DetailViewControllerViewControllerBox

- (IBAction)refresh:(id)sender
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = nil;

    WASBoxLayout *boxLayout = [[[WASBoxLayout alloc] initWithContainer:self.container axis:WASBoxLayout.Y_AXIS] autorelease];
    [self.container setLayoutManager:boxLayout];

    
    UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 40)] autorelease];
    UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 40, 10, 60)] autorelease];
    UILabel *label3 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 80, 23, 30)] autorelease];
    UILabel *label4 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 120, 50, 22)] autorelease];
    UILabel *label5 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 160, 70, 50)] autorelease];
    label1.textAlignment = UITextAlignmentCenter;
    label2.textAlignment = UITextAlignmentCenter;
    label3.textAlignment = UITextAlignmentCenter;
    label4.textAlignment = UITextAlignmentCenter;
    label5.textAlignment = UITextAlignmentCenter;
    label1.backgroundColor = [UIColor redColor];
    label2.backgroundColor = [UIColor whiteColor];
    label3.backgroundColor = [UIColor blueColor];
    label4.backgroundColor = [UIColor orangeColor];
    label5.backgroundColor = [UIColor purpleColor];

    
    label1.text = @"盒式1,下面是高为20的支撑组件";
    label2.text = @"盒式2,下面是高为30的支撑组件";
    label3.text = @"盒式3";
    label4.text = @"盒式4,下面是胶水组件";
    label5.text = @"盒式5";
    
    [self.container  add:label1];
    [self.container  add:nil withComponet:(Component *)[WASBoxStrut strutWithValue:20]];
    [self.container  add:label2];
    [self.container  add:nil withComponet:(Component *)[WASBoxStrut strutWithValue:30]];
    
    [self.container  add:label3];

    [self.container  add:label4];
    [self.container  add:nil withComponet:(Component *)[WASBoxGlue glue]];
    [self.container  add:label5];

	// Do any additional setup after loading the view.
}


@end


@implementation DetailViewControllerViewControllerAll

- (IBAction)refresh:(id)sender
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = nil;

    WASBorderLayout *borderLayout =  [[WASBorderLayout alloc] init];
    [self.container setLayoutManager:borderLayout];
    borderLayout.hgap = borderLayout.vgap = 2;   

    WASContainer *container1 = [[WASContainer alloc] initWithFrame:CGRectMake(0, 0, 40, 80)];    
    container1.backgroundColor = [UIColor whiteColor];    
    WASBoxLayout *boxLayout = [[[WASBoxLayout alloc] initWithContainer:container1 axis:WASBoxLayout.Y_AXIS] autorelease];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(10, 20, 10, 35);
    [button1 setTitle:@"blackColor" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor blackColor];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(10, 20, 10, 20);
    [button2 setTitle:@"redColor" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor redColor];
    
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.backgroundColor = [UIColor grayColor];
    [button3 setTitle:@"grayColor" forState:UIControlStateNormal];
    
    button3.frame = CGRectMake(10, 20, 18, 30);
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.backgroundColor = [UIColor greenColor];
    [button4 setTitle:@"greenColor" forState:UIControlStateNormal];
    
    button4.frame = CGRectMake(10, 20, 40, 30);
    [self.container add:WASBorderLayout.NORTH withComponet:button1];
    [self.container add:WASBorderLayout.SOURTH withComponet:button2];
    [self.container add:WASBorderLayout.EAST withComponet:button3];
    [self.container add:WASBorderLayout.WEST withComponet:button4];    
    [self.container add:WASBorderLayout.CENTER withComponet:container1];
    
    
    for (int i = 0 ; i < 6; i++) {
        CGRect rect = CGRectMake(0, 0,32 + 0 * i, 30);
        UIButton *temp = [UIButton buttonWithType:UIButtonTypeRoundedRect ];
        [temp setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        temp.frame = rect;
        temp.backgroundColor = [UIColor whiteColor];        
        if (1 == i || 3 == i) {
            [container1  add:nil withComponet:(Component *)[WASBoxStrut strutWithValue:20 + 10 * (i-1)]];
        }
        else if (4==i) {
            [container1  add:nil withComponet:(Component *)[WASBoxGlue glue]];
        }
        [container1 add:temp];
    }
}


@end
