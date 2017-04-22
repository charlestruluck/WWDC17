
// Helper for projects I've worked on. Sets up the table view.

import UIKit

class ProjectObject: UIView, UITableViewDataSource, UITableViewDelegate {
    
    let descript: [String]
    let title: [String]
    
    var tableView: UITableView
    
    private var dynamics = Dynamics()
    private var startFrame = CGRect()
    
    init(titles: [String], descriptions: [String], frame: CGRect) {
        self.title = titles
        self.descript = descriptions
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        
        super.init(frame: frame)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.backgroundColor = .clear
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.tableView.isScrollEnabled = false
        
        backgroundColor = .clear
        addSubview(tableView)
        startFrame = self.frame
    }
    
    // Number of lines = number of elements in the title array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.title.count
    }
    
    // Set up each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as UITableViewCell
        cell.textLabel?.text = self.title[indexPath.row]
        cell.backgroundColor = .clear
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
        cell.textLabel?.textColor = .white
        cell.textLabel?.textAlignment = .center
        cell.selectionStyle = .none
        return cell
    }
    
    // Setup when cell is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as UITableViewCell
        cell.backgroundColor = .clear
        cell.isHidden = true
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.0, options: [], animations: {
            tableView.alpha = 0
            self.dynamics.addObject(object: self)
        }) { (true) in
            if self.title[indexPath.row] == "Sandbox Mode" {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: { 
                    TimelineManager().toView(2)
                })
            }
            let projectDescription = ProjectDescription(title: self.title[indexPath.row], description: self.descript[indexPath.row], frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            self.dynamics.removeObject(object: self)
            self.frame.origin.y = self.startFrame.origin.y
            self.addSubview(projectDescription)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                self.dynamics.removeObject(object: self)
                tableView.alpha = 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.dynamics.removeObject(object: self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
