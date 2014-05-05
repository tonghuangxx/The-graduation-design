package com.dlts.base.dao;

import java.io.Serializable;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.dlts.util.dao.DCriteriaPageSupport;

/**
 * 数据库操作接口
 * 
 * @author CWB
 * 
 * @param <T>
 * @param <P>
 * @param <PK>
 */
public interface GeneraDAO<T, P, PK extends Serializable> {
	/**
	 * 持久化一个新对象到数据到 数据库
	 * 
	 * @param object
	 *            T
	 */
	void saveIObject(final T object);

	/**
	 * 保存一个新对象或者 更新一个对象
	 * 
	 * @param object
	 *            T
	 */
	void saveOrUpdateIObject(final T object);

	/**
	 * 获得 PK 值是 primaryKey的 数据记录
	 * @param iClass
	 * @param primaryKey
	 * @return
	 */
	T getIObjectByPK(final Class iClass, PK primaryKey);

	/**
	 * 根据类型查找数据
	 * @param iClass
	 * @return
	 */
	List<T> findAllByIObjectCType(final Class iClass);
	
	/**
	 * 根据实体对象查询
	 * @param entity
	 * @return
	 */
	public List<T> findByExample(Object entity);
	
	/**
	 * 根据实体对象查询
	 * @param entity
	 * @return
	 */
	public List<T> findPageByExample(Object entity,int page,int pageSize);
	
	/**
	 * 根据类型分页查找数据
	 * @param iClass
	 * @param page
	 * @param pageSize
	 * @return
	 */
	List<T> findByIObjectCType(final Class iClass, final int page, final int pageSize);

	/**
	 * 更新数据
	 * @param object
	 *            T
	 */
	void updateIObject(final T object);

	/**
	 * 删除数据
	 * @param object
	 *            T
	 */
	void deleteIObject(final T object);

	/**
	 * 执行自定义HQL
	 * 
	 * @param hSQL
	 *            String
	 * @return int
	 * @throws Exception
	 */
	int execByHQL(final String hSQL);

	/**
	 * 执行自定义的hsql
	 * @param hSQL
	 * @param t
	 * @return
	 * @throws Exception
	 */
	int execByHQL(final String hSQL, T[] t);

	/**
	 * 执行自定义hql
	 * @param hSQL hSQL
	 * @param startIndex startIndex
	 * @param pageSize pageSize
	 * @return list
	 */
	List<T> hqlList(String hSQL, int startIndex, int pageSize);

	/**
	 * Hibernate 配置 查询 HQL
	 * 
	 * @param iNameQuery
	 *            String
	 * @return List
	 */
	List<T> findByNamedQuery(final String iNameQuery);

	/**
	 * HQL 查询 ， 带参数
	 * 
	 * @param iQuery
	 *            String
	 * @param param
	 *            P
	 * @return List
	 */
	List<T> findByNamedQuery(final String iQuery, final P param);

	/**
	 * HQL查询， 带多个参数
	 * 
	 * @param iQuery
	 *            String
	 * @param params
	 *            P[]
	 * @return List
	 */
	List<T> findByNamedQuery(final String iQuery, final P[] params);

	/**
	 * HQL 查询 ，构造查询 语句
	 * 
	 * @param iQuery
	 *            String
	 * @return List
	 */
	List<T> findByQuery(final String iQuery);

	/**
	 * 构造HQL 查询语句， 带参数
	 * 
	 * @param iQuery
	 *            String
	 * @param param
	 *            P
	 * @return List
	 */
	List<T> findByQuery(final String iQuery, final P param);

	/**
	 * 构造DetachedCriteria ， 带分页信息
	 * 
	 * @param detachedCriteria
	 *            DetachedCriteria
	 * @return DCriteriaPageSupport
	 */
	DCriteriaPageSupport<T> findPageByCriteria(final DetachedCriteria detachedCriteria);

	/**
	 * DetachedCriteria 带分页信息 ， 指定其实位置
	 * 
	 * @param detachedCriteria
	 *            DetachedCriteria
	 * @param startIndex
	 *            int
	 * @return DCriteriaPageSupport
	 */
	DCriteriaPageSupport<T> findPageByCriteria(final DetachedCriteria detachedCriteria, final int startIndex);

	/**
	 * DetachedCriteria 带分页信息 ，指定开始位置
	 * 
	 * @param detachedCriteria
	 *            DetachedCriteria
	 * @param pageSize
	 *            int
	 * @param startIndex
	 *            int
	 * @return DCriteriaPageSupport
	 */
	DCriteriaPageSupport<T> findPageByCriteria(final DetachedCriteria detachedCriteria, final int pageSize, final int startIndex);

	/**
	 * 
	 * detachedCriteria 查询
	 * 
	 * @param detachedCriteria
	 *            DetachedCriteria
	 * @return List
	 */
	List<T> findAllByCriteria(final DetachedCriteria detachedCriteria);

	/**
	 * detachedCriteria 查询所有记录数
	 * 
	 * @param detachedCriteria
	 *            DetachedCriteria
	 * @return int
	 */
	int getCountByCriteria(final DetachedCriteria detachedCriteria);
	/**
	 * 批量保存对象
	 * @param l
	 */
	public void batchSaveIObject(final List<T> l);
	/**
	 * 批量修改对象
	 * @param l
	 */
	public void batchUpdateIObject(final List<T> l);
}
