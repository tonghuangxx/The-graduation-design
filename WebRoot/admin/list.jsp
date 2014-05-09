<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<table id="datalist">
                        <tr>
                            <th class="th_select_all">
                                <input type="checkbox" onclick="selectAdmins(this);" />
                                <span>全选</span>
                            </th>
                            <th>序号</th>
                            <th>姓名</th>
                            <th>登录名</th>
                            <th>电话</th>
                            <th>电子邮件</th>
                            <th>授权日期</th>
                            <th class="width100">拥有角色</th>
                            <th></th>
                        </tr>                      
                        <s:iterator value="dataList" var="l" status="st">
                        <tr>
                            <td><input type="checkbox" name="adminId" value="<s:property value="#l.id"/>"/></td>
                            <td><s:property value="#st.count"/> </td>
                            <td><s:property value="#l.name"/></td>
                            <td><s:property value="#l.admin_code"/> </td>
                            <td><s:property value="#l.telephone"/> </td>
                            <td><s:property value="#l.email"/> </td>
                            <td><s:date name="#l.enrolldate" format="yyyy-MM-dd HH:mm:ss"/> </td>
                            <td>
                                <a class="summary"  onmouseover="showDetail(true,this);" onmouseout="showDetail(false,this);">管理员管理</a>
                                <!--浮动的详细信息-->
                                <div class="detail_info">
                                <s:iterator value="#l.roleList" var="r">
                                    <s:property value="#r.role_name"/>
                                </s:iterator>
                                </div>
                            </td>
                            <td class="td_modi">
                                <input type="button" value="修改" class="btn_modify" onclick="location.href='<%=request.getContextPath() %>/user/edit?adminInfo.id=${l.id}';" />
                                <input type="button" value="删除" class="btn_delete" onclick="deleteAdmin('${l.id}');" />
                            </td>
                        </tr>
                          </s:iterator>
                    </table>