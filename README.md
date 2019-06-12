# NineHeadlines

## Overview  
The NineHeadlines is a simple project to present my iOS developing skill and architecture ability in 2019.   
It has only one feature which is loading news and open the news url.

## Orientation
I have introduced cocoapods in to this project. I have include pod files in this repo. Thus, you don't need to install pods before open this project. Just double click NineHeadlines.xcworkspace in the folder to open the project workspace automatically. :)  

## Devleoping Enviornment
*Xcode 10.1*  
*Swift 4*  
*macOS Majave Version 10.14.4*  

### Architeture

MVVM without RxSwift. This projest doesn't require complicated user interactives or event reaction, thus, it only has simple data binding.  Here I am using MVVM+Store architecture. 

### Model
I use Swift's own Codable to build the data model manually. I haven't decode all the key/value in the JSON reponse as many of them are never be used in this project.  

### ServerManager
I can simply use the URLSession to get json data in viewController or viewModel. However, if so, the project will be very hard to extend and test.   

The reason I introduced the ServerManager is for dependency injection, unit test and multi-services managerment. 

### Unit Test  
Use XCTest framework to test DataClient and decoding JSON data.  

### Q&A

1. Why use MVVM design pattern?   
	The MVC design pattern with Storyboard is not friendly for unit test, as the viewController will be initialized automatically. 
  In order to do unit test, we need create the ViewController's instance in unit test class. The one of the MVVM's benefits is unit test friendly. 

2. Why use MVVM without reactive?   
	RxSwift is very popular now. Most of iOS MVVM projects adapted RxSwift. I know how to use it. I might create another feature branch to intrudce RxSwift into project in the future. The reason I didn't pick RxSwift with MVVM architecture is I want to try a new way to achieve MVVM. I don't want to rely on too many third party SDK.
	
### TODO:
1. Improve the unit test coverage as much as possible.
2. Clean up and organize code even better. 
3. Make the TableViewCell with automaticDimension cell height.

## Feedback

I would love to hear the feedback from you. If you have any question or find any issue, please send me an email: [jiang.yi@siphty.com](mailto:jiang.yi@siphty.com) or [jiang.yi.work@gmail.com](mailto:jiang.yi.work@gmail.com)


Enjoy it! 
Yi Jiang
