//
//  ViewController.m
//  UserDetail
//
//  Created by Rainy on 16/10/8.
//  Copyright © 2016年 Rainy. All rights reserved.
//



#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define kColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#import "ViewController.h"
#import "NaView.h"



@interface ViewController ()<NaViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *_headerImg;
    UILabel *_nameLabel;
    NSMutableArray *_dataArray;
    
}
@property(nonatomic,strong)UIImageView *backgroundImgV;
@property(nonatomic,assign)float backImgHeight;
@property(nonatomic,assign)float backImgWidth;
@property(nonatomic,strong)NaView *NavView;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self backImageView];
    
    [self createNaView];
    
    [self loadData];
    
    [self layoutTableView];
}
-(void)createNaView
{
    self.NavView=[[NaView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    self.NavView.title = @"我的";
    self.NavView.color = [UIColor whiteColor];
    self.NavView.left_bt_Image = @"left_";
    self.NavView.right_bt_Image = @"Setting";
    self.NavView.delegate = self;
    [self.view addSubview:self.NavView];
}

-(void)loadData{
    
    _dataArray =[[NSMutableArray alloc]init];
    
    for (int i=0; i<10; i++) {
        
        NSString * string=[NSString stringWithFormat:@"第%d行",i];
        
        [_dataArray addObject:string];
        
    }
    
}

-(void)backImageView{
    UIImage *image=[UIImage imageNamed:@"back"];
    //图片的宽度设为屏幕的宽度，高度自适应
    NSLog(@"%f",image.size.height);
    _backgroundImgV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, image.size.height*0.8)];
    _backgroundImgV.image=image;
    _backgroundImgV.userInteractionEnabled=YES;
    [self.view addSubview:_backgroundImgV];
    _backImgHeight=_backgroundImgV.frame.size.height;
    _backImgWidth=_backgroundImgV.frame.size.width;
}

-(void)layoutTableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_tableView];
    }
    [_tableView setTableHeaderView:[self headImageView]];
}



-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView=[[UIImageView alloc]init];
        _headImageView.frame=CGRectMake(0, 64, WIDTH, 170);
        _headImageView.backgroundColor=[UIColor clearColor];
        _headImageView.userInteractionEnabled = YES;
        
        _headerImg=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-35, 50, 70, 70)];
        _headerImg.center=CGPointMake(WIDTH/2, 70);
        [_headerImg setImage:[UIImage imageNamed:@"header"]];
        [_headerImg.layer setMasksToBounds:YES];
        [_headerImg.layer setCornerRadius:35];
        _headerImg.backgroundColor=[UIColor whiteColor];
        _headerImg.userInteractionEnabled=YES;
        UITapGestureRecognizer *header_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(header_tap_Click:)];
        [_headerImg addGestureRecognizer:header_tap];
        [_headImageView addSubview:_headerImg];
        
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(147, 130, 105, 20)];
        _nameLabel.center = CGPointMake(WIDTH/2, 125);
        _nameLabel.text = @"Rainy";
        _nameLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *nick_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nick_tap_Click:)];
        [_nameLabel addGestureRecognizer:nick_tap];
        _nameLabel.textColor=[UIColor whiteColor];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        [_headImageView addSubview:_nameLabel];
    }
    return _headImageView;
}

//左按钮
-(void)NaLeft
{
    NSLog(@"左按钮");
}
//右按钮
-(void)NaRight
{
    NSLog(@"右按钮");
}//头像
-(void)header_tap_Click:(UITapGestureRecognizer *)tap
{
    NSLog(@"头像");
}
//昵称
-(void)nick_tap_Click:(UIButton *)item
{
    NSLog(@"昵称");
}




#pragma mark ---- UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _dataArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reusID=@"ID";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reusID];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusID];
    }
    cell.textLabel.text=[_dataArray objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.text=[_dataArray objectAtIndex:indexPath.row];
    
    [cell.imageView setImage:[UIImage imageNamed:@"cell"]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int contentOffsety = scrollView.contentOffset.y;
    
    if (scrollView.contentOffset.y<=170) {
        self.NavView.headBackView.alpha = scrollView.contentOffset.y/170;
        self.NavView.left_bt_Image = @"left_";
        self.NavView.right_bt_Image = @"Setting";
        self.NavView.color = [UIColor whiteColor];

        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }else{
        self.NavView.headBackView.alpha = 1;

        self.NavView.left_bt_Image = @"left@3x.png";
        self.NavView.right_bt_Image = @"Setting_";
        self.NavView.color = kColor(87, 173, 104, 1);
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    if (contentOffsety<0) {
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight-contentOffsety;
        rect.size.width = _backImgWidth* (_backImgHeight-contentOffsety)/_backImgHeight;
        rect.origin.x =  -(rect.size.width-_backImgWidth)/2;
        rect.origin.y = 0;
        _backgroundImgV.frame = rect;
    }else{
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight;
        rect.size.width = _backImgWidth;
        rect.origin.x = 0;
        rect.origin.y = -contentOffsety;
        _backgroundImgV.frame = rect;
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
