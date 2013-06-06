package cn.halen.data.mapper;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import cn.halen.data.pojo.MyLogisticsCompany;

public class MyLogisticsCompanyMapper extends SqlSessionDaoSupport {
	
	public int batchInsert(List<MyLogisticsCompany> list) {
		int count = getSqlSession().insert("cn.halen.data.mapper.MyLogisticsCompanyMapper.batchInsert", list);
		return count;
	}
	
	public MyLogisticsCompany selectByCode(String code) {
		return getSqlSession().selectOne("cn.halen.data.mapper.MyLogisticsCompanyMapper.selectByCode", code);
	}
	
	public int insert(MyLogisticsCompany company) {
		int count = getSqlSession().insert("cn.halen.data.mapper.MyLogisticsCompanyMapper.insert", company);
		return count;
	}
	
	public List<MyLogisticsCompany> list() {
		List<MyLogisticsCompany> list = getSqlSession().selectList("cn.halen.data.mapper.MyLogisticsCompanyMapper.list");
		return list;
	}
	
	public List<MyLogisticsCompany> listAll() {
		List<MyLogisticsCompany> list = getSqlSession().selectList("cn.halen.data.mapper.MyLogisticsCompanyMapper.listAll");
		return list;
	}
	
	public MyLogisticsCompany select(int status) {
		return getSqlSession().selectOne("cn.halen.data.mapper.MyLogisticsCompanyMapper.select", status);
	}
	
	public int update(MyLogisticsCompany myLogisticCompany) {
		return getSqlSession().update("cn.halen.data.mapper.MyLogisticsCompanyMapper.update", myLogisticCompany);
	}
}
