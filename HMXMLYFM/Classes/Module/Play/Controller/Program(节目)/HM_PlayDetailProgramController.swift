//
//  HM_PlayDetailProgramController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/7/1.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import LTScrollView

class HM_PlayDetailProgramController: HM_BasisViewController, LTTableViewProtocal {

    private var playDetailTracks:HM_PlayDetailTracksModel?
    
    private let HM_PlayDetailProgramCellID = "HM_PlayDetailProgramCell"
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y:0, width:SCREEN_WIDTH, height: SCREEN_HEIGHT), self, self, nil)
        tableView.register(HM_PlayDetailProgramCell.self, forCellReuseIdentifier: HM_PlayDetailProgramCellID)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        // Do any additional setup after loading the view.
    }
    
    var playDetailTracksModel:HM_PlayDetailTracksModel?{
        didSet{
            guard let model = playDetailTracksModel else {return}
            self.playDetailTracks = model
            self.tableView.reloadData()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension HM_PlayDetailProgramController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playDetailTracks?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HM_PlayDetailProgramCell = tableView.dequeueReusableCell(withIdentifier: HM_PlayDetailProgramCellID, for: indexPath) as! HM_PlayDetailProgramCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.playDetailTracksList = self.playDetailTracks?.list?[indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumId = self.playDetailTracks?.list?[indexPath.row].albumId ?? 0
        let trackUid = self.playDetailTracks?.list?[indexPath.row].trackId ?? 0
        let uid = self.playDetailTracks?.list?[indexPath.row].uid ?? 0
        let vc = HM_BasisNavigationController.init(rootViewController: HM_PlayViewController(albumId:albumId, trackUid:trackUid, uid:uid))
        self.present(vc, animated: true, completion: nil)
    }
}
