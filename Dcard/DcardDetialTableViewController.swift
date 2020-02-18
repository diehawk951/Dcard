//
//  DcardDetialTableViewController.swift
//  Dcard
//
//  Created by 梁嘉峻 on 2020/2/7.
//  Copyright © 2020 梁嘉峻. All rights reserved.
//

import UIKit

class DcardDetialTableViewController: UITableViewController {
    
    var feed: Feed!
    var feedDetail: FeedDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = feed.title
        if let url = URL(string: "https://dcard.tw/_api/posts/\(feed.id)") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let feedDetail = try? JSONDecoder().decode(FeedDetail.self, from: data) {
                    self.feedDetail = feedDetail
//                    print("URL:\(url)")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
//                        print(feedDetail.content)
                    }
                }
            }.resume()
        }
    }
    
    // MARK: - Table view data source
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detialCell", for: indexPath)
            as! DcardDetialTableViewCell
            
      
            let contentArray = feedDetail?.content.split(separator: "\n").map(String.init)
            let mutableAttributedString = NSMutableAttributedString()
            contentArray?.forEach {row in
                
                if row.contains("http") {
                    mutableAttributedString.append(imageFrom: row, textView: cell.contentTextView)
                } else {
                    mutableAttributedString.append(string: row)
                }
            }
            DispatchQueue.main.async {
                cell.contentTextView.attributedText = mutableAttributedString
                cell.contentTextView.font = UIFont.systemFont(ofSize: 20)

            }
        if feed.school != nil{
            cell.userNameLabel.text = feed.school
        }else {
            cell.userNameLabel.text = "匿名"
        }
        cell.titelLabel.text = feed.title
        if feed.gender == "M" {
            cell.userImagevView.image = UIImage(named: "boy")
        }else{
            cell.userImagevView.image = UIImage(named: "girl")
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM HH:mm"
        let timeText = formatter.string(from: feed.updatedAt)
        cell.timeLabel.text = timeText
        return cell
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
extension UIImage {
    static func image(from url: URL, handel: @escaping (UIImage?) -> ()) {
        
        guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
            handel(nil)
            return
        }
        handel(image)
    }
    
    func scaled(with scale: CGFloat) -> UIImage? {
        let size = CGSize(width: floor(self.size.width * scale), height: floor(self.size.height * scale))
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension NSMutableAttributedString {
    func append(string: String) {
        self.append(NSAttributedString(string: string + "\n"))
    }
    
    func append(imageFrom: String, textView: UITextView) {
        guard let url = URL(string: imageFrom) else { return }
        
        UIImage.image(from: url) { (image) in
            guard let image = image else { return }
            let scaledImg = image.scaled(with: UIScreen.main.bounds.width / image.size.width * 0.8)
            let attachment = NSTextAttachment()
            attachment.image = scaledImg
            self.append(NSAttributedString(attachment: attachment))
            self.append(NSAttributedString(string: "\n"))
        }
    }
}
