package cn.halen.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.halen.data.mapper.MyLogisticsCompanyMapper;
import cn.halen.data.pojo.MyTrade;
import cn.halen.service.TradeService;
import cn.halen.util.Paging;

@Controller
public class TradeController {
	
	@Autowired
	private TradeService tradeService;
	
	@Autowired
	private MyLogisticsCompanyMapper myLogisticsCompanyMapper;
	
	@RequestMapping(value="trade_list")
	public String list(Model model, @RequestParam(value="seller_nick", required=false) String seller_nick,
			@RequestParam(value="name", required=false) String name, 
			@RequestParam(value="status", required=false) Integer status,
			@RequestParam(value="page", required=false) Integer page) {
		int intPage = 1;
		if(null!=page && page>0) {
			intPage = page;
		}
		long totalCount = tradeService.countTrade(seller_nick, name, status);
		Paging paging = new Paging(intPage, 10, totalCount);
		List<MyTrade> list = tradeService.listTrade(seller_nick, name, paging, status);
		model.addAttribute("trade_list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("name", name);
		model.addAttribute("status", status);
		model.addAttribute("seller_nick", seller_nick);
		model.addAttribute("logistics", myLogisticsCompanyMapper.list());
		return "trade_list";
	}
	
	@RequestMapping(value="fenxiao/add_trade_form")
	public String addTradeForm() {
		return "fenxiao/add_trade_form"; 
	}
}
