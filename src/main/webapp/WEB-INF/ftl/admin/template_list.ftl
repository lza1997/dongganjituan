<#import "/templates/root.ftl" as root >
<@root.html css=["jdpicker.css", "trade_list.css"] js=["highcharts.js", "exporting.js"] >
	<style  type="text/css">
		td {
			text-align: center;
		}
		
	</style>
	<a href="${rc.contextPath}/admin/add_template_form" class="btn btn-primary">添加一个新模板</a><br>
	<#if map??>
	<#list map?keys as key>
		模板名称: ${key}
		<a href="${rc.contextPath}/admin/modify_template?name=${key}">点击修改</a> 
		<br>
		<table>
			<thead>
				<tr>
					<th colspan="5">普通快递</th>
				</tr>
				<tr>
					<th>运送到</th>
					<th>首件(件)</th>
					<th>首费(元)</th>
					<th>续件(件)</th>
					<th>续费(元)</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>华东(上海、江苏、浙江、安徽、江西)</td>
					<td>${map[key]['pt-hd'].start_standard}</td>
					<td>${map[key]['pt-hd'].start_fee/100}</td>
					<td>${map[key]['pt-hd'].add_standard}</td>
					<td>${map[key]['pt-hd'].add_fee/100}</td>
				</tr>
				<tr>
					<td>华北(北京、天津、山西、山东、河北、内蒙古)</td>
					<td>${map[key]['pt-hb'].start_standard}</td>
					<td>${map[key]['pt-hb'].start_fee/100}</td>
					<td>${map[key]['pt-hb'].add_standard}</td>
					<td>${map[key]['pt-hb'].add_fee/100}</td>
				</tr>
				<tr>
					<td>华中(湖南、湖北、河南)</td>
					<td>${map[key]['pt-hz'].start_standard}</td>
					<td>${map[key]['pt-hz'].start_fee/100}</td>
					<td>${map[key]['pt-hz'].add_standard}</td>
					<td>${map[key]['pt-hz'].add_fee/100}</td>
				</tr>
				<tr>
					<td>华南(广东、广西、福建、海南)</td>
					<td>${map[key]['pt-hn'].start_standard}</td>
					<td>${map[key]['pt-hn'].start_fee/100}</td>
					<td>${map[key]['pt-hn'].add_standard}</td>
					<td>${map[key]['pt-hn'].add_fee/100}</td>
				</tr>
				<tr>
					<td>东北(辽宁、吉林、黑龙江)</td>
					<td>${map[key]['pt-db'].start_standard}</td>
					<td>${map[key]['pt-db'].start_fee/100}</td>
					<td>${map[key]['pt-db'].add_standard}</td>
					<td>${map[key]['pt-db'].add_fee/100}</td>
				</tr>
				<tr>
					<td>西北(陕西、新疆、甘肃、宁夏、青海)</td>
					<td>${map[key]['pt-xb'].start_standard}</td>
					<td>${map[key]['pt-xb'].start_fee/100}</td>
					<td>${map[key]['pt-xb'].add_standard}</td>
					<td>${map[key]['pt-xb'].add_fee/100}</td>
				</tr>
				<tr>
					<td>西南(重庆、云南、贵州、西藏、四川)</td>
					<td>${map[key]['pt-xn'].start_standard}</td>
					<td>${map[key]['pt-xn'].start_fee/100}</td>
					<td>${map[key]['pt-xn'].add_standard}</td>
					<td>${map[key]['pt-xn'].add_fee/100}</td>
				</tr>
				<tr>
					<td>港澳台(香港、澳门、台湾)</td>
					<td>${map[key]['pt-gat'].start_standard}</td>
					<td>${map[key]['pt-gat'].start_fee/100}</td>
					<td>${map[key]['pt-gat'].add_standard}</td>
					<td>${map[key]['pt-gat'].add_fee/100}</td>
				</tr>
				<tr>
					<td>海外</td>
					<td>${map[key]['pt-hw'].start_standard}</td>
					<td>${map[key]['pt-hw'].start_fee/100}</td>
					<td>${map[key]['pt-hw'].add_standard}</td>
					<td>${map[key]['pt-hw'].add_fee/100}</td>
				</tr>
				<tr>
					<th colspan="5">顺丰快递</th>
				</tr>
				<tr>
					<th>运送到</th>
					<th>首件(件)</th>
					<th>首费(元)</th>
					<th>续件(件)</th>
					<th>续费(元)</th>
				</tr>
				<tr>
					<td>华东(上海、江苏、浙江、安徽、江西)</td>
					<td>${map[key]['sf-hd'].start_standard}</td>
					<td>${map[key]['sf-hd'].start_fee/100}</td>
					<td>${map[key]['sf-hd'].add_standard}</td>
					<td>${map[key]['sf-hd'].add_fee/100}</td>
				</tr>
				<tr>
					<td>华北(北京、天津、山西、山东、河北、内蒙古)</td>
					<td>${map[key]['sf-hb'].start_standard}</td>
					<td>${map[key]['sf-hb'].start_fee/100}</td>
					<td>${map[key]['sf-hb'].add_standard}</td>
					<td>${map[key]['sf-hb'].add_fee/100}</td>
				</tr>
				<tr>
					<td>华中(湖南、湖北、河南)</td>
					<td>${map[key]['sf-hz'].start_standard}</td>
					<td>${map[key]['sf-hz'].start_fee/100}</td>
					<td>${map[key]['sf-hz'].add_standard}</td>
					<td>${map[key]['sf-hz'].add_fee/100}</td>
				</tr>
				<tr>
					<td>华南(广东、广西、福建、海南)</td>
					<td>${map[key]['sf-hn'].start_standard}</td>
					<td>${map[key]['sf-hn'].start_fee/100}</td>
					<td>${map[key]['sf-hn'].add_standard}</td>
					<td>${map[key]['sf-hn'].add_fee/100}</td>
				</tr>
				<tr>
					<td>东北(辽宁、吉林、黑龙江)</td>
					<td>${map[key]['sf-db'].start_standard}</td>
					<td>${map[key]['sf-db'].start_fee/100}</td>
					<td>${map[key]['sf-db'].add_standard}</td>
					<td>${map[key]['sf-db'].add_fee/100}</td>
				</tr>
				<tr>
					<td>西北(陕西、新疆、甘肃、宁夏、青海)</td>
					<td>${map[key]['sf-xb'].start_standard}</td>
					<td>${map[key]['sf-xb'].start_fee/100}</td>
					<td>${map[key]['sf-xb'].add_standard}</td>
					<td>${map[key]['sf-xb'].add_fee/100}</td>
				</tr>
				<tr>
					<td>西南(重庆、云南、贵州、西藏、四川)</td>
					<td>${map[key]['sf-xn'].start_standard}</td>
					<td>${map[key]['sf-xn'].start_fee/100}</td>
					<td>${map[key]['sf-xn'].add_standard}</td>
					<td>${map[key]['sf-xn'].add_fee/100}</td>
				</tr>
				<tr>
					<td>港澳台(香港、澳门、台湾)</td>
					<td>${map[key]['sf-gat'].start_standard}</td>
					<td>${map[key]['sf-gat'].start_fee/100}</td>
					<td>${map[key]['sf-gat'].add_standard}</td>
					<td>${map[key]['sf-gat'].add_fee/100}</td>
				</tr>
				<tr>
					<td>海外</td>
					<td>${map[key]['sf-hw'].start_standard}</td>
					<td>${map[key]['sf-hw'].start_fee/100}</td>
					<td>${map[key]['sf-hw'].add_standard}</td>
					<td>${map[key]['sf-hw'].add_fee/100}</td>
				</tr>
				<tr>
					<th colspan="5">海外</th>
				</tr>
				<tr>
					<th>运送到</th>
					<th>首件(件)</th>
					<th>首费(元)</th>
					<th>续件(件)</th>
					<th>续费(元)</th>
				</tr>
				<tr>
					<td>华东(上海、江苏、浙江、安徽、江西)</td>
					<td>${map[key]['ems-hd'].start_standard}</td>
					<td>${map[key]['ems-hd'].start_fee/100}</td>
					<td>${map[key]['ems-hd'].add_standard}</td>
					<td>${map[key]['ems-hd'].add_fee/100}</td>
				</tr>
				<tr>
					<td>华北(北京、天津、山西、山东、河北、内蒙古)</td>
					<td>${map[key]['ems-hb'].start_standard}</td>
					<td>${map[key]['ems-hb'].start_fee/100}</td>
					<td>${map[key]['ems-hb'].add_standard}</td>
					<td>${map[key]['ems-hb'].add_fee/100}</td>
				</tr>
				<tr>
					<td>华中(湖南、湖北、河南)</td>
					<td>${map[key]['ems-hz'].start_standard}</td>
					<td>${map[key]['ems-hz'].start_fee/100}</td>
					<td>${map[key]['ems-hz'].add_standard}</td>
					<td>${map[key]['ems-hz'].add_fee/100}</td>
				</tr>
				<tr>
					<td>华南(广东、广西、福建、海南)</td>
					<td>${map[key]['ems-hn'].start_standard}</td>
					<td>${map[key]['ems-hn'].start_fee/100}</td>
					<td>${map[key]['ems-hn'].add_standard}</td>
					<td>${map[key]['ems-hn'].add_fee/100}</td>
				</tr>
				<tr>
					<td>东北(辽宁、吉林、黑龙江)</td>
					<td>${map[key]['ems-db'].start_standard}</td>
					<td>${map[key]['ems-db'].start_fee/100}</td>
					<td>${map[key]['ems-db'].add_standard}</td>
					<td>${map[key]['ems-db'].add_fee/100}</td>
				</tr>
				<tr>
					<td>西北(陕西、新疆、甘肃、宁夏、青海)</td>
					<td>${map[key]['ems-xb'].start_standard}</td>
					<td>${map[key]['ems-xb'].start_fee/100}</td>
					<td>${map[key]['ems-xb'].add_standard}</td>
					<td>${map[key]['ems-xb'].add_fee/100}</td>
				</tr>
				<tr>
					<td>西南(重庆、云南、贵州、西藏、四川)</td>
					<td>${map[key]['ems-xn'].start_standard}</td>
					<td>${map[key]['ems-xn'].start_fee/100}</td>
					<td>${map[key]['ems-xn'].add_standard}</td>
					<td>${map[key]['ems-xn'].add_fee/100}</td>
				</tr>
				<tr>
					<td>港澳台(香港、澳门、台湾)</td>
					<td>${map[key]['ems-gat'].start_standard}</td>
					<td>${map[key]['ems-gat'].start_fee/100}</td>
					<td>${map[key]['ems-gat'].add_standard}</td>
					<td>${map[key]['ems-gat'].add_fee/100}</td>
				</tr>
				<tr>
					<td>海外</td>
					<td>${map[key]['ems-hw'].start_standard}</td>
					<td>${map[key]['ems-hw'].start_fee/100}</td>
					<td>${map[key]['ems-hw'].add_standard}</td>
					<td>${map[key]['ems-hw'].add_fee/100}</td>
				</tr>
			</tbody>
		</table><br><br>
	</#list>
	</#if>
	
</@root.html>