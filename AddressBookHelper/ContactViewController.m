//
//  ContactViewController.m
//  AdressBookHelper
//
//  Created by Emerson Jose on 7/5/15.
//  Copyright (c) 2015 DevSouza Mobile. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()
{
    NSArray *contacts;
}

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[AddressBookHelper alloc] checkPermission:^(id response) {

        if(((AddressBookPermission *)response).ReturnType == ADDRESS_SUCCESS)
            [self loadContacts];
    }];
}

-(void)loadContacts
{
    [[AddressBookHelper alloc]  allContact:^(id response) {
        
        contacts = response;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [contacts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    cell.textLabel.text = [contacts[indexPath.row] valueForKey:@"name"];
    
    
    return cell;
}

@end
