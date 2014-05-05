//排序按钮的点击事件
function sort(btnObj) {
	var rent = document.getElementById("rent");
	var base_cost = document.getElementById("base_cost");
	var base_duration = document.getElementById("base_duration");
	if (btnObj.className == "sort_desc") {
		//如果点的是基费
		if (btnObj.value == "基费") {
			//判断月租和时长的className是否是sort_desc  如果是就不修改它的className
			if (rent.className == "sort_desc"
					&& base_duration.className == "sort_desc") {
				location.href = "feeSortList?sort=asc&col=base_cost&rentSort=desc&base_durationSort=desc&base_costSort=asc";
			}
			if (rent.className == "sort_desc"
					&& base_duration.className != "sort_desc") {
				location.href = "feeSortList?sort=asc&col=base_cost&rentSort=desc&base_durationSort=asc&base_costSort=asc";
			}
			if (rent.className != "sort_desc"
					&& base_duration.className == "sort_desc") {
				location.href = "feeSortList?sort=asc&col=base_cost&rentSort=asc&base_durationSort=desc&base_costSort=asc";
			}
			if (rent.className != "sort_desc"
					&& base_duration.className != "sort_desc") {
				location.href = "feeSortList?sort=asc&col=base_cost&rentSort=asc&base_durationSort=asc&base_costSort=asc";
			}
		}
		if (btnObj.value == "时长") {
			if (rent.className == "sort_desc"
					&& base_cost.className == "sort_desc") {
				location.href = "feeSortList?sort=asc&col=base_duration&rentSort=desc&base_costSort=desc&base_durationSort=asc";
			}
			if (rent.className == "sort_desc"
					&& base_cost.className != "sort_desc") {
				location.href = "feeSortList?sort=asc&col=base_duration&rentSort=desc&base_costSort=asc&base_durationSort=asc";
			}
			if (rent.className != "sort_desc"
					&& base_cost.className == "sort_desc") {
				location.href = "feeSortList?sort=asc&col=base_duration&rentSort=asc&base_costSort=desc&base_durationSort=asc";
			}
			if (rent.className != "sort_desc"
					&& base_cost.className != "sort_desc") {
				location.href = "feeSortList?sort=asc&col=base_duration&rentSort=asc&base_costSort=asc&base_durationSort=asc";
			}
		}
	} else {
		if (btnObj.value == "基费") {
			if (rent.className == "sort_desc"
					&& base_duration.className == "sort_desc") {
				location.href = "feeSortList?sort=desc&col=base_cost&rentSort=desc&base_durationSort=desc&base_costSort=desc";
			}
			if (rent.className == "sort_desc"
					&& base_duration.className != "sort_desc") {
				location.href = "feeSortList?sort=desc&col=base_cost&rentSort=desc&base_durationSort=asc&base_costSort=desc";
			}
			if (rent.className != "sort_desc"
					&& base_duration.className == "sort_desc") {
				location.href = "feeSortList?sort=desc&col=base_cost&rentSort=asc&base_durationSort=desc&base_costSort=desc";
			}
			if (rent.className != "sort_desc"
					&& base_duration.className != "sort_desc") {
				location.href = "feeSortList?sort=desc&col=base_cost&rentSort=asc&base_durationSort=asc&base_costSort=desc";
			}
		}
		if (btnObj.value == "时长") {
			if (rent.className == "sort_desc"
					&& base_cost.className == "sort_desc") {
				location.href = "feeSortList?sort=desc&col=base_duration&rentSort=desc&base_costSort=desc&base_durationSort=desc";
			}
			if (rent.className == "sort_desc"
					&& base_cost.className != "sort_desc") {
				location.href = "feeSortList?sort=desc&col=base_duration&rentSort=desc&base_costSort=asc&base_durationSort=desc";
			}
			if (rent.className != "sort_desc"
					&& base_cost.className == "sort_desc") {
				location.href = "feeSortList?sort=desc&col=base_duration&rentSort=asc&base_costSort=desc&base_durationSort=desc";
			}
			if (rent.className != "sort_desc"
					&& base_cost.className != "sort_desc") {
				location.href = "feeSortList?sort=desc&col=base_duration&rentSort=asc&base_costSort=asc&base_durationSort=desc";
			}
		}
	}
}

//启用
function startFee(feeId) {
	var r = window.confirm("确定要启用此资费吗？资费启用后将不能修改和删除。");
	if (r) {
		location.href = "../control/feeStartControl?m.id=2&operation=u&feeId="
				+ feeId;
	} else {
		return false;
	}
}
//删除
function deleteFee(feeId) {
	var r = window.confirm("确定要删除此资费吗？");
	if (r == true) {
		window.location = "../control/feeDelControl?m.id=2&operation=d&feeId="
				+ feeId;
	} else {
		return false;
	}
}

//保存结果的提示
function showResultDiv(flag) {
	var divResult = document.getElementById("operate_result_info");
	if (flag) {
		divResult.style.display = "block";
	} else {
		divResult.style.display = "none";
	}
}
$(function() {
	if ($('#msg').html() == "") {
		showResultDiv(false);
	} else {
		showResultDiv(true);
		window.setTimeout("showResultDiv(false);", 5000);
	}
});