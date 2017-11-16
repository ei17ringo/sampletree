//
//  ViewController.swift
//  sampleTree
//
//  Created by Eriko Ichinohe on 2017/11/16.
//  Copyright © 2017年 Eriko Ichinohe. All rights reserved.
//

import UIKit
import KJExpandableTableTree

class ViewController: UIViewController {
    
    // KJ Tree instances -------------------------
    var arrayTree:[Parent] = []
    var kjtreeInstance: KJTree = KJTree()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parent1 = Parent(expanded: true) { () -> [Child] in
            
            let child1 = Child()
            let child2 = Child(expanded: true, subChilds: { () -> [Child] in
                let subchild1 = Child()
                let subchild2 = Child(subChilds: { () -> [Child] in
                    let subchild1 = Child()
                    let subchild2 = Child(expanded: true, subChilds: { () -> [Child] in
                        let subchild1 = Child(expanded: true, subChilds: { () -> [Child] in
                            let subchild1 = Child(expanded: true, subChilds: { () -> [Child] in
                                let subchild1 = Child()
                                return [subchild1]
                            })
                            return [subchild1]
                        })
                        return [subchild1]
                    })
                    return [subchild1, subchild2]
                })
                return [subchild1, subchild2]
            })
            let child3 = Child()
            
            return [child1, child2, child3]
        }
        let parent2 = Parent(key: "secondChild")
        let parent3 = Parent { () -> [Child] in
            let child1 = Child(subChilds: { () -> [Child] in
                let subchild1 = Child(subChilds: { () -> [Child] in
                    let subchild1 = Child()
                    let subchild2 = Child()
                    return [subchild1, subchild2]
                })
                return [subchild1]
            })
            
            let child2 = Child()
            let child3 = Child()
            let child4 = Child(subChilds: { () -> [Child] in
                let subchild1 = Child()
                return [subchild1]
            })
            return [child1, child2, child3, child4]
        }
        arrayTree.append(parent1)
        arrayTree.append(parent2)
        arrayTree.append(parent3)
        kjtreeInstance = KJTree(Parents: arrayTree)
        kjtreeInstance.isInitiallyExpanded = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView(frame: .zero)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let total = kjtreeInstance.tableView(tableView, numberOfRowsInSection: section)
        return total
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let node = kjtreeInstance.cellIdentifierUsingTableView(tableView, cellForRowAt: indexPath)
        let indexTuples = node.index.components(separatedBy: ".")
        
        if indexTuples.count == 1  || indexTuples.count == 4 {
            
            // Parents
            let cellIdentifierParents = "ParentsTableViewCellIdentity"
            var cellParents: ParentsTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierParents) as? ParentsTableViewCell
            if cellParents == nil {
                tableView.register(UINib(nibName: "ParentsTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifierParents)
                cellParents = tableView.dequeueReusableCell(withIdentifier: cellIdentifierParents) as? ParentsTableViewCell
            }
            cellParents?.cellFillUp(indexParam: node.index, tupleCount: indexTuples.count)
            cellParents?.selectionStyle = .none
            
            if node.state == .open {
                cellParents?.buttonState.setImage(UIImage(named: "minus"), for: .normal)
            }else if node.state == .close {
                cellParents?.buttonState.setImage(UIImage(named: "plus"), for: .normal)
            }else{
                cellParents?.buttonState.setImage(nil, for: .normal)
            }
            
            return cellParents!
            
        }else if indexTuples.count == 2{
            
            // Parents
            let cellIdentifierChilds = "Childs2ndStageTableViewCellIdentity"
            var cellChild: Childs2ndStageTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierChilds) as? Childs2ndStageTableViewCell
            if cellChild == nil {
                tableView.register(UINib(nibName: "Childs2ndStageTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifierChilds)
                cellChild = tableView.dequeueReusableCell(withIdentifier: cellIdentifierChilds) as? Childs2ndStageTableViewCell
            }
            cellChild?.cellFillUp(indexParam: node.index)
            cellChild?.selectionStyle = .none
            
            if node.state == .open {
                cellChild?.buttonState.setImage(UIImage(named: "minus"), for: .normal)
            }else if node.state == .close {
                cellChild?.buttonState.setImage(UIImage(named: "plus"), for: .normal)
            }else{
                cellChild?.buttonState.setImage(nil, for: .normal)
            }
            
            return cellChild!
            
        }else if indexTuples.count == 3 || indexTuples.count == 5 || indexTuples.count == 6 || indexTuples.count == 7{
            
            // Parents
            let cellIdentifierChilds = "Childs3rdStageTableViewCellIdentity"
            var cellChild: Childs3rdStageTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierChilds) as? Childs3rdStageTableViewCell
            if cellChild == nil {
                tableView.register(UINib(nibName: "Childs3rdStageTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifierChilds)
                cellChild = tableView.dequeueReusableCell(withIdentifier: cellIdentifierChilds) as? Childs3rdStageTableViewCell
            }
            cellChild?.cellFillUp(indexParam: node.index, tupleCount: indexTuples.count)
            cellChild?.selectionStyle = .none
            
            if node.state == .open {
                cellChild?.buttonState.setImage(UIImage(named: "minus"), for: .normal)
            }else if node.state == .close {
                cellChild?.buttonState.setImage(UIImage(named: "plus"), for: .normal)
            }else{
                cellChild?.buttonState.setImage(nil, for: .normal)
            }
            
            return cellChild!
            
        }else{
            // Childs
            // grab cell
            var tableviewcell = tableView.dequeueReusableCell(withIdentifier: "cellidentity")
            if tableviewcell == nil {
                tableviewcell = UITableViewCell(style: .default, reuseIdentifier: "cellidentity")
            }
            
            tableviewcell?.backgroundColor = UIColor.lightGray
            tableviewcell?.textLabel?.text = node.index
            tableviewcell?.selectionStyle = .none
            return tableviewcell!
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let node = kjtreeInstance.tableView(tableView, didSelectRowAt: indexPath)
        print(node.index)
        print(node.key)
        // if you've added any identifier or used indexing format
        print(node.givenIndex)
    }
}
