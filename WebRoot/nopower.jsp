<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>���ڣ�NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" />
        <script language="javascript" type="text/javascript">
            var timer;
            //������ת�Ķ�ʱ��
            function startTimes() {
                timer = window.setInterval(showSecondes,1000);
            }

            var i = 5;
            function showSecondes() {
                if (i > 0) {
                    i--;
                    document.getElementById("secondes").innerHTML = i;
                }
                else {
                    window.clearInterval(timer);
                    location.href = "main";
                }
            }

            //ȡ����ת
            function resetTimer() {
                if (timer != null && timer != undefined) {
                    window.clearInterval(timer);
                    location.href = "main";
                }
            }
        </script> 
    </head>
    <body class="error_power_page" onload="startTimes();">
        <h1 id="error">
	        ����Ȩ���ʴ�ҳ�棬&nbsp;<span id="secondes">5</span>&nbsp;����Զ���ת��������ת����&nbsp;
            <a class="index.html" href="javascript:resetTimer();">����</a>
        </h1>
    </body>
</html>

