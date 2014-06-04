<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"  %>
<form action="${pageContext.request.contextPath}/bill/search" method="post" id="serachBillForm">
                <!--查询-->
                <div class="search_add">                        
                    <div>身份证：<input type="text"  value="" name="form.account.idcard_no" class="text_search" /></div>
                    <div>账务账号：<input type="text" value="" name="form.account.login_name" class="width100 text_search" /></div>                            
                    <div>姓名：<input type="text" value="" name="form.account.real_name" class="width70 text_search" /></div>
                    <div>
                        <select class="select_search" id="selYears" name="selYears">
                        </select>
                        年
                        <select class="select_search" id="selMonths" name="selMonths">
                        </select>
                        月
                    </div>
                    <div><input type="button" value="搜索" class="btn_search" onclick="to_searchBill();" /></div>
                </div>  
 </form>
 <div id="datapages">
	<jsp:include page="/bill/list.jsp"></jsp:include>
</div>
        <script language="javascript" type="text/javascript">
        $(function(){
        	initialYearAndMonth();
         });
            //写入下拉框中的年份和月份
            function initialYearAndMonth() {
                //写入最近3年
                var yearObj = document.getElementById("selYears");
                var year = (new Date()).getFullYear();
                for (var i = 0; i <= 2; i++) {
                    var opObj = new Option(year - i, year - i);
                    yearObj.options[i] = opObj;
                }
                //写入 12 月
                var monthObj = document.getElementById("selMonths");
                var opObj = new Option("全部", "");
                monthObj.options[0] = opObj;
                for (var i = 1; i <= 12; i++) {
                    var opObj = new Option(i, i);
                    monthObj.options[i] = opObj;
                }
            }

            /**
        	 * 显示某一页数据
        	 * @param pageNum
        	 * @return
        	 */
        	function numberPage(pageNum){
        		$("#pageNum").val(pageNum);
        		AT.postFrm("#serachBillHinForm", callFunction);
        	}
        	/**
        	 * 回调函数
        	 * @param data
        	 * @return
        	 */
        	function callFunction(data){
        		$("#datapages").html(data);
        	}

        	function to_searchBill(){
        		AT.postFrm("#serachBillForm", callFunction);
        	}
        </script>
