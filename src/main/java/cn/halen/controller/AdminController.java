package cn.halen.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.halen.data.mapper.AdminMapper;
import cn.halen.data.mapper.AreaMapper;
import cn.halen.data.mapper.MyLogisticsCompanyMapper;
import cn.halen.data.pojo.Distributor;
import cn.halen.data.pojo.MyLogisticsCompany;
import cn.halen.data.pojo.Shop;
import cn.halen.data.pojo.Template;
import cn.halen.data.pojo.User;
import cn.halen.data.pojo.UserType;
import cn.halen.exception.InsufficientBalanceException;
import cn.halen.service.AdminService;
import cn.halen.service.ResultInfo;
import cn.halen.util.Constants;

import com.taobao.api.domain.Area;

@Controller
public class AdminController {
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired 
	private AreaMapper areaMapper;
	
	@Autowired
	private MyLogisticsCompanyMapper logisticsMapper;
	
	@RequestMapping(value="admin/account_list")
	public String list(Model model) {
		
		//list users which type are not distributor and servicestaff 
		List<User> userList = adminMapper.listUser();
		Map<String, List<User>> userMap = new HashMap<String, List<User>>();
		for(User user : userList) {
			String type = user.getType();
			if(type.equals(UserType.Distributor.getValue()) || type.equals(UserType.ServiceStaff.getValue())) {
				continue;
			}
			List<User> list = userMap.get(type);
			if(null == list) {
				list = new ArrayList<User>();
				userMap.put(type, list);
			}
			list.add(user);
		}
		model.addAttribute("userMap", userMap);
		
		//list all distributor and details
		List<Distributor> dList = adminMapper.listDistributorMap();
		model.addAttribute("dList", dList);
		return "admin/account_list";
	}
	
	@RequestMapping(value="admin/change_check")
	public void checkChange(Model model,  HttpServletResponse resp, @RequestParam("v") int v, @RequestParam("dId") int dId) {
		
		adminMapper.updateDistributorCheck(v, dId);
		try {
			resp.sendRedirect("/admin/account_list");
		} catch (IOException e) {
		}
	}
	
	@RequestMapping(value="admin/change_sync_store")
	public void changeSyncStore(Model model,  HttpServletResponse resp, @RequestParam("v") int v, @RequestParam("sId") int sId) {
		
		adminMapper.updateShopSyncStore(v, sId);
		try {
			resp.sendRedirect("/admin/account_list");
		} catch (IOException e) {
		}
	}
	
	@RequestMapping(value="admin/add_user_form")
	public String addAccountForm(Model model, @RequestParam("type") String type,
			@RequestParam(value="shopId", required=false) Integer shopId) {
		model.addAttribute("userType", UserType.valueOf(type));
		if(null != shopId) {
			model.addAttribute("shopId", shopId);
		}
		return "admin/add_user_form";
	}
	
	@RequestMapping(value="admin/add_shop_form")
	public String addShopForm(Model model, @RequestParam("dId") Integer dId) {
		model.addAttribute("dId", dId);
		return "admin/add_shop_form";
	}
	
	@RequestMapping(value="admin/change_discount_form")
	public String changeDiscountForm(Model model, @RequestParam("dId") Integer dId) {
		model.addAttribute("dId", dId);
		return "admin/change_discount_form";
	}
	
	@RequestMapping(value="admin/add_distributor_form")
	public String addDistributorForm(Model model) {
		return "admin/add_distributor_form";
	}
	
	@RequestMapping(value="admin/add_user")
	public String addUser(Model model, HttpServletResponse resp, @RequestParam("username") String username, @RequestParam("password") String password,
			@RequestParam("password2") String password2, @RequestParam("type") String type, @RequestParam(value="shopId", required=false) Integer shopId) {
		String errorMsg = null;
		username = username.trim();
		password = password.trim();
		password2 = password2.trim();

		if(StringUtils.isEmpty(username)) {
			errorMsg = "用户名不能为空!";
		} else if(password.length()<6) {
			errorMsg = "密码长度必须大于等于6!";
		} else if(!password.equals(password2)) {
			errorMsg = "两次输入的密码不一致!";
		}
		if(null != errorMsg) {
			model.addAttribute("errorInfo", errorMsg);
			return "error_page";
		}
		boolean exist = adminMapper.isExistUser(username);
		if(exist) {
			model.addAttribute("errorInfo", "该用户已经存在，不能重复创建!");
			return "error_page";
		}
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		user.setType(type);
		if(shopId == null) {
			user.setShopId(-1);
		} else {
			user.setShopId(shopId);
		}
		adminService.insertUser(user, type);
		try {
			resp.sendRedirect("/admin/account_list");
		} catch (IOException e) {
		}
		return null;
	}
	
	@RequestMapping(value="admin/add_distributor")
	public String addDistributor(Model model, HttpServletResponse resp, @RequestParam("name") String name,
			@RequestParam(value="phone", required=false) String phone, @RequestParam(value="is_self", required=false) String isSelf,
			@RequestParam("discount") String discount) {
		String errorMsg = null;
		name = name.trim();
		name = name.trim();
		float fDiscount = 0;
		discount = discount.trim();
		
		if(StringUtils.isEmpty(name)) {
			errorMsg = "名称不能为空!";
		} 
		if(StringUtils.isEmpty(discount)) {
			errorMsg = "分销商必须填写折扣!";
		}
		try {
			fDiscount = Float.parseFloat(discount);
			if(fDiscount>1 || fDiscount<0) {
				errorMsg = "折扣必须在0-1之间!";
			}
		} catch(Exception e) {
			errorMsg = "请填写正确的折扣!";
		}
		if(null != errorMsg) {
			model.addAttribute("errorInfo", errorMsg);
			return "error_page";
		}
		
		boolean exist = adminMapper.selectDistributor(null, name)!=null;
		if(exist) {
			model.addAttribute("errorInfo", "该分销商已经存在，不能重复创建!");
			return "error_page";
		}
		Distributor distributor = new Distributor();
		distributor.setName(name);
		distributor.setPhone(phone);
		distributor.setDiscount(fDiscount);
		if("true".equals(isSelf)) {
			distributor.setSelf(Constants.DISTRIBUTOR_SELF_YES);
		} else {
			distributor.setSelf(Constants.DISTRIBUTOR_SELF_NO);
		}
		adminMapper.insertDistributor(distributor);
		try {
			resp.sendRedirect("/admin/account_list");
		} catch (IOException e) {
		}
		return null;
	}
	
	@RequestMapping(value="admin/change_discount")
	public String addDistributor(Model model, HttpServletResponse resp, @RequestParam("dId") int dId, 
			@RequestParam("v") String v) {
		String errorMsg = null;
		float fDiscount = 0;
		v = v.trim();
		
		if(StringUtils.isEmpty(v)) {
			errorMsg = "必须填写折扣!";
		}
		try {
			fDiscount = Float.parseFloat(v);
			if(fDiscount>1 || fDiscount<0) {
				errorMsg = "折扣必须在0-1之间!";
			}
		} catch(Exception e) {
			errorMsg = "请填写正确的折扣!";
		}
		if(null != errorMsg) {
			model.addAttribute("errorInfo", errorMsg);
			return "error_page";
		}
		adminMapper.updateDistributorDiscount(fDiscount, dId);
		try {
			resp.sendRedirect("/admin/account_list");
		} catch (IOException e) {
		}
		return null;
	}
	
	@RequestMapping(value="admin/add_shop")
	public String addShop(Model model, HttpServletResponse resp, @RequestParam("sellerNick") String sellerNick, @RequestParam("type") String type,
			@RequestParam("dId") Integer dId) {
		String errorMsg = null;
		sellerNick = sellerNick.trim();
		if(StringUtils.isEmpty(sellerNick)) {
			errorMsg = "店铺名称不能为空!";
		} 
		
		if(null != errorMsg) {
			model.addAttribute("errorInfo", errorMsg);
			return "error_page";
		}
		
		boolean exist = adminMapper.selectShopBySellerNick(sellerNick) != null;
		if(exist) {
			model.addAttribute("errorInfo", "该店铺已经存在，不能重复创建!");
			return "error_page";
		}
		Shop s = new Shop();
		s.setSellerNick(sellerNick);
		s.setType(type);
		s.setdId(dId);
		adminMapper.insertShop(s);
		try {
			resp.sendRedirect("/admin/account_list");
		} catch (IOException e) {
		}
		return null;
	}
	
	@RequestMapping(value="admin/modify_password_form")
	public String modifyPassword(Model model, @RequestParam("username") String username) {
		model.addAttribute("username", username);
		return "admin/modify_password_form";
	}
	
	@RequestMapping(value="admin/modify_password")
	public String modifyPassword(Model model, HttpServletResponse resp, 
			@RequestParam("username") String username, @RequestParam("password") String password,
			@RequestParam("password2") String password2
			) {
		String errorMsg = null;
		username = username.trim();
		password = password.trim();
		password2 = password2.trim();
		if(password.length()<6) {
			errorMsg = "密码长度必须大于等于6!";
		} else if(!password.equals(password2)) {
			errorMsg = "两次输入的密码不一致!";
		}
		if(null != errorMsg) {
			model.addAttribute("errorInfo", errorMsg);
			return "error_page";
		}
		adminMapper.updateUserPassword(username, password);
		try {
			resp.sendRedirect("/admin/account_list");
		} catch (IOException e) {
		}
		return null;
	}
	
	@RequestMapping(value="admin/change_user_status")
	public void changeUserStatus(Model model, HttpServletResponse resp, 
			@RequestParam("username") String username, @RequestParam("enabled") int enabled
			) {
		username = username.trim();
		if(enabled == 1) {
			adminMapper.enableUser(username);
		} else {
			adminMapper.disableUser(username);
		}
		try {
			resp.sendRedirect("/admin/account_list");
		} catch (IOException e) {
		}
	}
	
	@RequestMapping(value="admin/add_template_form")
	public String addTemplateForm(Model model) {
		List<Area> areaList = areaMapper.listByType(2); //查出所以省份
		List<MyLogisticsCompany> logisticsList = logisticsMapper.list();
		model.addAttribute("areaList", areaList);
		model.addAttribute("logisticsList", logisticsList);
		return "admin/add_template_form";
	}
	
	@RequestMapping(value="admin/add_template", method=RequestMethod.POST)
	public String addTemplate(Model model, HttpServletRequest req, HttpServletResponse resp) {
		String action = req.getParameter("action");
		String templateName = (String) req.getParameter("template-name");
		List<Template> list = new ArrayList<Template>();
		if(action.trim().equals("add")) {
			if(StringUtils.isEmpty(templateName)) {
				model.addAttribute("errorInfo", "创建模板失败，模板名称不能为空！");
				return "error_page";
			}
			//检查模板是否已存在，不能重复
			String exist = adminMapper.selectTemplateNameByName(templateName);
			if(null != exist) {
				model.addAttribute("errorInfo", templateName + "已经存在，请不要重复创建！");
				return "error_page";
			}
		} 
		
		List<String> logisticsTypeList = new ArrayList<String>();
		logisticsTypeList.add("pt");
		logisticsTypeList.add("sf");
		logisticsTypeList.add("ems");
		
		List<String> areaList = new ArrayList<String>();
		areaList.add("hd");
		areaList.add("hb");
		areaList.add("hz");
		areaList.add("hn");
		areaList.add("db");
		areaList.add("xb");
		areaList.add("xn");
		areaList.add("gat");
		areaList.add("hw");
		
		for(String logisticsType : logisticsTypeList) {
			for(String area : areaList) {
				int startStandard = Integer.parseInt(req.getParameter(logisticsType + "-" + area + "-start-standard"));
				int startFee = Integer.parseInt(req.getParameter(logisticsType + "-" + area + "-start-fee")) * 100;
				int addStandard = Integer.parseInt(req.getParameter(logisticsType + "-" + area + "-add-standard"));
				int addFee = Integer.parseInt(req.getParameter(logisticsType + "-" + area + "-add-fee")) * 100;
				
				Template template = new Template();
				template.setName(templateName);
				template.setLogistics_type(logisticsType);
				template.setArea(area);
				template.setStart_standard(startStandard);
				template.setStart_fee(startFee);
				template.setAdd_standard(addStandard);
				template.setAdd_fee(addFee);
				list.add(template);
			}
		}
		
		int count = 0;
		if(action.trim().equals("add")) {
			try{
				count = adminService.insertNewTemplate(list, templateName);
			} catch(Exception e) {
				model.addAttribute("errorInfo", templateName + "创建失败，请重试！");
				return "error_page";
			}
			log.debug("Success insert {} template", count);
		} else if(action.trim().equals("modify")) {
			try {
				count = adminService.updateTemplate(list);
			} catch(Exception e) {
				model.addAttribute("errorInfo", templateName + "更新失败，请重试！");
				return "error_page";
			}
			log.debug("Success update {} template", count);
		}
		
		try {
			resp.sendRedirect(req.getContextPath() + "/admin/template_list");
		} catch (IOException e) {
		}
		return null;
	}
	
	@RequestMapping(value="admin/template_list")
	public String templateList(Model model) {
		List<Template> templateList = adminMapper.selectTemplateAll();
		
		Map<String, Map<String, Template>> map = new HashMap<String, Map<String, Template>>();
		for(Template template : templateList) {
			String templateName = template.getName();
			Map<String, Template> innerMap = map.get(templateName);
			if(null == innerMap) {
				innerMap = new HashMap<String, Template>();
				map.put(templateName, innerMap);
			}
			String key = template.getLogistics_type() + "-" + template.getArea();
			innerMap.put(key, template);
		}
		
		model.addAttribute("map", map);
		return "admin/template_list";
	}
	
	@RequestMapping(value="admin/modify_template")
	public String modifyTemplate(Model model, @RequestParam("name") String name) {
		List<Template> templateList = adminMapper.selectTemplateByName(name);
		
		Map<String, Template> map = new HashMap<String, Template>();
		for(Template template : templateList) {
			String key = template.getLogistics_type() + "-" + template.getArea();
			map.put(key, template);
		}
		
		model.addAttribute("map", map);
		return "admin/add_template_form";
	}
	
	@RequestMapping(value="accounting/distributor_list")
	public String distributorList(Model model) {
		List<Distributor> dList = adminMapper.listDistributor();
		model.addAttribute("dList", dList);
		return "accounting/distributor_list";
	}
	
	@RequestMapping(value="accounting/recharge")
	public @ResponseBody ResultInfo recharge(Model model, @RequestParam("dId") int dId,
			@RequestParam("how_much") String howmuch) {
		ResultInfo result = new ResultInfo();
		howmuch = howmuch.trim();
		long lHowmuch = 0;
		try {
			lHowmuch = Long.valueOf(howmuch);
		} catch (Exception e) {
			result.setSuccess(false);
			result.setErrorInfo("请输入正确的金额!");
			return result;
		}
		try {
			adminService.updateDeposit(dId, lHowmuch*100);
		} catch (InsufficientBalanceException ie) {
			result.setSuccess(false);
			result.setErrorInfo("余额不足!");
		} catch (Exception e) {
			log.error("", e);
			result.setSuccess(false);
			result.setErrorInfo("系统异常，请重试!");
		}
		return result;
	}
}
