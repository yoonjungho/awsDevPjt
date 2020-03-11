<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>


<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script>


var m_child_cnt = 0;
var pArray ;
var nArray ;


function fn_init()
{
	fn_plus();
}

function fn_plus(){
	m_child_cnt++;
	
	var div  = document.createElement("div");
	var str1 = document.createTextNode("동전 : ");
	var str2 = document.createTextNode("수량 : ");
	var pTxt = document.createElement("input");
	var nTxt = document.createElement("input");
	
	div.setAttribute ("id"   , "ch" + m_child_cnt);
	pTxt.setAttribute("id"   , "p"  + m_child_cnt);
	nTxt.setAttribute("id"   , "n"  + m_child_cnt);
	pTxt.setAttribute("type" , "text");
	nTxt.setAttribute("type" , "text");
	
	div.appendChild(str1);
	div.appendChild(pTxt);
	div.appendChild(str2);
	div.appendChild(nTxt);
	
	document.getElementById("parentDiv").appendChild(div);
	
}
function fn_minus(){
	if(m_child_cnt <= 0){
		return;
	}
	
	document.getElementById("parentDiv").removeChild(document.getElementById("ch"+m_child_cnt));
	m_child_cnt--;
}
function fn_submit(){
	
	var msg = fn_isValidation();
	if(msg != ""){
		alert(msg);
		return;
	}
	var tot = document.getElementById("tot_txt");
	
	var p_num = "";
	var n_num = "";
	for (var i = 0; i < pArray.length; i++) 
	{
		p_num += "" + pArray[i];
		if(pArray.length != i+1 ) p_num += ",";
	}
	for (var i = 0; i < nArray.length; i++) 
	{
		n_num += "" + nArray[i];
		if(nArray.length != i+1 ) n_num += ",";
	}
	var data  = {"tot"    : tot.value, 
            	 "p_num"  : p_num,
            	 "n_num"  : n_num,
				};
	
	//ajax
	 $.ajax({
        type		: "GET",
        url 		: "/AwsDevTest/resultValue",
        dataType    : "json",
        data		:  data, 
        //contentType : "application/json",
        success 	: function(resultData) 
        {
        	alert("result = "+resultData);
        },
        error		: function(result) 
        {
        	//alert("error = "+error.responseText);
        	document.getElementById("result_txt").value = result.responseText;
        }
    }); 
}

function fn_isValidation()
{
	
	var parent = document.getElementById("parentDiv");
	var inputs = parent.getElementsByTagName("input");
	
	pArray = new Array();
	nArray = new Array();
	var pCnt = 0;
	var nCnt = 0;
	
	var msg = "";
	
	var tot_txt = document.getElementById("tot_txt");
	if(tot_txt == null || tot_txt == undefined || tot_txt.value.trim() == "" || isNaN(tot_txt.value) 
		|| tot_txt.value > 10000 || tot_txt.value < -1
	){
		msg = "지폐값을 숫자로 입력하세요 \n 범위 0~10000";
		 return msg;
	}
	
	
	for (var i = 0; i < inputs.length; i++) {
		if(inputs[i].id.indexOf("p") > -1 || inputs[i].id.indexOf("n") > -1)
		{
			if(isNaN(inputs[i].value))
			{
				msg = "숫자만 입력가능합니다.";
				break;
			}
			if(inputs[i].value > 10000 || inputs[i].value < 0)
			{
				msg = "0 ~ 10000까지만 입력 가능합니다.";
				break;
			}
			if(inputs[i].value == null || inputs[i].value == undefined  || inputs[i].value.trim() == "" )
			{
				msg = "값을 넣어주세요";
				break ;
			}
			
			if(inputs[i].id.indexOf("p") > -1)
			{
				pArray[pCnt] = inputs[i].value;
				pCnt++;
			}
			else if(inputs[i].id.indexOf("n") > -1)
			{
				nArray[nCnt] = inputs[i].value;
				nCnt++;
			}
		}
		
	}
	
	return msg;
}

</script>


</head>
<body onLoad="javascript:fn_init();">
hello AWS
<br/>
<br/>
지폐 값 입력 <input type="text" id = "tot_txt"/>
<br/>
<input type="button" value="+" onClick="javascript:fn_plus();"/>
<input type="button" value="-" onClick="javascript:fn_minus();"/>
<input type="button" value="계산" onClick="javascript:fn_submit();"/>

<div id="parentDiv">

</div>
<br/>
<textarea id="result_txt" rows="10" cols="60"></textarea>
</body>
</html>