//
//  DatePickVC.m
//  二货
//
//  Created by 管章鹏 on 2018/7/25.
//  Copyright © 2018年 管章鹏. All rights reserved.
//


#import "DatePickVC.h"
//#import "UIImage+Extension.h"
//#import "PGDatePickManager.h"
#import "HooDatePicker/HooDatePicker.h"
#import "timeButton.h"

#define SelectedColor [UIColor redColor]
#define NormalColor [UIColor lightGrayColor]

typedef NS_OPTIONS(NSUInteger, SelectedTimeType) {
    SelectedTimeTypeUnknown       = 0,
    SelectedTimeTypeMonth  = 1 << 0,
    SelectedTimeTypeDayStart     = 1 << 1,
    SelectedTimeTypeDayEnd     = 1 << 2,
};

@interface DatePickVC ()<UITextFieldDelegate,HooDatePickerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *selTypeBtn;
@property (weak, nonatomic) IBOutlet UIView *dayView;
@property (weak, nonatomic) IBOutlet UIView *monthView;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;


@property (weak, nonatomic) IBOutlet timeButton *btn_startTime;
@property (weak, nonatomic) IBOutlet timeButton *btn_enTime;
@property (weak, nonatomic) IBOutlet timeButton *btn_selectMonth;

@property (nonatomic, strong) HooDatePicker *datePicker;
@property (assign, nonatomic) SelectedTimeType selectType;
@property(weak,nonatomic) NSString *timeStr;
@end


@implementation DatePickVC

#pragma mark getter method
-(HooDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[HooDatePicker alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.removeBtn.frame) + 25, [UIScreen mainScreen].bounds.size.width, 240)];
        _datePicker.delegate = self;
        NSDateFormatter *dateFormatter = [NSDate shareDateFormatter];
        [dateFormatter setDateFormat:kDateFormatYYYYMMDD];
        NSDate *maxDate = [dateFormatter dateFromString:@"2050-01-01"];
        NSDate *minDate = [dateFormatter dateFromString:@"2016-01-01"];
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [_datePicker setDate:[NSDate date] animated:YES];
        _datePicker.minimumDate = minDate;
        _datePicker.maximumDate = maxDate;
        [self.view addSubview: _datePicker];
    }
    return _datePicker;
}

#pragma mark - FlatDatePicker Delegate

- (void)datePicker:(HooDatePicker *)datePicker dateDidChange:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    if (datePicker.datePickerMode == HooDatePickerModeDate) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
     else if (datePicker.datePickerMode == HooDatePickerModeYearAndMonth){
        [dateFormatter setDateFormat:@"yyyy-MM"];
    }
    NSString *value = [dateFormatter stringFromDate:date];
    
    switch (self.selectType) {
        case SelectedTimeTypeDayStart:
            [self.btn_startTime setTitle:value forState:UIControlStateNormal];
            break;
        case SelectedTimeTypeDayEnd:
            [self.btn_enTime setTitle:value forState:UIControlStateNormal];
            break;
        case SelectedTimeTypeMonth:
            [self.btn_selectMonth setTitle:value forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupUI];
}
-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];

    self.selTypeBtn.contentEdgeInsets = UIEdgeInsetsMake(3, 15, 3, 15);
    self.selTypeBtn.layer.cornerRadius = 13;
    self.selTypeBtn.layer.masksToBounds = YES;
    self.selTypeBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.selTypeBtn.layer.borderWidth = 1.0f;
    self.selTypeBtn.backgroundColor = [UIColor colorWithRed:242.0/250.0 green:242.0/250.0 blue:242.0/250.0 alpha:1.0];
    [self.selTypeBtn setTitle:@"按月选择" forState:UIControlStateNormal];
    [self.selTypeBtn setTitle:@"按日选择" forState:UIControlStateSelected];
    
    self.datePicker.datePickerMode = HooDatePickerModeYearAndMonth;
    self.btn_selectMonth.selected = YES;//默认选中月
    self.selectType = SelectedTimeTypeMonth;
//    [self.datePicker selectedDate];

}
// 点击清除
- (IBAction)removeBtn_Click:(id)sender {
    [self.datePicker removeFromSuperview];
    self.datePicker = nil;
    
    self.btn_startTime.selected = self.btn_enTime.selected = self.btn_selectMonth.selected = NO;
    [self.btn_startTime setTitle:@"开始时间" forState:UIControlStateNormal];
    [self.btn_enTime setTitle:@"结束时间" forState:UIControlStateNormal];
    [self.btn_selectMonth setTitle:@"选择月份" forState:UIControlStateNormal];
}

- (IBAction)selectTime_btnClick:(UIButton *)btn {
    NSInteger tag = btn.tag;
    
    btn.selected = btn.selected ? YES : !btn.selected;
    
    if (tag == 100) {
        //开始时间
        self.btn_enTime.selected = NO;
        self.selectType = SelectedTimeTypeDayStart;
        self.datePicker.datePickerMode = HooDatePickerModeDate;
        
    }else if(tag == 101){
        //结束时间
        self.btn_startTime.selected = NO;
        self.selectType = SelectedTimeTypeDayEnd;
       self.datePicker.datePickerMode = HooDatePickerModeDate;
    }else if(tag == 102){
        //选择月份
        self.selectType = SelectedTimeTypeMonth;
       self.datePicker.datePickerMode = HooDatePickerModeYearAndMonth;
       
    }
}
- (IBAction)selTypeBtn_Click:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        self.dayView.hidden = NO;
        self.monthView.hidden = YES;
  
        
        if(self.btn_startTime.selected){
              self.selectType = SelectedTimeTypeDayStart;
        } else if(self.btn_enTime.selected){
             self.selectType = SelectedTimeTypeDayEnd;
        }else{
            //如果两个都没有选中 默认让开始时间选中
            self.btn_startTime.selected = YES;
            self.selectType = SelectedTimeTypeDayStart;
        }
            self.datePicker.datePickerMode = HooDatePickerModeDate;
      
      
    }else{
        self.monthView.hidden = NO;
        self.dayView.hidden = YES;
        self.selectType = SelectedTimeTypeMonth;
       self.datePicker.datePickerMode = HooDatePickerModeYearAndMonth;
        
      
    }
}

- (void)cancelClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)finishClick{
    
    
    //HooDatePickerModeDate
    if (self.selTypeBtn.selected ) {
        NSLog(@"%@",[NSString stringWithFormat:@"%@ 至 %@",self.btn_startTime.titleLabel.text,self.btn_enTime.titleLabel.text]);
    }
    else {
        NSLog(@"%@",self.btn_selectMonth.titleLabel.text);
    }
     [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)setupNav{
    self.title = @"选择时间";
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick)];
     UIBarButtonItem *finishBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishClick)];
    
    self.navigationItem.leftBarButtonItem = cancelBtn;
    self.navigationItem.rightBarButtonItem =finishBtn;
}

@end
