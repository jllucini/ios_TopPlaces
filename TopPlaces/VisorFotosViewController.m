//
//  VisorFotosViewController.m
//  TopPlaces
//
//  Created by Jose Luis Lucini Reviriego on 12/10/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "VisorFotosViewController.h"

@interface VisorFotosViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSDictionary *photo;

@end

@implementation VisorFotosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initViewer:self.photo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initPhoto:(NSDictionary *)photo
{
    self.photo = photo;
    //[self initViewer:self.photo];
}

-(void)initViewer:(NSDictionary *)photo
{
    NSURL *photoUrl = [FlickrFetcher URLforPhoto:photo format:FlickrPhotoFormatOriginal];
    NSData *data = [NSData dataWithContentsOfURL:photoUrl];
    self.image = [UIImage imageWithData:data];
    self.imageView.image = self.image;
    [self.imageView sizeToFit];
    [self setupScrollView];
    }

-(void)setupScrollView
{
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
