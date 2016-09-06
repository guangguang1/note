//
//  SettingViewController1.swift
//
//
//  Created by 梁慧广 on 16/4/7.
//
//

import UIKit

class SettingViewController1: UIViewController,UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate {
    
    var rightBtn: UIBarButtonItem?
    var imageview: UIImageView?
    var table: UITableView?
    var touxiangImage: UIImageView?
    var nameLab: UILabel?
    var tapGesture1: UITapGestureRecognizer?
    var tapGesture2: UITapGestureRecognizer?
    var imagePicker : UIImagePickerController? = nil
    var actionSheet : UIActionSheet? = nil
    var imagesList : [UIImage] = []
    var table1: UITableView?
    var title1 = ["安全指数","修改密码","修改保密问题"]
    var cancelBtn: UIButton?
    var documentsDirectory:NSString?
    var imageFilePath:String?
    var isFullScreen: Bool = false
    var selfPhoto:UIImage?
    var touxiangButton:UIButton?
    let imagePickerController: UIImagePickerController = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fullPath: String =   NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent("currentImage.png")
        selfPhoto = UIImage(contentsOfFile: fullPath)
        
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        self.navigationItem.title = "我的账户"
        rightBtn = UIBarButtonItem(title: "切换账号", style: UIBarButtonItemStyle.Plain, target: self, action: "changeUser")
        self.navigationItem.rightBarButtonItem = rightBtn
        
        imageview = UIImageView(frame: CGRect(x: 0, y: 60, width: self.view.bounds.width, height: 100))
        imageview?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(imageview!)
        
        touxiangImage = UIImageView(frame: CGRect(x: 20, y: 76 , width: 60, height: 60))
        touxiangImage?.image = selfPhoto
        touxiangImage?.layer.cornerRadius = 30
        touxiangImage?.clipsToBounds = true
        touxiangImage?.userInteractionEnabled = true
        self.view.addSubview(touxiangImage!)
        
        touxiangButton = UIButton(frame: CGRect(x: 20, y: 76 , width: 60, height: 60))
        touxiangButton?.addTarget(self, action: "changeImage:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(touxiangButton!)
        
        nameLab = UILabel(frame: CGRect(x: 100, y: 86 , width: 130, height: 40))
        nameLab?.text = NSUserDefaults.standardUserDefaults().valueForKey("UserName") as? String
        nameLab?.userInteractionEnabled = true
        self.view.addSubview(nameLab!)
        
        tapGesture1 = UITapGestureRecognizer(target: self, action: "changeImage:")
        //touxiangImage?.addGestureRecognizer(tapGesture1!)
        tapGesture2 = UITapGestureRecognizer(target: self, action: "changeName")
        nameLab?.addGestureRecognizer(tapGesture2!)
        
        table1 = UITableView(frame: CGRect(x: 0, y: 200, width: self.view.bounds.width, height: 132))
        table1?.delegate = self
        table1?.dataSource = self
        self.view.addSubview(table1!)
        
        
        cancelBtn = UIButton(frame: CGRect(x: 0, y: 360, width: self.view.bounds.width, height: 60))
        cancelBtn?.backgroundColor = UIColor.orangeColor()
        cancelBtn?.setTitle("退出应用", forState: UIControlState.Normal)
        cancelBtn?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.view.addSubview(cancelBtn!)
        cancelBtn?.addTarget(self, action: "exit", forControlEvents: UIControlEvents.TouchDown)
        
        
        // Do any additional setup after loading the view.
    }
    
    func changeImage(sender:UIButton)
    {
        self.imagePickerController.delegate = self
        // 设置是否可以管理已经存在的图片或者视频
        self.imagePickerController.allowsEditing = true
        
        // 判断是否支持相机
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            let alertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            //在iPad上使用表单（ActionSheet）需要设置描点(anchor point)
            var popover = alertController.popoverPresentationController
            if (popover != nil){
                popover?.sourceView = sender
                popover?.sourceRect = sender.bounds
                popover?.permittedArrowDirections = UIPopoverArrowDirection.Any
            }
            
            
            let cameraAction: UIAlertAction = UIAlertAction(title: "拍照换头像", style: .Default) { (action: UIAlertAction!) -> Void in
                // 设置类型
                self.imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
                self.presentViewController(self.imagePickerController, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
            
            
            
            let photoLibraryAction: UIAlertAction = UIAlertAction(title: "从相册选择换头像", style: .Default) { (action: UIAlertAction!) -> Void in
                // 设置类型
                self.imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                //改navigationBar背景色
                self.imagePickerController.navigationBar.barTintColor = UIColor(red: 171/255, green: 202/255, blue: 41/255, alpha: 1.0)
                //改navigationBar标题色
                self.imagePickerController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
                //改navigationBar的button字体色
                self.imagePickerController.navigationBar.tintColor = UIColor.whiteColor()
                self.presentViewController(self.imagePickerController, animated: true, completion: nil)
            }
            alertController.addAction(photoLibraryAction)
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
        }
            
        else{
            let alertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            //设置描点(anchor point)
            var popover = alertController.popoverPresentationController
            if (popover != nil){
                popover?.sourceView = sender
                popover?.sourceRect = sender.bounds
                popover?.permittedArrowDirections = UIPopoverArrowDirection.Any
            }
            
            let photoLibraryAction: UIAlertAction = UIAlertAction(title: "从相册选择换头像", style: .Default) { (action: UIAlertAction!) -> Void in
                // 设置类型
                self.imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                //改navigationBar背景色
                self.imagePickerController.navigationBar.barTintColor = UIColor(red: 171/255, green: 202/255, blue: 41/255, alpha: 1.0)
                //改navigationBar标题色
                self.imagePickerController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
                //改navigationBar的button字体色
                self.imagePickerController.navigationBar.tintColor = UIColor.whiteColor()
                self.presentViewController(self.imagePickerController, animated: true, completion: nil)
            }
            alertController.addAction(photoLibraryAction)
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        var image: UIImage!
        // 判断，图片是否允许修改
        if(picker.allowsEditing){
            //裁剪后图片
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        }else{
            //原始图片
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        /* 此处info 有六个值
        114         * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
        115         * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
        116         * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
        117         * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
        118         * UIImagePickerControllerMediaURL;       // an NSURL
        119         * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
        120         * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
        121         */
        // 保存图片至本地，方法见下文
        self.saveImage(image, newSize: CGSize(width: 256, height: 256), percent: 0.5, imageName: "currentImage.png")
        let fullPath: String = NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent("currentImage.png")
        println("fullPath=\(fullPath)")
        let savedImage: UIImage = UIImage(contentsOfFile: fullPath)!
        self.isFullScreen = false
        self.touxiangImage!.image = savedImage
        //在这里调用网络通讯方法，上传头像至服务器...
    }
    // 当用户取消时，调用该方法
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //保存图片至沙盒
    func saveImage(currentImage: UIImage, newSize: CGSize, percent: CGFloat, imageName: String){
        //压缩图片尺寸
        UIGraphicsBeginImageContext(newSize)
        currentImage.drawInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //高保真压缩图片质量
        //UIImageJPEGRepresentation此方法可将图片压缩，但是图片质量基本不变，第二个参数即图片质量参数。
        let imageData: NSData = UIImageJPEGRepresentation(newImage, percent)
        // 获取沙盒目录,这里将图片放在沙盒的documents文件夹中
        let fullPath: String = NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent(imageName)
        NSLog("fullPath\(fullPath)")
        // 将图片写入文件
        imageData.writeToFile(fullPath, atomically: false)
    }
    
    //实现点击图片预览功能，滑动放大缩小，带动画
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.isFullScreen = !self.isFullScreen
        
        let touch: UITouch = touches.first as! UITouch
        let touchPoint: CGPoint  = touch.locationInView(self.view)
        let imagePoint: CGPoint = self.touxiangImage!.frame.origin
        //touchPoint.x ，touchPoint.y 就是触点的坐标
        // 触点在imageView内，点击imageView时 放大,再次点击时缩小
        if(imagePoint.x <= touchPoint.x && imagePoint.x + self.touxiangImage!.frame.size.width >= touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.touxiangImage!.frame.size.height >= touchPoint.y){
            // 设置图片放大动画
            UIView.beginAnimations(nil, context: nil)
            // 动画时间
            UIView.setAnimationDuration(1)
            
            if (isFullScreen) {
                // 放大尺寸
                self.touxiangImage!.frame = CGRectMake(0, 0, 480, 320)
            }
            else {
                // 缩小尺寸
                self.touxiangImage!.frame = CGRectMake(100, 100, 128, 128)
            }
            // commit动画
            UIView.commitAnimations()
        }
    }
    
    func changeName()
    {
        NSLog("changeName")
        self.navigationController?.pushViewController(ChangeNameViewController(), animated: true)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return title1.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cellid = "sundy"
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellid) as? UITableViewCell
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellid)
            
        }
        if(indexPath.row == 0)
        {
            cell?.textLabel?.text = title1[indexPath.row]
            cell?.detailTextLabel?.text  = "123"
            return cell!
        }
        else
        {
            cell?.textLabel?.text = title1[indexPath.row]
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return cell!
        }
    }
    func exit()
    {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    
    func changeUser()
    {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
