<#import "/templates/root.ftl" as root >

<@root.html active=3 css=["jqpagination.css", "easyui.css", "icon.css", "trade_list.css"]
js=["trade_list.js", "pagination.js", "jquery.jqpagination.min.js", "jquery.cookie.js", "jquery.easyui.min.js"]>
    <#if CURRENT_USER.type=="WareHouse">
    <script language="javascript" src="${rc.contextPath}/js/LodopFuncs.js"></script>
	<object  id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
	    <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
	</object>
    </#if>
	<div style="width: 98%; height: 60px; background-color: #d6dff7; padding-top: 5px; padding-left: 20px; <#if CURRENT_USER.type=="WareHouse">margin-top: -20px;</#if>">
		<#if CURRENT_USER.type!="Distributor" && CURRENT_USER.type!="ServiceStaff">
		分销商
		<select id="distributor" style="width: 8%;">
			<option value="-1">所有分销商</option>
			<#list dList as d>
			<option value="${d.id}">${d.name}</option>
			</#list>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;
		</#if>
		<#if CURRENT_USER.type!="ServiceStaff">
		店铺
		<select id="seller_nick" style="width: 8%;">
			<option value="">所有店铺</option>
			<#if shopList??>
				<#list shopList as shop>
				<option value="${shop.sellerNick}">${shop.sellerNick}</option>
				</#list>
			</#if>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;
		</#if>
		<input type="hidden" id="status">
        <input type="hidden" id="isSubmit">
        <input type="hidden" id="isCancel">
        <input type="hidden" id="isFinish">
        <input type="hidden" id="isSend">
        <input type="hidden" id="isRefund">
		快递
		<select id="delivery" style="width: 8%;">
			<option value="">所有快递</option>
			<#list logistics as lo>
				<option value="${lo.name}">${lo.name}</option>
			</#list>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;
		订单号
		<input id="tid" type="input" value="" style="width: 10%; height: 15px;"/>
		&nbsp;&nbsp;&nbsp;&nbsp;
		收货人
		<input id="name" type="input" value="" style="width: 6%; height: 15px;"/>
		<!-- &nbsp;&nbsp;&nbsp;&nbsp;
		<strong>开始时间</strong>
		<input id="name" type="input" value="" style="width: 8%; height: 20px;"/>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<strong>结束时间</strong>
		<input id="name" type="input" value="" style="width: 8%; height: 20px;"/> -->
		&nbsp;&nbsp;&nbsp;&nbsp;
        <div style="margin-top: 5px;">
            开始时间
                <input id="start" class="easyui-datetimebox" type="input">
            &nbsp;&nbsp;&nbsp;&nbsp;
            结束时间
                <input id="end" class="easyui-datetimebox" type="input">
            <span style="float: right; margin-right:15px;">
                <button id="search">搜索</button>&nbsp;&nbsp;&nbsp;&nbsp;共${totalCount}条交易
                &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="${rc.contextPath}/trade/report">下载今天的已发货订单</a>
            </span>
        </div>

	</div>
<#if trade_list?size gt 0>
    <div style="width:99%; margin-top:3px;">
        <table id="t-list" class="easyui-datagrid" style="height:auto;" data-options="scrollbarSize:'0', fitColumns:'true',checkOnSelect:false">
            <thead>
                <tr>
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'id',align:'center',width:$(this).width() * 0.3">订单号</th>
                    <th data-options="field:'tid',align:'center',width:$(this).width() * 0.3">网店单号</th>
                    <th data-options="field:'listprice',align:'center',width:$(this).width() * 0.3">顾客姓名</th>
                    <th data-options="field:'attr1',align:'center',width:$(this).width() * 0.3">订单状态</th>
                    <th data-options="field:'attr2',align:'center',width:$(this).width() * 0.3">成交时间</th>
                    <#if scan=="true">
                        <th data-options="field:'attr4',align:'center',width:$(this).width() * 0.4">填写单号</th>
                    <#else>
                        <th data-options="field:'attr3',align:'center',width:$(this).width() * 0.4">操作</th>
                    </#if>
                </tr>
            </thead>
            <tbody>
                <#list trade_list as trade>
                <tr>
                    <td style="width:50%"></td>
                    <td>${trade.id}</td>
                    <td>${trade.tid!''}</td>
                    <td>${trade.name}</td>
                    <td>
                    ${trade.tradeStatus.desc}<br>
                    <#if trade.is_cancel==-1>
                        <font color="red">(已申请取消)</font>
                    </#if>
                    <#if trade.is_refund==1>
                        <font color="red">(退换货)</font>
                    </#if>
                    </td>
                    <td>${trade.created?string('yyyy-MM-dd HH:mm:ss')}</td>
                    <#if scan=="true">
                        <td>
                            <input class="scan-input" data-index="${trade_index}" data-id="${trade.id}" type="text"/>
                            <a onclick="autoScan(this)">连号</a>
                        </td>
                    <#else>
                    <td>
                        <a href="${rc.contextPath}/trade/trade_detail?id=${trade.id}">订单详情</a> &nbsp;
                        <#if CURRENT_USER.type=="WareHouse" && trade.status=="WaitFind">
                            <a onclick="addTrackingNumber('${trade.id}')">扫描单号</a>
                        </#if>
                    </td>
                    </#if>

                </tr>
                </#list>
            </tbody>
        </table>
    </div>
    <div class="pagination">
        <a href="#" class="first" data-action="first">&laquo;</a>
        <a href="#" class="previous" data-action="previous">&lsaquo;</a>
        <input id="page" type="text" readonly="readonly" data-current-page="${paging.page}" data-page-string="1 of 3" data-max-page="${paging.pageCount}" />
        <a href="#" class="next" data-action="next">&rsaquo;</a>
        <a href="#" class="last" data-action="last">&raquo;</a>
    </div>
    <div class="action-bar">
        <#if CURRENT_USER.type=="Distributor" || CURRENT_USER.type=="ServiceStaff">
            <#if isSubmit?? && isSubmit==0>
                <a id="batch-submit" style="cursor: pointer;">批量提交</a>
            </#if>
        </#if>
        <#if CURRENT_USER.type=="WareHouse">
            <#if isSubmit==1 && isSend==0 && status=='WaitSend'>
                <a id="batch-find-goods" style="cursor: pointer;">批量导入待拣货</a>
            </#if>
            <#if isSubmit==1 && isSend==0 && status=='WaitOut'>
                <a id="batch-out-goods" style="cursor: pointer;">批量出库</a>
            </#if>
            <#if isSubmit==1 && isSend==0 && status=='WaitFind'>
                <a href="${rc.contextPath}/trade/export_finding" style="cursor: pointer;">生成拣货单</a>
                <select id="delivery-print" style="width: 8%;">
                    <option value="">选择快递</option>
                    <#list logistics as lo>
                        <option value="${lo.name}">${lo.name}</option>
                    </#list>
                </select>
                <a id="batch-prn-kdd" style="cursor: pointer;">打印快递单</a>
                <#if scan=="false">
                    <a id="scan-delivery">扫描单号</a>
                <#else>
                    <a id="save-scan">保存单号</a>
                </#if>
                <a id="print-setup" style="cursor: pointer;">打印调整</a>
                <a id="paper-setup" style="cursor: pointer;">纸张设置</a>
            </#if>
        </#if>
    </div>
<#else>
    <#if CURRENT_USER.type=="WareHouse">
        <div class="alert" style="margin: 5px;">
            <a class="close" data-dismiss="alert">×</a>
            <strong>无内容！</strong>
        </div>
        <#if status?? && status='WaitFind'>
            <select id="delivery-print" style="width: 8%;">
                <option value="">选择快递</option>
                <#list logistics as lo>
                    <option value="${lo.name}">${lo.name}</option>
                </#list>
            </select>
            <a id="print-setup" style="cursor: pointer;">打印调整</a>
            <a id="paper-setup" style="cursor: pointer;">纸张设置</a>
        </#if>
    <#else>
        <div class="alert" style="margin: 5px;">
            <a class="close" data-dismiss="alert">×</a>
            <strong>无内容！</strong>
        </div>
    </#if>
</#if>
</@root.html>

<!-- start 提示框 -->
  <div id="pop-up" class="easyui-window" title="扫描单号" data-options="modal:true,collapsible:false,closed:true,
        resizable:false,shadow:false,minimizable:false, maximizable:false" style="width:300px;height:150px;padding:2px;">
      <div style="margin-left:12px;">
	    <p>
	    	请输入单号 <input type="text" id="tracking-number"/>
	    	<input type="hidden" id="curr-tid"/>
	    	<input type="hidden" id="curr-delivery"/>
	    	<input type="hidden" id="curr-from"/>
	    	<input type="hidden" id="curr-sellernick"/>
	    </p>
	  </div>
      <div style="text-align:center;padding:5px">
          <a class="easyui-linkbutton" onclick="saveTrackingNumber()">确定</a>
          <a class="easyui-linkbutton" onclick="cancelTrackingNumber()">取消</a>
      </div>
  </div>
  <!-- end 提示框 -->

  <!-- start 提示框 -->
  <div id="pop-up2" class="easyui-window" title="请输入退货原因" data-options="modal:true,collapsible:false,closed:true,
        resizable:false,shadow:false,minimizable:false, maximizable:false" style="width:300px;height:150px;padding:2px;">
      <div style="margin-left:12px;">
	    <p>
	    	请输入退货原因 <input type="text" id="refund-reason"/>
	    	<input type="hidden" id="refund-curr-tid"/>
	    	<input type="hidden" id="refund-curr-oid"/>
	    </p>
	  </div>
      <div style="text-align:center;padding:5px">
          <a class="easyui-linkbutton" onclick="saveApplyRefund()">确定</a>
          <a class="easyui-linkbutton" onclick="cancelApplyRefund()">取消</a>
      </div>
  </div>
  <!-- end 提示框 -->
<div id="w" class="easyui-window" title="纸张设置" data-options="modal:true,collapsible:false,closed:true,
        resizable:false,shadow:false,minimizable:false, maximizable:false" style="width:300px;height:180px;padding:2px;">
    <form id="ff" method="post">
        <table>
            <tr>
                <td>宽度:</td>
                <td><input id="paper-width" class="easyui-validatebox" type="text" data-options="required:true,validType:'length[1, 10]',missingMessage:'不能为空,请输入大于0的数字'"></input></td>
            </tr>
            <tr>
                <td>高度:</td>
                <td><input id="paper-height" class="easyui-validatebox" type="text" data-options="required:true,validType:'length[1, 10]',missingMessage:'不能为空,请输入大于0的数字'"></input></td>
            </tr>
        </table>
        <div style="text-align:center;padding:5px">
            <a class="easyui-linkbutton" onclick="savePaperChange()">确定</a>
            <a class="easyui-linkbutton" onclick="cancelPaperChange()">取消</a>
        </div>
    </form>
</div>

<script>

	$(document).ready(function() {
		$('.cancel, .approve1, .submit, .no-goods, .find-goods').click(function() {
			var action = $(this).attr("class");
			if(action=="cancel") {
				var isTrue = confirm("确定作废这个订单吗？");
				if(!isTrue) {
					return false;
				}
			} else if(action=="no-goods") {
				var isTrue = confirm("确定没有货吗？");
				if(!isTrue) {
					return false;
				}
			}
			$.ajax({
	            type: "post",//使用get方法访问后台
	            dataType: "json",//返回json格式的数据
	            data: "tid=" + $(this).attr("data-tid") + "&action=" + action + "&oid=" + $(this).attr("data-oid"),
	            url: "${rc.contextPath}/trade/action/change_status",//要访问的后台地址
	            success: function(result){//msg为返回的数据，在这里做数据绑定
	                if(result.success == false) {
	                	alert(result.errorInfo);
	                } else {
	                	window.location.reload();
	                }
	            }});
		})

		$('#distributor').change(function() {
			$('#seller_nick').empty();
	        $('#seller_nick').append('<option value="">所有店铺</option>');
	        $.ajax({
	            type: "get",//使用get方法访问后台
	            dataType: "json",//返回json格式的数据
	            data: "dId=" + $(this).val(),
	            url: "${rc.contextPath}/trade/list_shop",//要访问的后台地址
	            success: function(shopList){//msg为返回的数据，在这里做数据绑定
	                $.each(shopList, function(index, shop) {
	                    $('#seller_nick').append('<option value="' + shop.sellerNick + '">' + shop.sellerNick + '</option>');
	                });
	            }});
		})

    	$('#check-all').click(function() {
    		$('.wait-check').attr("checked", true);
    	})

    	$('#not-check-all').click(function() {
    		$('.wait-check').attr("checked", false);
    	})

    	$('#batch-approve1').click(function() {
    		var checked = $('.wait-check:checked');
    		if(checked.length==0) {
    			alert('至少选中一个订单!');
    			return false;
    		}
    		var b = true;
    		var tids = "";
    		$(checked).each(function(index, item) {
    			var status = $(item).attr("data-status");
    			if(status != 1) {
    				b = false;
    				return false;
    			}
    			var tid = $(item).attr("data-tid");
    			tids += tid;
    			tids += ";";
    		})
    		if(!b) {
    			alert('不能审核除"待审核"以外的订单!');
    		} else {
    			$.ajax({
	            type: "post",//使用get方法访问后台
	            dataType: "json",//返回json格式的数据
	            data: "tids=" + tids + "&action=approve1",
	            url: "${rc.contextPath}/trade/action/batch_change_status",//要访问的后台地址
	            success: function(result){//msg为返回的数据，在这里做数据绑定
		                if(result.errorInfo != "success") {
		                	alert(result.errorInfo);
		                	window.location.reload();
		                } else {
			                window.location.reload();
		                }
	            }});
    		}
    	})

    	$('#batch-prn-kdd').click(function() {
            var delivery = $('#delivery-print').val();
            if(!delivery || delivery=="") {
                alert("请选择快递");
                return false;
            }
    		var checked = $('#t-list').datagrid("getChecked");
    		if(checked.length==0) {
    			alert('至少选中一个订单!');
    			return false;
    		}

            if(delivery=="韵达快运" || delivery=="韵达") {
                bg = "/img/kuaidi/yunda.jpg";
            } else if(delivery=="申通E物流") {
                bg = "/img/kuaidi/shentong.jpg";
            } else if(delivery=="顺丰速运") {
                bg = "/img/kuaidi/sf.jpg";
            } else if(delivery=="EMS") {
                bg = "/img/kuaidi/ems_jingji2.jpg";
            } else if(delivery=="圆通速递") {
                bg = "/img/kuaidi/yuantong-new.jpg";
            }

            LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));
            LODOP.PRINT_INIT(delivery);

            var width = $.cookie(delivery + "width");
            var height = $.cookie(delivery + "height");
            if(!width) {
                width = 2300;
            } else {
                width = parseInt(width);
            }
            if(!height) {
                height = 1270;
            } else {
                height = parseInt(height);
            }
            LODOP.SET_PRINT_PAGESIZE(1,width,height,"");
            LODOP.SET_PRINT_STYLE("FontSize",16);
            LODOP.SET_PRINT_STYLE("Bold",1);
            $(checked).each(function(index, item) {
                var name = "";
                var address = "";
                var mobile = "";
                var state = "";
                var goodsInfo = "";

                $.ajax({
                    type: "get",//使用get方法访问后台
                    dataType: "json",//返回json格式的数据
                    data: "id=" + item.id.trim(),
                    async: false,
                    url: "${rc.contextPath}/trade/trade_detail_json",//要访问的后台地址
                    success: function(trade){//msg为返回的数据，在这里做数据绑定
                        name = trade.name;
                        address = trade.state + " " + trade.city + " " + trade.district + " " + trade.address;
                        mobile = trade.mobile;
                        state = trade.state;
                        $.each(trade.myOrderList, function(index, order) {
                                goodsInfo = goodsInfo + order.goods_id + " " + order.sku.color + " " + order.sku.size + " " + order.quantity + "\r\n"
                        });
                }});

                CreatePrintPage('${sellerInfo.sender}', '${sellerInfo.from_state!''}', '${sellerInfo.from_company!''}',
                            '${sellerInfo.from_address!''}', '${sellerInfo.mobile!''}',
                            name, name, address, mobile, state, goodsInfo,bg);

    	    })
            LODOP.SET_PREVIEW_WINDOW(1,1,0,900,600,"");
            LODOP.PREVIEW();
	    })
    })

    function initpage() {
        $('#name').val('${name!""}');
        $('#tid').val('${tid!""}');
        $('#distributor').val('${dId!-1}');
        $('#seller_nick').val('${seller_nick!""}');
        $('#status').val('${status!""}');
        $('#delivery').val('${delivery!""}');
        $('#start').val('${start!""}');
        $('#delivery-print').val('${delivery!""}');
        $('#end').val('${end!""}');
        $('#isSubmit').val('${isSubmit!""}');
        $('#isCancel').val('${isCancel!""}');
        $('#isRefund').val('${isRefund!""}');
        $('#isFinish').val('${isFinish!""}');
        $('#isSend').val('${isSend!""}');
    }

	function CreateOneFormPage(){
		LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));
		LODOP.PRINT_INIT("1");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.SET_PRINT_STYLE("Bold",1);
		//LODOP.ADD_PRINT_TEXT(50,231,260,39,"打印页面部分内容");
		//LODOP.ADD_PRINT_HTM(88,200,350,600,document.getElementById("form1").innerHTML);
	};

    function prn(func, delivery, sender, from, from_company, from_address, sender_mobile,
        receiver, to_company, to_address, receiver_mobile, to) {
        var x = $.cookie(delivery + "x");
        var y = $.cookie(delivery + "y");
        if(!x) {
            x = 0;
        } else {
            x = parseInt(x);
        }
        if(!y) {
            y = 0;
        } else {
            y = parseInt(y);
        }
        console.log("x=" + x + " y=" + y);
        func(x, y, sender, from, from_company, from_address, sender_mobile,
            receiver, to_company, to_address, receiver_mobile, to);
    }
</script>
