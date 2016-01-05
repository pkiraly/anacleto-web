var activeTab = "fieldQueryTab";
var tabNameList = ["fieldQueryTab", "proximityQueryTab"];
var tabList = {fieldQueryTab: null, proximityQueryTab: null};

function toggleTab(id) {
	hideTab(activeTab);
	showTab(id);
	activeTab = id;
	currentSearchForm = (id == "fieldQueryTab")
			? 'field_searchform' : 'proximity_searchform';
}

function showTab(id) {
	checkTab(id);
	tabList[id].style.display = 'block';
	tabList[id + 'Button'].style.backgroundColor = '#fff';
}

function hideTab(id) {
	checkTab(id);
	tabList[id].style.display = 'none';
	tabList[id + 'Button'].style.backgroundColor = '#ccc';
}

function checkTab(id) {
	if(tabList[id] == null) {
		tabList[id] = document.getElementById(id);
		if(tabList[id] == null) {
			// alert(id + " null!!!");
		}
	}
	if(tabList[id + 'Button'] == null) {
		tabList[id + 'Button'] = document.getElementById(id + 'Button');
		if(tabList[id + 'Button'] == null) {
			// alert(id + 'Button' + " null!!!");
		}
	}
}