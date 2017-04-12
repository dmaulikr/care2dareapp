//
//  ExplorePageViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/4/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ExplorePageViewController.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#import "UIImageView+WebCache.h"
#import "ContributeDaetailPageViewController.h"
@interface ExplorePageViewController ()<UISearchBarDelegate>
{
    CALayer *borderBottom_world,*borderBottom_ExpFrnd;
    NSString * cellChecking;
    UIView *sectionView,*transparancyTuchView;
    UISearchBar *searchbar;
     NSDictionary *urlplist;
     NSUserDefaults *defaults;
    NSMutableArray * Array_WorldExp,* Array_FriendExp;;
    NSArray *SearchCrickArray_worldExp,*SearchCrickArray_FriendExp;
    CALayer *bootomBorder_Cell;
}
@end

@implementation ExplorePageViewController
@synthesize Tableview_Explore,View_ExpFriend,view_ExpWorld,image_ExpWorld,image_ExpFriend,cell_WorldExp,cell_FriendExp,Label_JsonResult;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    cellChecking=@"WorldExp";
    defaults=[[NSUserDefaults alloc]init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    searchbar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,44)];
    searchbar.translucent=YES;
    searchbar.delegate=self;
    searchbar.searchBarStyle=UISearchBarStyleMinimal;
    searchbar.showsCancelButton=YES;
   
        [searchbar setShowsCancelButton:NO animated:YES];
    
    SearchCrickArray_worldExp=[[NSArray alloc]init];
    
    Tableview_Explore.tableHeaderView=searchbar;
    
     borderBottom_world = [CALayer layer];
     borderBottom_ExpFrnd = [CALayer layer];
    Label_JsonResult.hidden=YES;
    
    UITapGestureRecognizer *ViewTap11 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(ViewTapTapped_Expworld:)];
    [view_ExpWorld addGestureRecognizer:ViewTap11];
    //[image_ExpWorld addGestureRecognizer:ViewTap11];
    
    UITapGestureRecognizer *ViewTap22 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(ViewTapTapped_Expfriend:)];
    [View_ExpFriend addGestureRecognizer:ViewTap22];
    // [image_ExpFriend addGestureRecognizer:ViewTap22];
    
    
    
    transparancyTuchView=[[UIView alloc]initWithFrame:CGRectMake(0,114,self.view.frame.size.width,self.view.frame.size.height-70)];
    transparancyTuchView.backgroundColor=[UIColor whiteColor];
    [transparancyTuchView setAlpha:0.5];
    [self.view addSubview:transparancyTuchView];
    transparancyTuchView.hidden=YES;
    UITapGestureRecognizer * ViewTap51 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(ViewTap51Tapped:)];
    [transparancyTuchView addGestureRecognizer:ViewTap51];
    
    UIColor *bgRefreshColor = [UIColor whiteColor];
    
    // Creating refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl setBackgroundColor:bgRefreshColor];
    self.refreshControl = self.refreshControl;
    
    // Creating view for extending background color
    CGRect frame = Tableview_Explore.bounds;
    frame.origin.y = -frame.size.height;
    UIView* bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = bgRefreshColor;
    
    // Adding the view below the refresh control
    [Tableview_Explore insertSubview:bgView atIndex:0];
    self.refreshControl = self.refreshControl;
    
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(PulltoRefershtable)
                  forControlEvents:UIControlEventValueChanged];
   
    [Tableview_Explore addSubview:self.refreshControl];
    
    [self ClienserverComm_worldExp];
    [self ClienserverComm_FriendExp];
    
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    view_ExpWorld.clipsToBounds=YES;
    image_ExpWorld.clipsToBounds=YES;
    image_ExpFriend.clipsToBounds=YES;
    [image_ExpWorld setImage:[UIImage imageNamed:@"exploreworld.png"]];
    [image_ExpFriend setImage:[UIImage imageNamed:@"explore_friends1.png"]];
    
    
    borderBottom_world.backgroundColor = [UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor;
    borderBottom_world.frame = CGRectMake(0, view_ExpWorld.frame.size.height-2.5, view_ExpWorld.frame.size.width, 2.5);
    [view_ExpWorld.layer addSublayer:borderBottom_world];
    
    
    
    View_ExpFriend.clipsToBounds=YES;
    
    
   
    borderBottom_ExpFrnd.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_ExpFrnd.frame = CGRectMake(0, View_ExpFriend.frame.size.height-1, View_ExpFriend.frame.size.width, 1);
    [View_ExpFriend.layer addSublayer:borderBottom_ExpFrnd];
}
-(void)PulltoRefershtable
{
    if ([cellChecking isEqualToString:@"WorldExp"])
    {
       [self ClienserverComm_worldExp];
    }
    if ([cellChecking isEqualToString:@"FriendExp"])
    {
     [self ClienserverComm_FriendExp];
    }
    
    [Tableview_Explore reloadData];
    [self.refreshControl endRefreshing];
    
}
-(void)ClienserverComm_FriendExp
{
    [self.view endEditing:YES];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2dare." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
        
        
        NSString *userid= @"userid";
        NSString *useridVal =[defaults valueForKey:@"userid"];
        
        NSString *exploretype= @"exploretype";
        NSString *exploretypeval =@"FRIENDS";
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid,useridVal,exploretype,exploretypeval];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"explore_world"];;
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        NSURLSessionDataTask *dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                         {
                                             if(data)
                                             {
                                                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                 NSInteger statusCode = httpResponse.statusCode;
                                                 if(statusCode == 200)
                                                 {
                                                     
                                                     Array_FriendExp=[[NSMutableArray alloc]init];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                Array_FriendExp =[objSBJsonParser objectWithData:data];
                                                     
            SearchCrickArray_FriendExp=[objSBJsonParser objectWithData:data];
                                                     
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     NSLog(@"Array_FriendExp %@",Array_FriendExp);
                                                     
                                                     
                                                     NSLog(@"Array_WorldExp ResultString %@",ResultString);
                                                     if ([ResultString isEqualToString:@"nouserid"])
                                                     {
                                                         
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                     }
                                                     
                                                     
                                                     if ([ResultString isEqualToString:@"done"])
                                                     {
                                                         
                                                         
                                                         
                                                         
                                                     }
                                                     if (Array_WorldExp.count !=0)
                                                     {
                                                         [Tableview_Explore reloadData];
                                                     }
                                                     
                                                     
                                                 }
                                                 
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     
                                                 }
                                                 
                                                 
                                             }
                                             else if(error)
                                             {
                                                 
                                                 NSLog(@"error login2.......%@",error.description);
                                             }
                                             
                                             
                                         }];
        [dataTask resume];
    }
    
}
-(void)ClienserverComm_worldExp
{
    [self.view endEditing:YES];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2dare." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
        
        
        NSString *userid= @"userid";
        NSString *useridVal =[defaults valueForKey:@"userid"];
        
        
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",userid,useridVal];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"explore_world"];;
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        NSURLSessionDataTask *dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                         {
                                             if(data)
                                             {
                                                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                 NSInteger statusCode = httpResponse.statusCode;
                                                 if(statusCode == 200)
                                                 {
                                                     
                                                     Array_WorldExp=[[NSMutableArray alloc]init];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                            Array_WorldExp=[objSBJsonParser objectWithData:data];
                                                     
                        SearchCrickArray_worldExp=[objSBJsonParser objectWithData:data];
                                                     
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                NSLog(@"Array_WorldExp %@",Array_WorldExp);
                                                     
                                                     
                                                     NSLog(@"Array_WorldExp ResultString %@",ResultString);
                                                     if ([ResultString isEqualToString:@"nouserid"])
                                                     {
                                                        
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                     }
                                                     
                                                     
                                                     if ([ResultString isEqualToString:@"done"])
                                                     {
                                                         
                                                  
                                                         
                                                         
                                                     }
                                                     if (Array_WorldExp.count !=0)
                                                     {
                                                             Label_JsonResult.hidden=YES;
                                                         [Tableview_Explore reloadData];
                                                     }
                                                     else
                                                     {
                                                         Label_JsonResult.hidden=NO;
                                                     }
                                                     
                                                     
                                                 }
                                                 
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     
                                                 }
                                                 
                                                 
                                             }
                                             else if(error)
                                             {
                                                
                                                 NSLog(@"error login2.......%@",error.description);
                                             }
                                             
                                             
                                         }];
        [dataTask resume];
    }
   
}
-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    [Tableview_Explore setContentOffset:CGPointMake(0, 44)];
    if ([cellChecking isEqualToString:@"WorldExp"])
    {
        [self ClienserverComm_worldExp];
    }
    if ([cellChecking isEqualToString:@"FriendExp"])
    {
        [self ClienserverComm_FriendExp];
    }
    
}
- (void)ViewTap51Tapped:(UITapGestureRecognizer *)recognizer
{
    transparancyTuchView.hidden=YES;
    [self.view endEditing:YES];
}



- (void)ViewTapTapped_Expworld:(UITapGestureRecognizer *)recognizer
{
 cellChecking=@"WorldExp";
     Label_JsonResult.hidden=YES;
    view_ExpWorld.clipsToBounds=YES;
    image_ExpWorld.clipsToBounds=YES;
    [image_ExpWorld setImage:[UIImage imageNamed:@"exploreworld.png"]];
    [image_ExpFriend setImage:[UIImage imageNamed:@"explore_friends1.png"]];

    
    borderBottom_world.backgroundColor = [UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor;
    borderBottom_world.frame = CGRectMake(0, view_ExpWorld.frame.size.height-2.5, view_ExpWorld.frame.size.width, 2.5);
    [view_ExpWorld.layer addSublayer:borderBottom_world];
    
    
    
    View_ExpFriend.clipsToBounds=YES;
    image_ExpFriend.clipsToBounds=YES;
    
    
    borderBottom_ExpFrnd.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_ExpFrnd.frame = CGRectMake(0, View_ExpFriend.frame.size.height-1, View_ExpFriend.frame.size.width, 1);
    [View_ExpFriend.layer addSublayer:borderBottom_ExpFrnd];
     [self ClienserverComm_worldExp];
    if (Array_WorldExp.count==0)
    {
            Label_JsonResult.hidden=NO;
    }
    else
    {
        Label_JsonResult.hidden=YES;
    }
    [Tableview_Explore reloadData];
}
- (void)ViewTapTapped_Expfriend:(UITapGestureRecognizer *)recognizer
{
    cellChecking=@"FriendExp";
    view_ExpWorld.clipsToBounds=YES;
    image_ExpWorld.clipsToBounds=YES;
     Label_JsonResult.hidden=YES;
    [image_ExpWorld setImage:[UIImage imageNamed:@"exploreworld1.png"]];
    [image_ExpFriend setImage:[UIImage imageNamed:@"explore_friends.png"]];

    borderBottom_world.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_world.frame = CGRectMake(0, view_ExpWorld.frame.size.height-1, view_ExpWorld.frame.size.width, 1);
    [view_ExpWorld.layer addSublayer:borderBottom_world];
    
    
    
    View_ExpFriend.clipsToBounds=YES;
    image_ExpFriend.clipsToBounds=YES;
    

    borderBottom_ExpFrnd.backgroundColor = [UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor;
    borderBottom_ExpFrnd.frame = CGRectMake(0, View_ExpFriend.frame.size.height-2.5, View_ExpFriend.frame.size.width, 2.5);
    [View_ExpFriend.layer addSublayer:borderBottom_ExpFrnd];
     [self ClienserverComm_FriendExp];
    if (Array_FriendExp.count==0)
    {
        Label_JsonResult.hidden=NO;
    }
    else
    {
        Label_JsonResult.hidden=YES;
    }
    
    [Tableview_Explore reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
   

        if ([cellChecking isEqualToString:@"WorldExp"])
        {
            return Array_WorldExp.count;
        }
        else if ([cellChecking isEqualToString:@"FriendExp"])
        {
            return Array_FriendExp.count;
        }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    static NSString *cellIdW1=@"CellW1";
    static NSString *cellIdF1=@"CellF1";
   
    
        if ([cellChecking isEqualToString:@"WorldExp"])
            {
                
            cell_WorldExp = [[[NSBundle mainBundle]loadNibNamed:@"WorldExpTableViewCell" owner:self options:nil] objectAtIndex:0];
                
               
                
                if (cell_WorldExp == nil)
                {
                    
                    cell_WorldExp = [[WorldExpTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdW1];
                    
                    
                }
                
                
                bootomBorder_Cell = [CALayer layer];
                bootomBorder_Cell.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
                bootomBorder_Cell.frame = CGRectMake(0, cell_WorldExp.frame.size.height-1, cell_WorldExp.frame.size.width, 1);
                [cell_WorldExp.layer addSublayer:bootomBorder_Cell];
                
                 NSDictionary * dic_worldexp=[Array_WorldExp objectAtIndex:indexPath.row];
                cell_WorldExp.Label_Raised.text=[NSString stringWithFormat:@"%@%@",@"$",[dic_worldexp valueForKey:@"backamount"]];
                cell_WorldExp.Label_Backer.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"backers"]];
                cell_WorldExp.Label_Titile.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
                NSString *text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
                

        CGRect textRect = [text boundingRectWithSize:cell_WorldExp.Label_Titile.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_WorldExp.Label_Titile.font} context:nil];
                
    int numberOfLines = textRect.size.height / cell_WorldExp.Label_Titile.font.pointSize;;
        if (numberOfLines==1)
        {
    [cell_WorldExp.Label_Titile setFrame:CGRectMake(cell_WorldExp.Label_Titile.frame.origin.x, cell_WorldExp.Label_Titile.frame.origin.y, cell_WorldExp.Label_Titile.frame.size.width, cell_WorldExp.Label_Titile.frame.size.height/2)];
                }
              
                
                
                NSLog(@"number of lines=%d",numberOfLines);
                
                 cell_WorldExp.Label_Time.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"createtime"]];
               // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengeid"];
               // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengerdetails"];
               
                //cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediatype"];
               // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediaurl"];
               // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"noofchallengers"];
               // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"payperchallenger"];
                cell_WorldExp.Image_Profile.tag=indexPath.row;
               
    if ([[dic_worldexp valueForKey:@"mediatype"] isEqualToString:@"IMAGE"])
                {
                    cell_WorldExp.Image_PalyBuutton.hidden=YES;
                    
                    NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediaurl"]];
                    
                    [cell_WorldExp.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                }
                else
                {
                    
                    NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediathumbnailurl"]];
                    
                    [cell_WorldExp.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                    cell_WorldExp.Image_PalyBuutton.hidden=NO;
                    
                    
                }
                
                
                
                UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
                NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
                NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[dic_worldexp valueForKey:@"usersname"] attributes: arialDict];
                
                UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-SemiBold" size:14.0];
                NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
                NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString: @" Challenges " attributes:verdanaDict];
                
                
                UIFont *name3 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
                NSDictionary *verdanaDict2 = [NSDictionary dictionaryWithObject:name3 forKey:NSFontAttributeName];
                NSMutableAttributedString *cAttrString = [[NSMutableAttributedString alloc]initWithString:[dic_worldexp valueForKey:@"challengerdetails"] attributes:verdanaDict2];
                
                [aAttrString appendAttributedString:vAttrString];
                [aAttrString appendAttributedString:cAttrString];
                
                
                cell_WorldExp.Label_Changename.attributedText = aAttrString;
                
            //    cell_WorldExp.Label_Changename.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"usersname"]];
                

               
                return cell_WorldExp;
                
            }
            if ([cellChecking isEqualToString:@"FriendExp"])
            {
                
                cell_FriendExp = [[[NSBundle mainBundle]loadNibNamed:@"FriendExpTableViewCell" owner:self options:nil] objectAtIndex:0];
                
                
                if (cell_FriendExp == nil)
                {
                    
                    cell_FriendExp = [[FriendExpTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdF1];
                }
                bootomBorder_Cell = [CALayer layer];
                bootomBorder_Cell.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
                bootomBorder_Cell.frame = CGRectMake(0, cell_FriendExp.frame.size.height-1, cell_FriendExp.frame.size.width, 1);
                [cell_FriendExp.layer addSublayer:bootomBorder_Cell];
              
                NSDictionary * dic_worldexp=[Array_FriendExp objectAtIndex:indexPath.row];
                cell_FriendExp.Label_Raised.text=[NSString stringWithFormat:@"%@%@",@"$",[dic_worldexp valueForKey:@"backamount"]];
                cell_FriendExp.Label_Backer.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"backers"]];
                cell_FriendExp.Label_Titile.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
                NSString *text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
                
                
                CGRect textRect = [text boundingRectWithSize:cell_FriendExp.Label_Titile.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_FriendExp.Label_Titile.font} context:nil];
                
                int numberOfLines = textRect.size.height / cell_FriendExp.Label_Titile.font.pointSize;;
                if (numberOfLines==1)
                {
                    [cell_FriendExp.Label_Titile setFrame:CGRectMake(cell_FriendExp.Label_Titile.frame.origin.x, cell_FriendExp.Label_Titile.frame.origin.y, cell_FriendExp.Label_Titile.frame.size.width, cell_FriendExp.Label_Titile.frame.size.height/2)];
                }
                
                
                
                NSLog(@"number of lines=%d",numberOfLines);
                
                cell_FriendExp.Label_Time.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"createtime"]];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengeid"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengerdetails"];
                
                //cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediatype"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediaurl"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"noofchallengers"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"payperchallenger"];
                
                
                if ([[dic_worldexp valueForKey:@"mediatype"] isEqualToString:@"IMAGE"])
                {
                    cell_FriendExp.Image_PalyBuutton.hidden=YES;
                    
                    NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediaurl"]];
                    
                    [cell_FriendExp.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                }
                else
                {
                    
                    NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediathumbnailurl"]];
                    
                    [cell_FriendExp.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                    cell_FriendExp.Image_PalyBuutton.hidden=NO;
                    
                    
                }
                
                
                
                UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
                NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
                NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[dic_worldexp valueForKey:@"usersname"] attributes: arialDict];
                
                UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-SemiBold" size:14.0];
                NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
                NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString: @" Challenges " attributes:verdanaDict];
                
                
                UIFont *name3 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
                NSDictionary *verdanaDict2 = [NSDictionary dictionaryWithObject:name3 forKey:NSFontAttributeName];
                NSMutableAttributedString *cAttrString = [[NSMutableAttributedString alloc]initWithString:[dic_worldexp valueForKey:@"challengerdetails"] attributes:verdanaDict2];
                
                [aAttrString appendAttributedString:vAttrString];
                [aAttrString appendAttributedString:cAttrString];
                
                
                cell_FriendExp.Label_Changename.attributedText = aAttrString;
                
                return cell_FriendExp;
                
      
    }
    return nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
        if ([cellChecking isEqualToString:@"WorldExp"])
        {
        return 140;
        }
        if ([cellChecking isEqualToString:@"FriendExp"])
        {
            return 140;
        }
  
  
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContributeDaetailPageViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ContributeDaetailPageViewController"];
    NSDictionary *  didselectDic;
    if ([cellChecking isEqualToString:@"WorldExp"])
    {
        didselectDic=[Array_WorldExp  objectAtIndex:indexPath.row];
        cell_WorldExp = [Tableview_Explore cellForRowAtIndexPath:indexPath];
         set.ProfileImgeData =cell_WorldExp.Image_Profile;
    }
    if ([cellChecking isEqualToString:@"FriendExp"])
    {
     didselectDic=[Array_FriendExp  objectAtIndex:indexPath.row];
        cell_FriendExp = [Tableview_Explore cellForRowAtIndexPath:indexPath];
         set.ProfileImgeData =cell_FriendExp.Image_Profile;
    }
   
            NSMutableArray * Array_new=[[NSMutableArray alloc]init];
            [Array_new addObject:didselectDic];
            set.AllArrayData =Array_new;
     NSLog(@"Array_new11=%@",Array_new);;
    
   
    
    
     NSLog(@"Array_new22=%@",Array_new);;
    NSLog(@"indexPathrow=%ld",(long)indexPath.row);;
    
    [self.navigationController pushViewController:set animated:YES];
       NSLog(@"Array_new33=%@",Array_new);;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
    transparancyTuchView.hidden=YES;
    [self.view endEditing:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    transparancyTuchView.hidden=NO;
    
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
    transparancyTuchView.hidden=YES;
    [searchBar setShowsCancelButton:NO animated:YES];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if ([cellChecking isEqualToString:@"WorldExp"])
    {
        
    
        
        
        if (searchText.length==0)
        {
            transparancyTuchView.hidden=NO;
            [Array_WorldExp removeAllObjects];
            [Array_WorldExp addObjectsFromArray:SearchCrickArray_worldExp];
            
        }
        else
            
        {
            transparancyTuchView.hidden=YES;

            [Array_WorldExp removeAllObjects];
            
            for (NSDictionary *book in SearchCrickArray_worldExp)
            {
                NSString * string=[book objectForKey:@"title"];
               
                NSRange r=[string rangeOfString:searchText options:NSCaseInsensitiveSearch];
               
                if (r.location !=NSNotFound )
                {
                    
                    [Array_WorldExp addObject:book];
                
                }
                
            }
            
        }
        
    }
    
    
    if ([cellChecking isEqualToString:@"FriendExp"])
    {
        
        
        
        if (searchText.length==0)
        {
            transparancyTuchView.hidden=NO;
            [Array_FriendExp removeAllObjects];
            [Array_FriendExp addObjectsFromArray:SearchCrickArray_FriendExp];
            
        }
        else
            
        {
            transparancyTuchView.hidden=YES;
            
            [Array_FriendExp removeAllObjects];
            
            for (NSDictionary *book in SearchCrickArray_FriendExp)
            {
                NSString * string=[book objectForKey:@"title"];
                
                NSRange r=[string rangeOfString:searchText options:NSCaseInsensitiveSearch];
                
                if (r.location !=NSNotFound )
                {
                    
                    [Array_FriendExp addObject:book];
                    
                }
                
            }
            
        }
        
    }
 
    
    
 
    [searchBar setShowsCancelButton:YES animated:YES];
    
    [Tableview_Explore reloadData];
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    
    transparancyTuchView.hidden=YES;
    [self.view endEditing:YES];
    searchBar.text=@"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [Tableview_Explore setContentOffset:CGPointMake(0, 44) animated:YES];
    [searchbar resignFirstResponder];
    if ([cellChecking isEqualToString:@"WorldExp"])
    {
    [Array_WorldExp removeAllObjects];
    [Array_WorldExp addObjectsFromArray:SearchCrickArray_worldExp];
    [Tableview_Explore reloadData];
    }
    if ([cellChecking isEqualToString:@"FriendExp"])
    {
        [Array_FriendExp removeAllObjects];
        [Array_FriendExp addObjectsFromArray:SearchCrickArray_FriendExp];
         [Tableview_Explore reloadData];
    }

}

@end