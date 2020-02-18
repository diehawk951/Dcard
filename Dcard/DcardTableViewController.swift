//
//  DcardTableViewController.swift
//  Dcard
//
//  Created by 梁嘉峻 on 2020/2/5.
//  Copyright © 2020 梁嘉峻. All rights reserved.
//

import UIKit

class DcardTableViewController: UITableViewController {
    
    var dcards = [Feed]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //開始下拉更新的功能
        refreshControl = UIRefreshControl()
        //修改顯示文字的顏色
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.yellow]
        //顯示文字內容
        refreshControl?.attributedTitle = NSAttributedString(string: "正在更新", attributes: attributes)
        //設定元件顏色
        refreshControl?.tintColor = UIColor.white
        //設定背景顏色
        refreshControl?.backgroundColor = UIColor.black
        //將元件加入TableView的視圖中
        refreshControl?.addTarget(self, action: #selector(getData), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl

        
        DcardClient.shared.getDecard(urlString: "https://dcard.tw/_api/posts/") { (dcards) in
            if let dcards = dcards {
                self.dcards = dcards
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        print(dcards.count)
        return dcards.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dcardCell", for: indexPath) as! DecardTableViewCell
        let dcard = dcards[indexPath.row]
        var school:String
        // Configure the cell...
        cell.titalLabel.text = dcard.title
        if dcard.school != nil{
            school = dcard.school!
            cell.userTitalLabel.text = "\(dcard.forumName)|\(school)"
        }else{
            cell.userTitalLabel.text = dcard.forumName
        }
        cell.likeLabel.text = "\(dcard.likeCount)"
        cell.commentLabel.text = "\(dcard.commentCount)"
        cell.excerptLabel.text = dcard.excerpt
        
        if dcard.gender == "M" {
            cell.userImageView.image = UIImage(named: "boy")
        }else{
            cell.userImageView.image = UIImage(named: "girl")
        }
        if !dcard.media.isEmpty {
            DcardClient.shared.getImage(urlStr: dcard.media[0]?.url) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    cell.excerptImageView.isHidden = false
                    cell.excerptImageView.image = image
                }
            }
        }
        
        }else{
            cell.excerptImageView.isHidden = true
        }
        return cell
    }
    
    @objc func getData() -> () {
        DcardClient.shared.getDecard(urlString:
            "https://dcard.tw/_api/posts/"
//            "https://www.dcard.tw/_api/forums/movie/posts"
        ) { (dcards) in
            if let dcards = dcards {
                self.dcards = dcards
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl!.endRefreshing()

            }
        }
    }
    
    @IBSegueAction func showDetial(_ coder: NSCoder) -> DcardDetialTableViewController? {
        if let row = tableView.indexPathForSelectedRow?.row{
            let controller = DcardDetialTableViewController(coder: coder)
            controller?.feed = dcards[row]
            return controller
        }else{
        return nil
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
